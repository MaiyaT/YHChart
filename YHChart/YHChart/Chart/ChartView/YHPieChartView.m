//
//  YHPieChartView.m
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPieChartView.h"

#import "YHChartPieLayer.h"

#import <Masonry.h>


@interface YHPieChartView()

/// 折现图要绘制的视图
@property (strong, nonatomic, readwrite) UIView * chartView;

/// 图层信息
@property (retain, nonatomic) NSMutableArray <YHChartPieLayer *>* pieLayerList;
/// 数据信息
@property (retain, nonatomic, readwrite) NSMutableArray <YHPieChartItem *>* pieInfoList;

/// 底部的圆环
@property (retain, nonatomic) CAShapeLayer * shapeBgLayer;
/// 顶部的圆环
@property (retain, nonatomic) UILabel * centerTopContent;

@end


@implementation YHPieChartView



-(void)yh_commonInit{
    
    self.backgroundColor = [UIColor clearColor];

    self.pieLayerList = [NSMutableArray new];
    self.pieInfoList = [NSMutableArray new];

    self.chartView = [UIView new];
    self.chartView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.chartView];
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat planeWidth = CGRectGetWidth(self.frame);
    CGFloat planeHeight = CGRectGetHeight(self.frame);

    if(planeHeight == 0){
        return;
    }
    
    CGPoint center = CGPointMake(planeWidth*0.5, planeHeight*0.5);
    CGFloat radius = MIN(planeWidth, planeHeight) * 0.5;
    
    if(self.circleBgFillColor){
        if(!self.shapeBgLayer){
            self.shapeBgLayer = [CAShapeLayer new];
            [self.chartView.layer insertSublayer:self.shapeBgLayer atIndex:0];
        }
        self.shapeBgLayer.fillColor = self.circleBgFillColor.CGColor;
        self.shapeBgLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    }
    
    if(self.circleBorderWidth > 0 &&
       self.circleBorderWidth < radius){
        if(!self.centerTopContent){
            self.centerTopContent = [UILabel new];
            self.centerTopContent.numberOfLines = 0;
            self.centerTopContent.textAlignment = NSTextAlignmentCenter;
            self.centerTopContent.layer.masksToBounds = YES;
            [self addSubview:self.centerTopContent];
        }
        CGFloat centerRadius = radius - self.circleBorderWidth;
        self.centerTopContent.layer.cornerRadius = centerRadius;
        self.centerTopContent.backgroundColor = self.circleTopFillColor;
        self.centerTopContent.attributedText = self.circleTopCenterAttTitle;
        [self.centerTopContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.mas_equalTo(centerRadius*2);
        }];
    }else{
        self.circleBorderWidth = 0;
        [self.centerTopContent removeFromSuperview];
        self.centerTopContent = nil;
    }
}

-(void)setCircleBorderWidth:(CGFloat)circleBorderWidth{
    BOOL needChange = (_circleBorderWidth != circleBorderWidth);
    
    _circleBorderWidth = circleBorderWidth;
    
    if(needChange){
        [self layoutSubviews];
    }
}

-(void)setCircleBgFillColor:(UIColor *)circleBgFillColor{
    _circleBgFillColor = circleBgFillColor;
    [self layoutSubviews];
}

-(void)setCircleTopFillColor:(UIColor *)circleTopFillColor{
    _circleTopFillColor = circleTopFillColor;
    [self layoutSubviews];
}

- (CGFloat)pieStartPercent{
    YHPieChartItem * pie = self.pieInfoList.lastObject;
    return pie.endPos;
}

/// 新增一个饼图块 含有针对整个饼块的百分比信息
- (void)addPercentPieBlock:(YHPieChartItem *)pieItem{
    NSAssert(pieItem.percent > 0, @"未设置百分比信息");
    NSAssert(pieItem.percent <= 1, @"百分比不能大于1");
    
    pieItem.startPos = [self pieStartPercent];
    if((pieItem.startPos + pieItem.percent) > 1){
        NSLog(@"百分比超出饼图 不创建");
        return;
    }
    
    [self.pieInfoList addObject:pieItem];
    
    YHChartPieLayer * lineLayer = [YHChartPieLayer new];
    lineLayer.pieItem = pieItem;

    [lineLayer randerPieAtView:self.chartView];
    
    [self.pieLayerList addObject:lineLayer];
}

- (void)deletePieBlock:(YHPieChartItem *)pieItem{
    
    if(![self.pieInfoList containsObject:pieItem]){
        NSLog(@"无该分块信息 不删除");
        return;
    }
    NSInteger index = [self.pieInfoList indexOfObject:pieItem];
    YHChartPieLayer * lineLayer = self.pieLayerList[index];
    [lineLayer clean];
    
    [self.pieInfoList removeObjectAtIndex:index];
    [self.pieLayerList removeObjectAtIndex:index];
    
    YHPieChartItem * prePie = nil;
    for(NSInteger i = 0; i<self.pieInfoList.count; i++){
        YHPieChartItem * pieItem = self.pieInfoList[i];
        YHChartPieLayer * lineLayer = self.pieLayerList[i];
        
        pieItem.startPos = prePie.endPos;
        prePie = pieItem;
        
        [lineLayer reRenderingLayer];
    }
    
}

/// 通过给定的这些分块数据 重置饼图分布 每个块百分比信息这里面重新计算
- (void)resetPieAllBlock:(NSArray <YHPieChartItem *>*)pieList{
    
    pieList = [NSMutableArray arrayWithArray:pieList];
    
    [self clean];

    CGFloat totalValue = 0;
    for(YHPieChartItem * item in pieList){
        totalValue = totalValue + item.value;
    }
    
    totalValue = totalValue * 1.0;
    for(YHPieChartItem * item in pieList){
        item.percent = item.value/totalValue;
        [self addPercentPieBlock:item];
    }
}


/// 数值比例信息显示
- (void)showAllAnnotation:(BOOL)show{
    for(NSInteger i = 0; i<self.pieInfoList.count; i++){
        YHPieChartItem * pieItem = self.pieInfoList[i];
        YHChartPieLayer * lineLayer = self.pieLayerList[i];
        
        pieItem.showAnnotation = show;
        [lineLayer reRenderingLayer];
    }
}
/// 标注点在是否内部显示
- (void)showAllAnnotationInside:(BOOL)inside{
    for(NSInteger i = 0; i<self.pieInfoList.count; i++){
        YHPieChartItem * pieItem = self.pieInfoList[i];
        YHChartPieLayer * lineLayer = self.pieLayerList[i];
        
        pieItem.showAnnotationInside = inside;
        [lineLayer reRenderingLayer];
    }
}

- (void)clean{
    
    for(YHChartPieLayer * lineLayer in self.pieLayerList){
        [lineLayer clean];
    }

    [self.pieInfoList removeAllObjects];
    
    [self.pieLayerList removeAllObjects];
}

@end
