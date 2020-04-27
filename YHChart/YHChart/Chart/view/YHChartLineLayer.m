//
//  YHChartLineLayer.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHChartLineLayer.h"
#import "UIBezierPath+Smoothed.h"

#import <QuartzCore/QuartzCore.h>
#import "YHAxisConvert.h"
#import "YHPointInfoView.h"

#import "YHShapeLayer.h"
#import <Masonry.h>
#import "YHConstant.h"
#import "UIColor+YHStyle.h"

@interface YHChartLineLayer()


@property (retain, nonatomic) UIBezierPath * linePath;

/// 该layer渲染添加到的图层
@property (weak, nonatomic) UIView * renderView;

@property (retain, nonatomic) CAShapeLayer * lineLayer;

@property (retain, nonatomic) CAShapeLayer * shadowLayer;

@property (retain, nonatomic) CAShapeLayer * barLayer;

/// 折线上点的信息
@property (retain, nonatomic) NSMutableArray <YHShapeLayer *>* pointList;

/// 选中折线上点 加载显示的 选中点 和 参考线信息
@property (retain, nonatomic) NSMutableArray <CAShapeLayer *>* pickerPointLayerList;

/// 折线上点 常显 的坐标信息
@property (retain, nonatomic) NSMutableArray <UIView *>* pointInfoViewList;


/// 柱状图线条的信息
@property (retain, nonatomic) NSMutableArray <CAShapeLayer *>* barLineList;


/// 信息弹窗
@property (retain, nonatomic) UIView * pointToastView;

@end

@implementation YHChartLineLayer

- (NSMutableArray<YHShapeLayer *> *)pointList{
    if(!_pointList){
        _pointList = [NSMutableArray new];
    }
    return _pointList;
}

- (NSMutableArray<CAShapeLayer *> *)pickerPointLayerList{
    if(!_pickerPointLayerList){
        _pickerPointLayerList = [NSMutableArray new];
    }
    return _pickerPointLayerList;
}

- (NSMutableArray<UIView *> *)pointInfoViewList{
    if(!_pointInfoViewList){
        _pointInfoViewList = [NSMutableArray new];
    }
    return _pointInfoViewList;
}

- (NSMutableArray<CAShapeLayer *> *)barLineList{
    if(!_barLineList){
        _barLineList = [NSMutableArray new];
    }
    return _barLineList;
}

-(UIBezierPath *)linePath{
    if(!_linePath){
        _linePath = [UIBezierPath new];
    }
    return _linePath;
}


- (void)lineLayerReLayout{
    [self.lineLayer removeFromSuperlayer];
    self.lineLayer = nil;
    
    self.lineLayer = [CAShapeLayer new];
    [self styleLineLayer];
    [self.renderView.layer addSublayer:self.lineLayer];
}

- (void)shadowLayerReLayout{
    [self.shadowLayer removeFromSuperlayer];
    self.shadowLayer = nil;
    
    self.shadowLayer = [CAShapeLayer new];
    self.shadowLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    if(self.lineItem.lineShowShadow){
        [self.lineLayer insertSublayer:self.shadowLayer atIndex:0];
    }
}

- (void)barLayerReLayout{
    [self.barLayer removeFromSuperlayer];
    self.barLayer = nil;
    
    self.barLayer = [CAShapeLayer new];
    self.barLayer.strokeColor = [UIColor clearColor].CGColor;
    self.barLayer.lineWidth = 0;
    self.barLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.renderView.layer addSublayer:self.barLayer];
}

/// 图层渲染到该 视图上
- (void)randerAtView:(UIView *)renderView{
    
    self.renderView = renderView;
    
    [self clean];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        for(YHLinePointItem * point in self.lineItem.dataList){
            [self drawLineByPoint:point];
        }
    });
}

- (void)clean{
    
    [self.linePath removeAllPoints];
    
    [self lineLayerReLayout];
    
    [self shadowLayerReLayout];
    
    [self barLayerReLayout];
    
    [self.pointList makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.pointList removeAllObjects];
    
    [self.barLineList makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.barLineList removeAllObjects];
    
    [self.pointInfoViewList makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.pickerPointLayerList removeAllObjects];
    
    [self cleanPickerToast];
}

- (void)cleanPickerToast{
    [self.pointToastView removeFromSuperview];
    self.pointToastView = nil;
    
    [self.pickerPointLayerList makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.pickerPointLayerList removeAllObjects];
}


/// 添加多个
- (void)addAutoMoveByPointList:(NSArray <YHLinePointItem *>*)pointList{
    
    self.lineItem.isAutoMoveAni = YES;
    
    for(YHLinePointItem * point in pointList){
        [self addPoint:point];
    }
}

/// 添加一个点 显示
- (void)addPoint:(YHLinePointItem *)point{
    
    [self.lineItem addPoint:point];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self drawLineByPoint:point];
        
        if(self.lineItem.isAutoMoveAni){
            ///超出坐标系 X或者Y之后 判断折线移动的方向 移动图层
            ///X 只能一边方向 移动
            ///Y 只能一边方向 移动
            if(self.lineItem.axisType == YHAxisTypeHorizontal){
                //水平方向移动
                
                CGFloat distence = point.valueX - self.axisInfo.axisInfoX.maxValue;

                if(distence > 0){
                    YHAxisElementInfo * axisElementX = [YHAxisConvert queryAxis:self.axisInfo dirtX:self.axisInfo.axisDirectionX dirtY:self.axisInfo.axisDirectionY isAxisX:YES];
                    
                    if(self.lineItem.axisXDirection == YHChartAxisDirection_LeftToRight){
                        //向右移动
                        CGFloat tx = [YHAxisConvert convertValueXToPoint:axisElementX
                                                               axisWidth:CGRectGetWidth(self.renderView.frame)
                                                                  valueX:distence];
                        [UIView animateWithDuration:0.1 animations:^{
                            self.lineLayer.transform = CATransform3DMakeTranslation(-tx, 0, 0);
                        }];
                        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0.7 options:(UIViewAnimationOptionTransitionNone) animations:^{
                            self.barLayer.transform = CATransform3DMakeTranslation(-tx, 0, 0);
                        } completion:^(BOOL finished) {
                            
                        }];
                    }else{
                        CGFloat tx = [YHAxisConvert convertValueXToPoint:axisElementX
                                                               axisWidth:CGRectGetWidth(self.renderView.frame)
                                                                  valueX:distence];
                        [UIView animateWithDuration:0.1 animations:^{
                            self.lineLayer.transform = CATransform3DMakeTranslation(CGRectGetWidth(self.renderView.frame)-tx, 0, 0);
                        }];
                        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0.7 options:(UIViewAnimationOptionTransitionNone) animations:^{
                            self.barLayer.transform = CATransform3DMakeTranslation(CGRectGetWidth(self.renderView.frame)-tx, 0, 0);
                        } completion:^(BOOL finished) {
                            
                        }];
                    }
                }
                
            }else{
                //垂直方向移动
                CGFloat disTop = point.valueY - self.axisInfo.axisInfoY.maxValue;
                CGFloat disBottom = self.axisInfo.axisInfoY.minValue - point.valueY;

                YHAxisElementInfo * axisElementY = [YHAxisConvert queryAxis:self.axisInfo dirtX:self.axisInfo.axisDirectionX dirtY:self.axisInfo.axisDirectionY isAxisX:NO];
                
                if(disTop > 0){
                    //向下移动
                    CGFloat tx = [YHAxisConvert convertValueYToPoint:axisElementY
                                                          axisHeight:CGRectGetHeight(self.renderView.frame) valueY:disTop];
                    
                    if(self.lineItem.axisXDirection == YHChartAxisDirection_BottomToTop){
                        [UIView animateWithDuration:0.1 animations:^{
                            self.lineLayer.transform = CATransform3DMakeTranslation(0, tx, 0);
                        }];
                    }else{
                        [UIView animateWithDuration:0.1 animations:^{
                            self.lineLayer.transform = CATransform3DMakeTranslation(0, -tx, 0);
                        }];
                    }
                }else if (disBottom < 0){
                    //向上移动
                    CGFloat tx = [YHAxisConvert convertValueYToPoint:axisElementY
                                                          axisHeight:CGRectGetHeight(self.renderView.frame) valueY:disBottom];
                    
                    if(self.lineItem.axisXDirection == YHChartAxisDirection_BottomToTop){
                        [UIView animateWithDuration:0.1 animations:^{
                            self.lineLayer.transform = CATransform3DMakeTranslation(0, tx, 0);
                        }];
                    }else{
                        [UIView animateWithDuration:0.1 animations:^{
                            self.lineLayer.transform = CATransform3DMakeTranslation(0, -tx, 0);
                        }];
                    }
                }
            }
        }
        
    });
}


/// 绘制点
- (void)drawLineByPoint:(YHLinePointItem *)point{
        
    CGFloat planeWidth = CGRectGetWidth(self.renderView.frame);
    CGFloat planeHeight = CGRectGetHeight(self.renderView.frame);
    
    CGPoint p = [self getPointAtPanelByValuePoint:CGPointMake(point.valueX, point.valueY)];
    
    if(self.lineItem.showType == YHChartShowType_Bar ||
       self.lineItem.showType == YHChartShowType_BarCombine){

        if(self.lineItem.axisType == YHAxisTypeHorizontal){
            
            CGPoint startPoint = CGPointMake(p.x + self.lineItem.barCenterToScaleOffset, p.y);
            CGPoint endPoint = CGPointMake(startPoint.x, 0);
            
            if(self.lineItem.showType == YHChartShowType_BarCombine){
                //终点位置到他上一条线的开始点
                CGFloat offsetYBegin = [self getPointYOffsetByValuePointY:point.valueY+point.barCombineValueOffset];
                CGFloat offsetYEnd = planeHeight - [self getPointYOffsetByValuePointY:point.barCombineValueOffset];
                
                startPoint.y = offsetYBegin;
                
                switch (self.lineItem.originCoorPos) {
                    case YHChartOriginCoorPos_LeftTop:{
                        endPoint = CGPointMake(startPoint.x, offsetYEnd);
                    }
                        break;
                    case YHChartOriginCoorPos_LeftDown:{
                        endPoint = CGPointMake(startPoint.x, planeHeight-offsetYEnd);
                    }
                            break;
                    case YHChartOriginCoorPos_RightTop:{
                        endPoint = CGPointMake(startPoint.x, offsetYEnd);
                    }
                            break;
                    case YHChartOriginCoorPos_RightDown:{
                        endPoint = CGPointMake(startPoint.x, planeHeight-offsetYEnd);
                    }
                            break;
                    default:
                        break;
                }
            }else if(self.lineItem.showType == YHChartShowType_Bar){
                //终点位置到坐标轴
                switch (self.lineItem.originCoorPos) {
                    case YHChartOriginCoorPos_LeftTop:{
                        endPoint = CGPointMake(startPoint.x, 0);
                    }
                        break;
                    case YHChartOriginCoorPos_LeftDown:{
                        endPoint = CGPointMake(startPoint.x, planeHeight);
                    }
                            break;
                    case YHChartOriginCoorPos_RightTop:{
                        endPoint = CGPointMake(startPoint.x, 0);
                    }
                            break;
                    case YHChartOriginCoorPos_RightDown:{
                        endPoint = CGPointMake(startPoint.x, planeHeight);
                    }
                            break;
                    default:
                        break;
                }
            }
            
            
            UIBezierPath * path = [UIBezierPath bezierPath];
            [path moveToPoint:startPoint];
            [path addLineToPoint:endPoint];
            
            CAShapeLayer * barLayer = [CAShapeLayer new];
            barLayer.path = path.CGPath;
            [self styleBarLayer:barLayer];
            
            [self.barLayer addSublayer:barLayer];
            
            [self.barLineList addObject:barLayer];
            
        }else{

        }
        
        if(self.lineItem.isAutoMoveAni){
            
            CAShapeLayer * lastLayer = self.barLineList.lastObject;
            NSMutableArray * points = [UIBezierPath pointsFromBezierPath:[UIBezierPath bezierPathWithCGPath:lastLayer.path]];
            CGPoint lastPoint = [points.firstObject CGPointValue];
            
            [self.barLineList enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //如果超出屏幕的则把他移除
                NSMutableArray * points = [UIBezierPath pointsFromBezierPath:[UIBezierPath bezierPathWithCGPath:obj.path]];
                CGPoint point = [points.firstObject CGPointValue];
                CGFloat dis = lastPoint.x - point.x;
                if(dis > planeWidth*1.2){
                    
                    [self.barLineList removeObject:obj];
                    [obj removeFromSuperlayer];
                }
            }];
        }
        
        return;
    }
    
    
    //YHChartShowType_Line
    if(self.linePath.isEmpty){
        [self.linePath moveToPoint:p];
    }else{
        [self.linePath addLineToPoint:p];
    }
           
    UIBezierPath * path = self.linePath;
    if(self.lineItem.isAutoMoveAni){
        //如果是自动移动的 移出屏幕的点要移除 berizer要在屏幕里面开始画
        NSMutableArray * points = [UIBezierPath pointsFromBezierPath:path];

        NSMutableArray * avilablePoints = [NSMutableArray new];

        CGPoint lastPoint = [points.lastObject CGPointValue];
        [avilablePoints addObject:@(lastPoint)];

        for(NSNumber * value in [points reverseObjectEnumerator]){
            NSInteger index= [points indexOfObject:value];
            if(index < points.count - 1){
                CGPoint prePoint = [value CGPointValue];
                CGFloat dis = lastPoint.x - prePoint.x;
                [avilablePoints addObject:@(prePoint)];
                if(dis > planeWidth*1.2){
                    
                    break;
                }
            }
        }

        //重新绘制bezier
        UIBezierPath * rePath = [UIBezierPath bezierPath];
        for(NSNumber * value in [avilablePoints reverseObjectEnumerator]){
            if(rePath.isEmpty){
                [rePath moveToPoint:value.CGPointValue];
            }else{
                [rePath addLineToPoint:value.CGPointValue];
            }
        }
        path = rePath;
    }
        
    if(self.lineItem.smoothness){
        // 折线 圆滑
        path = [self.linePath smoothedPathWithGranularity:10 maxY:planeHeight minY:0];
    }
    self.lineLayer.path = path.CGPath;
    
    if(self.lineItem.lineShowShadow){
        
        NSMutableArray * points = [UIBezierPath pointsFromBezierPath:path];
        if(points.count > 1){
            CGPoint firstPoint = [points.firstObject CGPointValue];
            CGPoint lastPoint = [points.lastObject CGPointValue];
            
            [self styleLineShadowLayer];
            
            //设置阴影的path 路径
            UIBezierPath * lineShadowPath = [UIBezierPath bezierPath];
            for(NSInteger i = 0; i<points.count; i++){
                CGPoint point = [points[i] CGPointValue];
                if(lineShadowPath.isEmpty){
                    [lineShadowPath moveToPoint:point];
                }
                else{
                    [lineShadowPath addLineToPoint:point];
                }
            }

            if(self.lineItem.axisType == YHAxisTypeHorizontal){
                switch (self.lineItem.originCoorPos) {
                    case YHChartOriginCoorPos_LeftTop:{
                        [lineShadowPath addLineToPoint:CGPointMake(lastPoint.x, 0)];
                        [lineShadowPath addLineToPoint:CGPointMake(firstPoint.x, 0)];
                    }
                        break;
                    case YHChartOriginCoorPos_LeftDown:{
                        CGFloat maxPosY = planeHeight;
                        [lineShadowPath addLineToPoint:CGPointMake(lastPoint.x, maxPosY)];
                        [lineShadowPath addLineToPoint:CGPointMake(firstPoint.x, maxPosY)];
                    }
                            break;
                    case YHChartOriginCoorPos_RightTop:{
                        [lineShadowPath addLineToPoint:CGPointMake(lastPoint.x, 0)];
                        [lineShadowPath addLineToPoint:CGPointMake(firstPoint.x, 0)];
                    }
                            break;
                    case YHChartOriginCoorPos_RightDown:{
                        CGFloat maxPosY = planeHeight;
                        [lineShadowPath addLineToPoint:CGPointMake(lastPoint.x, maxPosY)];
                        [lineShadowPath addLineToPoint:CGPointMake(firstPoint.x, maxPosY)];
                    }
                            break;
                    default:
                        break;
                }
            }else{

            }
            
            self.shadowLayer.path = lineShadowPath.CGPath;
        }
    }
    
    [self redrawPointShape];
}


/// 重新绘制 所有 坐标点的 信息 是圆点之类
- (void)redrawPointShape{
    
    [self.pointList makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.pointList removeAllObjects];
    
    [self.pointInfoViewList makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.pointInfoViewList removeAllObjects];
    
    if(self.lineItem.pointShow){
        for(YHLinePointItem * item in self.lineItem.dataList){
            item.showPoint = YES;
        }
    }
    if(self.lineItem.coordInfoViewShow){
        for(YHLinePointItem * item in self.lineItem.dataList){
            item.coordInfoViewShow = YES;
        }
    }
    
    CGFloat planeWidth = CGRectGetWidth(self.renderView.frame);
    CGFloat planeHeight = CGRectGetHeight(self.renderView.frame);
    
    CGPoint lastPoint = [self getPointAtPanelByValuePoint:CGPointMake(self.lineItem.dataList.lastObject.valueX, self.lineItem.dataList.lastObject.valueY)];
    CGPoint firstPoint = [self getPointAtPanelByValuePoint:CGPointMake(self.lineItem.dataList.firstObject.valueX, self.lineItem.dataList.firstObject.valueY)];
        
    for(YHLinePointItem * item in self.lineItem.dataList){
        
        CGPoint p = [self getPointAtPanelByValuePoint:CGPointMake(item.valueX, item.valueY)];
        
        //自动移动的可以显示 他有裁剪
        if(!self.lineItem.isAutoMoveAni){
            if(lastPoint.x > planeWidth){
                continue;
            }
            if(firstPoint.x < 0){
                continue;
            }
        }
        
        //显示该点 样式
        if(item.showPoint){
            //添加点显示
            
            YHShapeLayer * pointLayer = [YHShapeLayer new];
            pointLayer.arcCenter = p;
            [self styleLinePointLayer:pointLayer];
            
            [self.lineLayer addSublayer:pointLayer];
            [self.pointList addObject:pointLayer];
        }
        
        //显示该点 坐标信息显示
        if(item.coordInfoViewShow){
            UIView * infoView = nil;
            if(self.lineItem.coordInfoViewShowBlock){
                infoView = self.lineItem.coordInfoViewShowBlock(item);
            }
            
            if(!infoView){
                YHPointInfoView * infoV = [YHPointInfoView new];
                infoV.textTitle.text = [NSString stringWithFormat:@"(%@,%@)",@(item.valueX),@(item.valueY)];
                infoView = infoV;
            }
            
            [self.pointInfoViewList addObject:infoView];
            [self.renderView addSubview:infoView];
            
            CGFloat yBottom = planeHeight - p.y;
            CGFloat xLeft = p.x;
            
            CGFloat space = 5;
            CGFloat centerXMulti = xLeft/(planeWidth*0.5);
            centerXMulti = MAX(0.001, centerXMulti);
            
            [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.renderView).offset(-yBottom - space);
                make.centerX.equalTo(self.renderView).multipliedBy(centerXMulti);
            }];
        }
    }
}


/// 获取该点在面板上对应的坐标点
- (CGPoint)getPointAtPanelByValuePoint:(CGPoint)point{
    
    CGFloat planeWidth = CGRectGetWidth(self.renderView.frame);
    CGFloat planeHeight = CGRectGetHeight(self.renderView.frame);
    
    YHAxisElementInfo * axisElementX = [YHAxisConvert queryAxis:self.axisInfo dirtX:self.lineItem.axisXDirection dirtY:self.lineItem.axisYDirection isAxisX:YES];
    if(self.lineItem.referXOther){
        YHChartAxisPos pos = (axisElementX.axisPosition == YHChartAxisPos_Top)?YHChartAxisPos_Bottom:YHChartAxisPos_Top;
        axisElementX = self.axisInfo.axisPos(pos);
    }
    
    YHAxisElementInfo * axisElementY = [YHAxisConvert queryAxis:self.axisInfo dirtX:self.lineItem.axisXDirection dirtY:self.lineItem.axisYDirection isAxisX:NO];
    if(self.lineItem.referYOther){
        YHChartAxisPos pos = (axisElementY.axisPosition == YHChartAxisPos_Left)?YHChartAxisPos_Right:YHChartAxisPos_Left;
        axisElementY = self.axisInfo.axisPos(pos);
    }
    return [YHAxisConvert convertValueToPoint:axisElementX
                                 axisElementY:axisElementY
                                   axisHeight:planeHeight
                                    axisWidth:planeWidth
                                        value:point];
}

- (CGFloat)getPointYOffsetByValuePointY:(CGFloat)pointY{
    
    CGFloat planeHeight = CGRectGetHeight(self.renderView.frame);
    
    YHAxisElementInfo * axisElementY = [YHAxisConvert queryAxis:self.axisInfo dirtX:self.lineItem.axisXDirection dirtY:self.lineItem.axisYDirection isAxisX:NO];
    if(self.lineItem.referYOther){
        YHChartAxisPos pos = (axisElementY.axisPosition == YHChartAxisPos_Left)?YHChartAxisPos_Right:YHChartAxisPos_Left;
        axisElementY = self.axisInfo.axisPos(pos);
    }
    
    return [YHAxisConvert convertValueYToPoint:axisElementY axisHeight:planeHeight valueY:pointY];
    
}



/// 选中的最接近的点和线  线不是当前线的信息 之前选中的layer清空
- (void)touchPickerNearestLine:(YHLineChartItem *)nearestLine nearestPoint:(YHLinePointItem *)nearestPoint{
    
    [self cleanPickerToast];
    
    if(IsNull(nearestLine) || ![self.lineItem isEqual:nearestLine]){
        return;
    }
    
    CGPoint p = [self getPointAtPanelByValuePoint:CGPointMake(nearestPoint.valueX, nearestPoint.valueY)];
    
    //添加 折线选中点 柱状图选中线 显示
    CGFloat radius = (self.lineItem.pointPicker.radius == 0)?1:self.lineItem.pointPicker.radius;
    
    UIBezierPath * path;
    if(nearestLine.showType == YHChartShowType_Bar ||
       nearestLine.showType == YHChartShowType_BarCombine){
        //视图高度
        if(self.lineItem.pointPicker.barSelectSingle){
            path = [UIBezierPath bezierPathWithRect:CGRectMake(p.x- radius*0.5 + nearestLine.barCenterToScaleOffset, 0, radius, CGRectGetHeight(self.renderView.frame))];
        }else{
            CGFloat width = nearestLine.barScaleTotalWidth;
            path = [UIBezierPath bezierPathWithRect:CGRectMake(p.x- radius*0.5 -width*0.5, 0, radius + width, CGRectGetHeight(self.renderView.frame))];
        }
    }else{
        path = [UIBezierPath bezierPathWithArcCenter:p radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    }
    
    CAShapeLayer * pointLayer = [CAShapeLayer new];
    pointLayer.path = path.CGPath;
    pointLayer.lineWidth = self.lineItem.pointPicker.lineWidth;
    pointLayer.strokeColor = self.lineItem.pointPicker.lineColor.CGColor;
    pointLayer.fillColor = self.lineItem.pointPicker.fillColor.CGColor;
    
    [self.lineLayer addSublayer:pointLayer];
    
    [self.pickerPointLayerList addObject:pointLayer];
    
    //添加选中点位置的参考线
    CGFloat planeWidth = CGRectGetWidth(self.renderView.frame);
    CGFloat planeHeight = CGRectGetHeight(self.renderView.frame);
    
    if(nearestLine.pointPicker.showReflineHorizontal){
        UIBezierPath * linePath = [UIBezierPath new];
        [linePath moveToPoint:CGPointMake(0, p.y)];
        [linePath addLineToPoint:CGPointMake(planeWidth, p.y)];
        
        CAShapeLayer * lineShapeLayer = [CAShapeLayer layer];
        lineShapeLayer.strokeColor = nearestLine.pointPicker.reflineHColor.CGColor;
        lineShapeLayer.lineWidth = nearestLine.pointPicker.reflineHWidth;
        lineShapeLayer.fillColor = [UIColor clearColor].CGColor;
        lineShapeLayer.lineJoin = kCALineJoinRound;
        if(nearestLine.pointPicker.reflineDottedH){
            lineShapeLayer.lineDashPattern = @[@(2),@(2)];
        }
        lineShapeLayer.path = linePath.CGPath;
        [self.lineLayer insertSublayer:lineShapeLayer atIndex:0];
        
        [self.pickerPointLayerList addObject:lineShapeLayer];
    }
    
    if(nearestLine.pointPicker.showReflineVertical){
        UIBezierPath * linePath = [UIBezierPath new];
        [linePath moveToPoint:CGPointMake(p.x, 0)];
        [linePath addLineToPoint:CGPointMake(p.x, planeHeight)];
        
        CAShapeLayer * lineShapeLayer = [CAShapeLayer layer];
        lineShapeLayer.strokeColor = nearestLine.pointPicker.reflineVColor.CGColor;
        lineShapeLayer.lineWidth = nearestLine.pointPicker.reflineVWidth;
        lineShapeLayer.fillColor = [UIColor clearColor].CGColor;
        lineShapeLayer.lineJoin = kCALineJoinRound;
        if(nearestLine.pointPicker.reflineDottedV){
            lineShapeLayer.lineDashPattern = @[@(2),@(2)];
        }
        lineShapeLayer.path = linePath.CGPath;
        [self.lineLayer insertSublayer:lineShapeLayer atIndex:0];
        
        [self.pickerPointLayerList addObject:lineShapeLayer];
    }
    
    if(nearestLine.pointPicker.toastViewBlock){
        self.pointToastView = nearestLine.pointPicker.toastViewBlock(nearestPoint);
        [self.renderView addSubview:self.pointToastView];
        
        CGFloat yTop = p.y;
        CGFloat yBottom = planeHeight - p.y;
        CGFloat xLeft = p.x;
        CGFloat xRight = planeWidth - p.x;
        
        CGFloat space = 5;
        
        [self.pointToastView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(yTop > yBottom){
                //上方
                make.bottom.lessThanOrEqualTo(self.renderView).offset(-yBottom-space);
            }else{
                make.top.greaterThanOrEqualTo(self.renderView).offset(yTop+space);
            }
            if(xLeft > xRight){
                //左
                make.right.lessThanOrEqualTo(self.renderView).offset(-xRight-space);
            }else{
                make.left.greaterThanOrEqualTo(self.renderView).offset(xLeft+space);
            }
        }];
    }
}


#pragma mark - style

/// 更新所有图层 shape 样式
- (void)updateLayersStyle{
    
    //折线图颜色
    [self styleLineLayer];
    
    //柱状图图颜色
    for(CAShapeLayer * barLayer in self.barLineList){
        [self styleBarLayer:barLayer];
    }
    
    //折线阴影颜色
    [self styleLineShadowLayer];
    
    //折线点颜色样式
    for(YHShapeLayer * pointLayer in self.pointList){
        [self styleLinePointLayer:pointLayer];
    }
    
}

- (void)styleLineLayer{
    
    self.lineLayer.strokeColor = self.lineItem.lineColor.CGColor;
    self.lineLayer.lineWidth = self.lineItem.lineWidth;
    self.lineLayer.fillColor = [UIColor clearColor].CGColor;
    if(self.lineItem.dotted){
        self.lineLayer.lineDashPattern = @[@(2),@(2)];
    }
}

- (void)styleBarLayer:(CAShapeLayer *)barLayer{
    barLayer.lineWidth = self.lineItem.lineWidth;
    barLayer.strokeColor = self.lineItem.lineColor.CGColor;
}

- (void)styleLineShadowLayer{
    
    CGFloat planeHeight = CGRectGetHeight(self.renderView.frame);
    
    if(self.lineItem.lineShadowColorFill){
        self.shadowLayer.fillColor = self.lineItem.lineShadowColorFill.CGColor;
    }else if (self.lineItem.lineShadowColorTop && self.lineItem.lineShadowColorBottom){
        UIColor * shadowColor = [UIColor yh_gradientFroYHolor:self.lineItem.lineShadowColorBottom toColor:self.lineItem.lineShadowColorTop withHeight:planeHeight+1];
        self.shadowLayer.fillColor = shadowColor.CGColor;
    }else{
        self.shadowLayer.fillColor = [UIColor clearColor].CGColor;
    }
}

- (void)styleLinePointLayer:(YHShapeLayer *)pointLayer{
    CGFloat radius = (self.lineItem.pointRadius == 0)?1:self.lineItem.pointRadius;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:pointLayer.arcCenter radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    pointLayer.path = path.CGPath;
    pointLayer.lineWidth = self.lineItem.pointLineWidth;
    pointLayer.strokeColor = self.lineItem.pointLineColor.CGColor;
    pointLayer.fillColor = self.lineItem.pointFillColor.CGColor;
}

#pragma mark -

@end
