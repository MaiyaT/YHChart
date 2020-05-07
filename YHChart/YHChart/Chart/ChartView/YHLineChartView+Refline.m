//
//  YHLineChartView+Refline.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/17.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLineChartView+Refline.h"
#import "YHAxisConvert.h"
#import "UIColor+YHStyle.h"

/// 参考线图层数组
//@property (retain, nonatomic) NSMutableArray <CAShapeLayer *>* reflineLayerList;


@implementation YHLineChartView (Refline)

//@dynamic reflineList;


/// 添加所有 有设置Y轴的标题的参考线 先设置X 和 Y轴的刻度信息
- (void)addReflineAllAxisPos:(YHChartAxisPos)position config:(void (^)(YHReflineInfo * _Nonnull))config{
    
    void(^randerRefline)(YHChartAxisPos pos) = ^(YHChartAxisPos pos) {
        
        YHAxisElementInfo * axisInfo = self.axisInfo.axisPos(pos);
        
        for(YHScaleItem * item in axisInfo.list){
            //最小值最大值不设置他的参考线
            if(item.value <= axisInfo.minValue || item.value >= axisInfo.maxValue){
                continue;
            }
            YHChartAxisDirection dirtX,dirtY;
            
            YHReflineInfo * info = [YHReflineInfo new];
            if(axisInfo.isAxisX){
                info.showVertical = YES;
                info.axisXValue = item.value;
                dirtX = axisInfo.axisDirction;
                dirtY = self.axisInfo.axisDirectionY;
            }else{
                info.showHorizontal = YES;
                info.axisYValue = item.value;
                dirtY = axisInfo.axisDirction;
                dirtX = self.axisInfo.axisDirectionX;
            }
            info.isDotted = YES;
            info.lineColor = [UIColor yh_title_h3_note];
            info.lineHeight = 0.5;
            if(config){
                config(info);
            }
            [self addRefline:info dirtX:dirtX dirtY:dirtY];
        }
    };
    
    if(position & YHChartAxisPos_Top){
        randerRefline(YHChartAxisPos_Top);
    }
    
    if(position & YHChartAxisPos_Bottom){
        randerRefline(YHChartAxisPos_Bottom);
    }
    
    if(position & YHChartAxisPos_Left){
        randerRefline(YHChartAxisPos_Left);
    }
    
    if(position & YHChartAxisPos_Bottom){
        randerRefline(YHChartAxisPos_Bottom);
    }
    
}

/// 添加X和Y四边的轴线
- (void)addReflineAxisPosition:(YHChartAxisPos)position width:(CGFloat)width color:(UIColor *)color dotted:(BOOL)dot{
    
    //当前坐标轴方向
    YHChartAxisDirection dirtX = self.axisInfo.axisDirectionX;
    YHChartAxisDirection dirtY = self.axisInfo.axisDirectionY;
        
    YHAxisElementInfo * axisX = self.axisInfo.axisInfoX;
    YHAxisElementInfo * axisY = self.axisInfo.axisInfoY;
    
    
    if(position & YHChartAxisPos_Top){
        YHReflineInfo * info = [YHReflineInfo new];
        info.isDotted = dot;
        info.lineColor = color;
        info.lineHeight = width;
        
        info.showVertical = NO;
        info.showHorizontal = YES;
        if(dirtX == YHChartAxisDirection_LeftToRight){
            info.axisXValue = axisX.minValue;
        }else{
            info.axisXValue = axisX.maxValue;
        }
        if(dirtY == YHChartAxisDirection_TopToBottom){
            info.axisYValue = axisY.minValue;
        }else{
            info.axisYValue = axisY.maxValue;
        }
        
        [self addRefline:info dirtX:dirtX dirtY:dirtY];
    }
    
    if(position & YHChartAxisPos_Bottom){
        YHReflineInfo * info = [YHReflineInfo new];
        info.isDotted = dot;
        info.lineColor = color;
        info.lineHeight = width;
        
        info.showVertical = NO;
        info.showHorizontal = YES;
        if(dirtX == YHChartAxisDirection_LeftToRight){
            info.axisXValue = axisX.minValue;
        }else{
            info.axisXValue = axisX.maxValue;
        }
        if(dirtY == YHChartAxisDirection_TopToBottom){
            info.axisYValue = axisY.maxValue;
        }else{
            info.axisYValue = axisY.minValue;
        }
        [self addRefline:info dirtX:dirtX dirtY:dirtY];
    }
    
    if(position & YHChartAxisPos_Left){
        YHReflineInfo * info = [YHReflineInfo new];
        info.isDotted = dot;
        info.lineColor = color;
        info.lineHeight = width;
        
        info.showVertical = YES;
        info.showHorizontal = NO;
        if(dirtX == YHChartAxisDirection_LeftToRight){
            info.axisXValue = axisX.minValue;
        }else{
            info.axisXValue = axisX.maxValue;
        }
        if(dirtY == YHChartAxisDirection_TopToBottom){
            info.axisYValue = axisY.minValue;
        }else{
            info.axisYValue = axisY.maxValue;
        }
        [self addRefline:info dirtX:dirtX dirtY:dirtY];
    }
    
    if(position & YHChartAxisPos_Right){
        YHReflineInfo * info = [YHReflineInfo new];
        info.isDotted = dot;
        info.lineColor = color;
        info.lineHeight = width;
        
        info.showVertical = YES;
        info.showHorizontal = NO;
        if(dirtX == YHChartAxisDirection_LeftToRight){
            info.axisXValue = axisX.maxValue;
        }else{
            info.axisXValue = axisX.minValue;
        }
        if(dirtY == YHChartAxisDirection_TopToBottom){
            info.axisYValue = axisY.minValue;
        }else{
            info.axisYValue = axisY.maxValue;
        }
        [self addRefline:info dirtX:dirtX dirtY:dirtY];
    }
}

- (void)addReflineConfig:(void(^)(YHReflineInfo * refline))config{
    YHReflineInfo * refline = [YHReflineInfo new];
    if(config){
        config(refline);
    }
    [self addRefline:refline dirtX:self.axisInfo.axisDirectionX dirtY:self.axisInfo.axisDirectionY];
}

- (void)addRefline:(YHReflineInfo *)refline
             dirtX:(YHChartAxisDirection)dirtX
             dirtY:(YHChartAxisDirection)dirtY{
    
    [self.reflineList addObject:refline];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //添加参考线
        UIBezierPath * linePath;
        //水平
        if(refline.showHorizontal){
            linePath = [UIBezierPath new];
            YHAxisElementInfo * axisElementY = [YHAxisConvert queryAxis:self.axisInfo dirtX:dirtX dirtY:dirtY isAxisX:NO];
            CGFloat pointY = [YHAxisConvert convertValueYToPoint:axisElementY
                                                      axisHeight:CGRectGetHeight(self.chartView.frame) valueY:refline.axisYValue];
            if(pointY < 0 || pointY > CGRectGetHeight(self.chartView.frame)){
                return;
            }
            [linePath moveToPoint:CGPointMake(0, pointY)];
            [linePath addLineToPoint:CGPointMake(CGRectGetWidth(self.chartView.frame), pointY)];
        }
        
        //垂直
        if(refline.showVertical){
            linePath = [UIBezierPath new];
            YHAxisElementInfo * axisElementX = [YHAxisConvert queryAxis:self.axisInfo dirtX:dirtX dirtY:dirtY isAxisX:YES];
            CGFloat pointX = [YHAxisConvert convertValueXToPoint:axisElementX
                                                       axisWidth:CGRectGetWidth(self.chartView.frame)
                                                          valueX:refline.axisXValue];
            if(pointX < 0 || pointX > CGRectGetWidth(self.chartView.frame)){
                return;
            }
            [linePath moveToPoint:CGPointMake(pointX, 0)];
            [linePath addLineToPoint:CGPointMake(pointX, CGRectGetHeight(self.chartView.frame))];
        }
        
        if(linePath){
            CAShapeLayer * reflineShapeLayer = [CAShapeLayer layer];
            reflineShapeLayer.strokeColor = refline.lineColor.CGColor;
            reflineShapeLayer.lineWidth = refline.lineHeight;
            reflineShapeLayer.fillColor = [UIColor clearColor].CGColor;
            reflineShapeLayer.lineJoin = kCALineJoinRound;
            if(refline.isDotted){
                reflineShapeLayer.lineDashPattern = @[@(2),@(2)];
            }
            reflineShapeLayer.path = linePath.CGPath;
            [self.chartView.layer insertSublayer:reflineShapeLayer atIndex:0];
            
            [self.reflineLayerList addObject:reflineShapeLayer];
        }
    });
}

/// 重新渲染参考线
- (void)reRenderingReline{
    NSMutableArray * listRefline = self.reflineList.mutableCopy;
    
    [self.reflineList removeAllObjects];
    [self.reflineLayerList makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.reflineLayerList removeAllObjects];
    
    for(YHReflineInfo * info in listRefline){
        [self addRefline:info dirtX:self.axisInfo.axisDirectionX dirtY:self.axisInfo.axisDirectionY];
    }
}



@end
