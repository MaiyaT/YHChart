//
//  YHLineChartView.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/9.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLineChartView.h"
#import "YHLineChartView+AxisTitleView.h"
#import "YHLineChartView+BarGraph.h"
#import "YHLineChartView+Refline.h"

#import "YHChartLineLayer.h"
#import "YHAxisConvert.h"
#import <Masonry.h>

@interface YHLineChartView()

/// 折现图要绘制的视图
@property (strong, nonatomic, readwrite) UIView * chartView;

/// 折线的图层信息
@property (retain, nonatomic) NSMutableArray <YHChartLineLayer *>* lineLayerList;
/// 折线的数据信息
@property (retain, nonatomic, readwrite) NSMutableArray <YHLineChartItem *>* lineInfoList;
@property (retain, nonatomic) NSMutableArray <YHLineChartItem *>* lineSupportPickerPointList;


@property (retain, nonatomic) UITapGestureRecognizer * tapGesture;
@property (retain, nonatomic) UIPanGestureRecognizer * panGesture;

/// 坐标轴信息 x: 0-10  y: 0-10
@property (retain, nonatomic, readwrite) YHAxisInfo * axisInfo;


@end

@implementation YHLineChartView

-(void)yh_commonInit{
    
    self.backgroundColor = [UIColor clearColor];

    self.lineLayerList = [NSMutableArray new];
    self.lineInfoList = [NSMutableArray new];

    self.axisInfo = [YHAxisInfo new];
    
    self.reflineList = [NSMutableArray new];
    self.reflineLayerList = [NSMutableArray new];
    
    self.chartView = [UIView new];
    self.chartView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.chartView];
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateChange) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
//    self.chartView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.05];
}


- (void)rotateChange{
    
    /// 重新渲染参考线
    [self reRenderingReline];
    
    /// 重新渲染折线图
    for(YHChartLineLayer * lineLayer in self.lineLayerList){
        [lineLayer reRenderingLayer];
    }
}


-(NSInteger)lineLayerCount{
    return self.lineInfoList.count;
}

- (void)cleanChartView{
    
    for(UIView * subView in self.subviews){
        if(![subView isEqual:self.chartView]){
            [subView removeFromSuperview];
        }
    }
    [self.chartView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.chartView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    [self.lineLayerList removeAllObjects];
    [self.lineInfoList removeAllObjects];
    
    [self.lineSupportPickerPointList removeAllObjects];
    
    [self cleanGesture];
}

/// 坐标轴信息
/// @param scaleList 刻度信息
/// @param width 坐标轴刻度标题显示宽度大小 可为0 为0 刻度信息显示在坐标轴内部
/// @param position 坐标轴位置
/// @param dirction 坐标轴 值的方向

- (void)updateAxisScaleList:(NSArray <YHScaleItem *>*)scaleList
                      width:(CGFloat)width
                   position:(YHChartAxisPos)position
                   dirction:(YHChartAxisDirection)dirction{
    [self updateAxisScaleList:scaleList
                        width:width
                     position:position
                     dirction:dirction
                       config:nil];
}

- (void)updateAxisAutoScaleCount:(NSInteger)scaleCount
                       pointList:(NSArray <YHLinePointItem *>*)pointList
                          format:(id<YHFormatProtocol> _Nullable)format
                           width:(CGFloat)width
                        position:(YHChartAxisPos)position
                        dirction:(YHChartAxisDirection)dirction
                          config:(void(^_Nullable)(YHAxisElementInfo * axisInfo))config{
    
    BOOL isHorizontal = (dirction == YHChartAxisDirection_LeftToRight ||
                       dirction == YHChartAxisDirection_RightToLeft);
    CGFloat maxValue = 0, minValue = FLT_MAX;
    for(YHLinePointItem * item in pointList){
        if(isHorizontal){
            maxValue = MAX(maxValue, item.valueX);
            minValue = MIN(minValue, item.valueX);
        }else{
            maxValue = MAX(maxValue, item.valueY);
            minValue = MIN(minValue, item.valueY);
        }
    }
    CGFloat s = maxValue - minValue;
    if(!isHorizontal){
        maxValue = maxValue + s*0.1;
        if(minValue >=0 ){
            minValue = minValue - s*0.1;
            minValue = MAX(minValue, 0);
        }else{
            minValue = minValue - s*0.1;
        }
    }
    s = maxValue - minValue;
    
    
    NSMutableArray * scaleList = [NSMutableArray new];
    NSInteger n = scaleCount - 1;
    if(scaleCount == 3 || scaleCount == 4 || scaleCount == 5){
        n = 4;
    }else if (scaleCount == 2 || scaleCount == 1){
        n = scaleCount + 1;
    }else if(scaleCount == 0){
        n = 0;
    }
    
    if(n > 0){
        CGFloat mn = s/(n*1.0);
        
        NSInteger(^mnAdjuest)(NSInteger value) = ^NSInteger(NSInteger value) {
            NSInteger mn_c = @(value).stringValue.length;
            NSInteger pow_10 = pow(10, mn_c-1);
            NSInteger mn_z = value/pow_10;
            NSInteger mn_y = value%pow_10;
            
            NSInteger mn_1 = mn_z * pow_10;
            NSInteger mn_2 = 0;
            
            CGFloat mn_m = mn_y/(mn_1 * 1.0);
            if(mn_m > 0.8){
                mn_2 = mn_1 * 0.8;
            }
            else if(mn_m > 0.55){
                mn_2 = mn_1 * 0.6;
            }
            else if(mn_m > 0.45){
                mn_2 = mn_1 * 0.5;
            }
            else if(mn_m > 0.4){
                mn_2 = mn_1 * 0.4;
            }
            else if(mn_m > 0.2){
                mn_2 = mn_1 * 0.2;
            }
            NSInteger newValue = mn_1 + mn_2;
            return newValue;
        };
        
        if(mn >= 1){
            mn = mnAdjuest(ceil(mn));
        }else if(mn > 0){
            CGFloat mutil = mn * pow(10, 6) * 1.0;
            mn = mnAdjuest(ceil(mutil));
            mn = mn / (pow(10, 6) * 1.0);
        }else if (mn > -1){
            CGFloat mutil = mn * pow(10, 6) * -1.0;
            mn = mnAdjuest(ceil(mutil));
            mn = mn / (pow(10, 6) * -1.0);
        }else{
            mn = mnAdjuest(ceil(mn*-1.0)) * -1.0;
        }
        
        if(scaleCount > 3){
            YHScaleItem * item = [YHScaleItem new];
            item.value = minValue;
            item.format = format;
            [scaleList addObject:item];
        }
        CGFloat posValue = minValue + mn;
        while (posValue < (maxValue - mn*0.2)) {
            YHScaleItem * item = [YHScaleItem new];
            item.value = posValue;
            item.format = format;
            [scaleList addObject:item];
            
            posValue = posValue + mn;
        }
        if(maxValue > (posValue - mn*0.1) &&
           scaleCount > 4){
            YHScaleItem * item = [YHScaleItem new];
            item.value = maxValue;
            item.format = format;
            [scaleList addObject:item];
        }
    }
    
    [self updateAxisScaleList:scaleList
                        width:width
                     position:position
                     dirction:dirction
                       config:^(YHAxisElementInfo * _Nonnull axisInfo) {
    
        if(config){
            config(axisInfo);
        }
        
        axisInfo.isAutoScale = YES;
        axisInfo.scaleCount = scaleCount;
        axisInfo.maxValue = maxValue;
        axisInfo.minValue = minValue;
    }];
}

- (void)updateAxisScaleList:(NSArray <YHScaleItem *>*)scaleList
                      width:(CGFloat)width
                   position:(YHChartAxisPos)position
                   dirction:(YHChartAxisDirection)dirction
                     config:(void (^ _Nullable)(YHAxisElementInfo * _Nonnull))config{
    
    if(position == YHChartAxisPos_Unknow ||
       dirction == YHChartAxisDirection_Unknow){
        NSLog(@"======== error ====== 坐标轴设置有误");
        NSAssert(NO, @" 坐标轴设置有误");
        return;
    }
    
    if(position == YHChartAxisPos_Top ||
       position == YHChartAxisPos_Bottom){
        //上下两边的 X 轴的坐标轴 方向是左右方向
        if(dirction != YHChartAxisDirection_LeftToRight &&
           dirction != YHChartAxisDirection_RightToLeft){
            NSLog(@"======== error ====== 坐标轴方向跟位置不符");
            NSAssert(NO, @" 坐标轴方向跟位置不符");
            return;
        }
    }else{
        //左右两边的 Y 轴的坐标轴 方向是上下方向
        if(dirction != YHChartAxisDirection_BottomToTop &&
           dirction != YHChartAxisDirection_TopToBottom){
            NSLog(@"======== error ====== 坐标轴方向跟位置不符");
            NSAssert(NO, @" 坐标轴方向跟位置不符");
            return;
        }
    }
    
    NSAssert(scaleList.count > 0, @" 未设置坐标轴刻度信息");
    
    CGFloat maxValue = 0, minValue = FLT_MAX;
    for(YHScaleItem * item in scaleList){
        maxValue = MAX(maxValue, item.value);
        minValue = MIN(minValue, item.value);
    }
    
    YHAxisElementInfo * axisInfo = self.axisInfo.axisPos(position);
    axisInfo.maxValue = maxValue;
    axisInfo.minValue = minValue;
    axisInfo.axisDirction = dirction;
    [axisInfo cleanScale];
    [axisInfo addScaleList:scaleList];
    axisInfo.titleWidth = width;
    if(config){
        config(axisInfo);
    }
    
    switch (position) {
        case YHChartAxisPos_Top:{
            [self.chartView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(width);
            }];
        }
            break;
        case YHChartAxisPos_Bottom:{
            [self.chartView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(-width);
            }];
        }
            break;
        case YHChartAxisPos_Left:{
            [self.chartView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(width);
            }];
        }
            break;
        case YHChartAxisPos_Right:{
            [self.chartView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-width);
            }];
        }
            break;
        default:
            break;
    }
    
    
    //添加刻度标题
    [self updateScaleInfoAtPosition:position];
}


- (void)addLineChart:(YHLineChartItem *)lineItem{
    
    if(lineItem.isAutoMoveAni){
        self.chartView.clipsToBounds = YES;
        self.chartView.layer.masksToBounds = YES;
    }
    
    YHChartLineLayer * lineLayer = [YHChartLineLayer new];
    lineLayer.axisInfo = self.axisInfo;
    lineLayer.lineItem = lineItem;
    // 设置折线的 参考坐标轴位置
    if(lineItem.axisXDirection == YHChartAxisDirection_Unknow ||
       lineItem.axisYDirection == YHChartAxisDirection_Unknow){
        [lineItem updateLineReferenceAxisXDirection:self.axisInfo.axisDirectionX axisYDirection:self.axisInfo.axisDirectionY];
    }
    
    [self.lineLayerList addObject:lineLayer];
    [self.lineInfoList addObject:lineItem];
    
    [self barCombineValueOffsetUpdate];
    
    [lineLayer randerAtView:self.chartView];
    
    //获取可点击 选择操作的折线
    for(YHLineChartItem * item in self.lineInfoList){
        //自动移动的不可点击
        if(!item.isAutoMoveAni && item.pointPicker.canSelect){
            if(![self.lineSupportPickerPointList containsObject:item]){
                [self.lineSupportPickerPointList addObject:item];
            }
        }
    }
    [self addGesture];
}

/// 更新某一条折线数据
- (void)updateLineChart:(YHLineChartItem *)lineItem{
    for(YHLineChartItem * item in self.lineInfoList){
        if([item isEqual:lineItem]){
            NSInteger index = [self.lineInfoList indexOfObject:lineItem];
            YHChartLineLayer * lineLayer = self.lineLayerList[index];
            
            [self barCombineValueOffsetUpdate];
            
            [lineLayer randerAtView:self.chartView];
            break;
        }
    }
    
    NSArray <YHLineChartItem *>* barCombineList = [self getBarCombineList];
    for(YHLineChartItem * lineItem in barCombineList){
        NSInteger index = [self.lineInfoList indexOfObject:lineItem];
        YHChartLineLayer * lineLayer = self.lineLayerList[index];
        [lineLayer reRenderingLayer];
    }
}

/// 更新某一条折线数据 不重新绘制 改变颜色 粗细之类
- (void)updateLineChartUnRelayout:(YHLineChartItem *)lineItem{
    for(YHLineChartItem * item in self.lineInfoList){
        if([item isEqual:lineItem]){
            NSInteger index = [self.lineInfoList indexOfObject:lineItem];
            YHChartLineLayer * lineLayer = self.lineLayerList[index];
            [lineLayer updateLayersStyle];
            break;
        }
    }
}
/// 删除某一条折线数据
- (void)removeLineChart:(YHLineChartItem *)lineItem{
    [self.lineInfoList enumerateObjectsUsingBlock:^(YHLineChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isEqual:lineItem]){
            YHChartLineLayer * lineLayer = self.lineLayerList[idx];
            [lineLayer clean];
            [lineLayer cleanPickerToast];
            
            [self.lineLayerList removeObjectAtIndex:idx];
            [self.lineInfoList removeObject:lineItem];
            [self.lineSupportPickerPointList removeObject:lineItem];

            [self barCombineValueOffsetUpdate];
            
            *stop = YES;
        }
    }];
    
    [self.lineInfoList enumerateObjectsUsingBlock:^(YHLineChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.showType == YHChartShowType_BarCombine){
            [self updateLineChart:obj];
        }
    }];
}

/// 或者第几条折线
- (YHLineChartItem *)getLineChartIndex:(NSInteger)index{
    if(index >= self.lineInfoList.count){
        NSLog(@"没找到 该条折线信息");
        return nil;
    }
    return self.lineInfoList[index];
}


/// 新增点 如果点在屏幕右侧超出 屏幕的时候 自动向左移动
- (void)addAutoMoveByPointList:(NSArray <YHLinePointItem *>*)pointList lineInfoAtLine:(NSInteger)index{
    
    if(index >= self.lineLayerList.count){
        NSLog(@"越界了 没有该条 折线信息");
        return;
    }
    
    //往后附加折线
    YHChartLineLayer * lineLayer = self.lineLayerList[index];
    [lineLayer addAutoMoveByPointList:pointList];
    
    
    
//    //往后附加X轴的标题
//    for(YHLinePointItem * point in pointList){
//        YHScaleItem * scale = [YHScaleItem new];
//        scale.attString = point.axisXAttTitle;
//        scale.value = point.valueX;
//        [self autoAddScaleInfoInAxisXByItem:scale];
//    }
}



#pragma mark - 选择点

- (NSArray<YHLineChartItem *> *)lineSupportPickerPointList{
    if(!_lineSupportPickerPointList){
        _lineSupportPickerPointList = [NSMutableArray new];
    }
    return _lineSupportPickerPointList;
}

- (void)cleanGesture{
    
    [self.chartView removeGestureRecognizer:self.tapGesture];
    [self.chartView removeGestureRecognizer:self.panGesture];
    
    self.tapGesture = nil;
    self.panGesture = nil;
}

//添加点击 拖拽手势
- (void)addGesture{
    [self cleanGesture];
    
    if(self.lineSupportPickerPointList.count == 0){
        return;
    }
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChartGesture)];
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panChartGesture)];
    
    [self.chartView addGestureRecognizer:self.tapGesture];
    [self.chartView addGestureRecognizer:self.panGesture];
}

- (void)tapChartGesture{
    CGPoint p = [self.tapGesture locationInView:self.chartView];
    [self pickerPointShowAtLocation:p];
}

- (void)panChartGesture{
    CGPoint p = [self.panGesture locationInView:self.chartView];
    [self pickerPointShowAtLocation:p];
}

- (void)pickerPointShowAtLocation:(CGPoint)location{
    if (location.x < 0 || location.x > CGRectGetWidth(self.chartView.frame)){
        return;
    }
    if (location.y < 0 || location.y > CGRectGetHeight(self.chartView.frame)){
        return;
    }
    
    YHLineChartItem * nearestLine = nil;//最接近的线
    YHLinePointItem * nearestPoint = nil;//最接近的点
    
    
    //用坐标点来计算比较准确 通过数值大小 数值的坐标来比较 不准确
    CGFloat minDistence = FLT_MAX;
    for(YHLineChartItem * line in self.lineSupportPickerPointList){
        if(!nearestLine){
            nearestLine = line;
        }
        
        /// 获取参考坐标轴信息
        YHAxisElementInfo * axisElementX = [YHAxisConvert queryAxis:self.axisInfo dirtX:self.axisInfo.axisDirectionX dirtY:self.axisInfo.axisDirectionY isAxisX:YES];
        if(line.referXOther){
            YHChartAxisPos pos = (axisElementX.axisPosition == YHChartAxisPos_Top)?YHChartAxisPos_Bottom:YHChartAxisPos_Top;
            axisElementX = self.axisInfo.axisPos(pos);
        }
        
        YHAxisElementInfo * axisElementY = [YHAxisConvert queryAxis:self.axisInfo dirtX:self.axisInfo.axisDirectionX dirtY:self.axisInfo.axisDirectionY isAxisX:NO];
        if(line.referYOther){
            YHChartAxisPos pos = (axisElementY.axisPosition == YHChartAxisPos_Left)?YHChartAxisPos_Right:YHChartAxisPos_Left;
            axisElementY = self.axisInfo.axisPos(pos);
        }
        
        for(YHLinePointItem * point in line.dataList){

            CGPoint itemPoint = [YHAxisConvert convertValueToPoint:axisElementX
                                                      axisElementY:axisElementY
                                                        axisHeight:CGRectGetHeight(self.chartView.frame)
                                                         axisWidth:CGRectGetWidth(self.chartView.frame)
                                                             value:CGPointMake(point.valueX, point.valueY)];
            
            CGFloat distence = FLT_MAX;
            if(line.showType == YHChartShowType_Bar ||
               line.showType == YHChartShowType_BarCombine){
                //柱状图的话 比较 X轴的位置
                //加上偏移
                itemPoint.x = itemPoint.x + line.barCenterToScaleOffset;
                distence = ABS(itemPoint.x - location.x);
            }else{
                distence = YHPointDist(itemPoint,location);
            }
            
            if(!nearestPoint || distence < minDistence){
                minDistence = distence;
                nearestLine = line;
                nearestPoint = point;
            }
        }
    }

    
    for(YHChartLineLayer * lineLayer in self.lineLayerList){
        [lineLayer touchPickerNearestLine:nearestLine nearestPoint:nearestPoint];
    }
}

- (void)pickerPointAtHiddenTouchs:(NSSet<UITouch *> *)touches{

}



#pragma mark -
/// 清空所有信息
- (void)clean{
    
    [self.axisInfo clean];
    
    [self cleanChartView];
    
    [self.chartView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

@end
