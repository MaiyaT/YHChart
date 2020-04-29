//
//  YHChartsDeBugViewController3.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController3.h"

@interface YHChartsDeBugViewController3 ()

@end

@implementation YHChartsDeBugViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    YHLineChartView * chartView3 = [YHLineChartView new];
        
    NSMutableArray * scaleList = [NSMutableArray new];
    
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"10") value:10]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"20") value:20]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"30") value:30]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"40") value:40]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"50") value:50]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"60") value:60]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"70") value:70]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"80") value:80]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"90") value:90]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"100") value:100]];
    [chartView3 updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.minValue = 0;
    }];
    
    
    [scaleList removeAllObjects];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"10") value:10]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"20") value:20]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"30") value:30]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"40") value:40]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"50") value:50]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"60") value:60]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"70") value:70]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"80") value:80]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"90") value:90]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"100") value:100]];
    [chartView3 updateAxisScaleList:scaleList width:30 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.minValue = 0;
    }];
    
    [chartView3 addReflineAxisPosition:(YHChartAxisPos_Left) width:1 color:[UIColor yh_title_h1] dotted:NO];
    [chartView3 addReflineAxisPosition:(YHChartAxisPos_Bottom) width:1 color:[UIColor yh_title_h1] dotted:NO];
    [chartView3 addReflineConfig:^(YHReflineInfo * _Nonnull refline) {
        refline.showHorizontal = YES;
        refline.axisYValue = 30;
    }];
    [chartView3 addReflineConfig:^(YHReflineInfo * _Nonnull refline) {
        refline.showHorizontal = YES;
        refline.axisYValue = 60;
    }];
    
    YHLineChartItem * item = [YHLineChartItem new];
    item.lineColor = [UIColor yh_blue];
    [item addPointList:@[
        [YHLinePointItem valueX:0 valueY:10],
        [YHLinePointItem valueX:10 valueY:arc4random()%100],
        [YHLinePointItem valueX:20 valueY:arc4random()%100],
        [YHLinePointItem valueX:30 valueY:arc4random()%100],
        [YHLinePointItem valueX:40 valueY:arc4random()%100],
        [YHLinePointItem valueX:50 valueY:arc4random()%100],
        [YHLinePointItem valueX:60 valueY:arc4random()%100],
        [YHLinePointItem valueX:70 valueY:arc4random()%100],
        [YHLinePointItem valueX:90 valueY:arc4random()%100],
        [YHLinePointItem valueX:100 valueY:30],
    ]];
    item.pointFillColor = [UIColor whiteColor];
    item.pointLineColor = [UIColor yh_blue];
    item.pointLineWidth = 1;
    item.pointRadius = 3;
    item.pointShow = YES;
    item.pointPicker.canSelect = YES;
    item.pointPicker.radius = 4;
    item.pointPicker.fillColor = [UIColor yh_blue];
    item.pointPicker.lineWidth = 0;
    item.pointPicker.showReflineVertical = YES;
    item.pointPicker.showReflineHorizontal = YES;
    item.pointPicker.reflineHColor = [UIColor yh_blue];
    item.pointPicker.reflineVColor = [UIColor yh_blue];
    item.pointPicker.reflineDottedH = YES;
    item.pointPicker.reflineDottedV = YES;
    [item.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
        YHPointToastView * toastView = [YHPointToastView new];
        NSString * contentY = [NSString stringWithFormat:@"Y轴: %lf",passPoint.valueY];
        NSString * contentX = [NSString stringWithFormat:@" X轴: %lf",passPoint.valueX];
        NSString * content = [NSString stringWithFormat:@"%@\n%@",contentY,contentX];
        toastView.textTitle.attributedText = [NSMutableAttributedString yh_initWithStr:content customBlock:^(NSMutableAttributedString *att) {
            [att yh_attachImage:[UIImage imageNamed:@"message_icon1"] imageSize:CGSizeMake(14, 14) atIndex:contentY.length+1];
        }];
        return toastView;
    }];
    [chartView3 addLineChart:item];


    item = [YHLineChartItem new];
    item.lineColor = [UIColor yh_green];
    [item addPointList:@[
        [YHLinePointItem valueX:0 valueY:50],
        [YHLinePointItem valueX:10 valueY:arc4random()%100],
        [YHLinePointItem valueX:20 valueY:arc4random()%100],
        [YHLinePointItem valueX:30 valueY:arc4random()%100 showPoint:YES],
        [YHLinePointItem valueX:40 valueY:arc4random()%100],
        [YHLinePointItem valueX:50 valueY:arc4random()%100],
        [YHLinePointItem valueX:60 valueY:arc4random()%100 showPoint:YES],
        [YHLinePointItem valueX:70 valueY:arc4random()%100],
        [YHLinePointItem valueX:90 valueY:arc4random()%100],
        [YHLinePointItem valueX:80 valueY:arc4random()%100],
        [YHLinePointItem valueX:100 valueY:60],
    ]];
    item.pointFillColor = [UIColor whiteColor];
    item.pointLineColor = [UIColor yh_green];
    item.pointLineWidth = 1;
    item.pointRadius = 3;
    item.pointShow = YES;
    item.pointPicker.canSelect = YES;
    item.pointPicker.radius = 4;
    item.pointPicker.fillColor = [UIColor yh_green];
    item.pointPicker.lineWidth = 0;
    item.pointPicker.showReflineVertical = NO;
    item.pointPicker.showReflineHorizontal = YES;
    item.pointPicker.reflineHColor = [UIColor yh_green];
    item.pointPicker.reflineVColor = [UIColor yh_green];
    item.pointPicker.reflineDottedH = YES;
    item.pointPicker.reflineDottedV = YES;
    [item.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
        YHPointToastView * toastView = [YHPointToastView new];
        NSString * contentY = [NSString stringWithFormat:@"Y轴: %lf",passPoint.valueY];
        NSString * contentX = [NSString stringWithFormat:@"X轴: %lf",passPoint.valueX];
        NSString * content = [NSString stringWithFormat:@"%@\n%@",contentY,contentX];
        toastView.textTitle.text = content;
        return toastView;
    }];
    [chartView3 addLineChart:item];
    
    
    item = [YHLineChartItem new];
    item.lineColor = [UIColor yh_red];
    [item resetPointList:@[
        [YHLinePointItem valueX:0 valueY:90],
        [YHLinePointItem valueX:10 valueY:arc4random()%100],
        [YHLinePointItem valueX:20 valueY:arc4random()%100],
        [YHLinePointItem valueX:30 valueY:arc4random()%100 showPoint:YES],
        [YHLinePointItem valueX:40 valueY:arc4random()%100],
        [YHLinePointItem valueX:50 valueY:arc4random()%100],
        [YHLinePointItem valueX:90 valueY:arc4random()%100 showPoint:YES],
        [YHLinePointItem valueX:80 valueY:arc4random()%100],
        [YHLinePointItem valueX:100 valueY:90],
    ]];
    item.pointFillColor = [UIColor whiteColor];
    item.pointLineColor = [UIColor yh_red];
    item.pointLineWidth = 1;
    item.pointRadius = 3;
    item.pointPicker.canSelect = YES;
    item.pointPicker.radius = 4;
    item.pointPicker.fillColor = [UIColor whiteColor];
    item.pointPicker.lineWidth = 2;
    item.pointPicker.lineColor = [UIColor yh_red];
    item.pointPicker.showReflineVertical = YES;
    item.pointPicker.showReflineHorizontal = NO;
    item.pointPicker.reflineHColor = [UIColor yh_red];
    item.pointPicker.reflineVColor = [UIColor yh_red];
    item.pointPicker.reflineDottedH = YES;
    item.pointPicker.reflineDottedV = YES;
    [item.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
        YHPointToastView * toastView = [YHPointToastView new];
        NSString * contentY = [NSString stringWithFormat:@"多单爆仓: %lf",passPoint.valueY];
        NSString * contentX = [NSString stringWithFormat:@"空单爆仓: %lf",passPoint.valueX];
        NSString * content = [NSString stringWithFormat:@"2020-03-08\n%@\n%@",contentY,contentX];
        toastView.textTitle.text = content;
        return toastView;
    }];
    [chartView3 addLineChart:item];
    
    
    
    UIView * contentView = [UIView new];
    [contentView addSubview:chartView3];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.95);
        make.height.equalTo(self.view).multipliedBy(0.6);
    }];
    
    
    [chartView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(Adapted(180));
    }];
    
    
    void(^AddChartLine)(void) = ^(void) {
        UIColor * randoYHolor = [UIColor yh_randomcolor];
        YHLineChartItem * item = [YHLineChartItem new];
        item.lineColor = randoYHolor;
        item.dotted = (arc4random()%2 == 0);
        item.smoothness = (arc4random()%2 == 0);
        item.pointShow = (arc4random()%4 == 0);
        [item resetPointList:@[
            [YHLinePointItem valueX:0 valueY:90],
            [YHLinePointItem valueX:10 valueY:arc4random()%100],
            [YHLinePointItem valueX:20 valueY:arc4random()%100],
            [YHLinePointItem valueX:30 valueY:arc4random()%100 showPoint:YES],
            [YHLinePointItem valueX:40 valueY:arc4random()%100],
            [YHLinePointItem valueX:50 valueY:arc4random()%100],
            [YHLinePointItem valueX:90 valueY:arc4random()%100 showPoint:YES],
            [YHLinePointItem valueX:80 valueY:arc4random()%100],
            [YHLinePointItem valueX:100 valueY:90],
        ]];
        item.lineShowShadow = (arc4random()%2 == 0);
        item.lineShadowColorTop = [randoYHolor colorWithAlphaComponent:0.8];
        item.lineShadowColorBottom = [randoYHolor colorWithAlphaComponent:0.1];
        item.pointFillColor = [UIColor whiteColor];
        item.pointLineColor = randoYHolor;
        item.pointLineWidth = 1;
        item.pointRadius = 3;
        item.pointPicker.canSelect = YES;
        item.pointPicker.radius = arc4random()%4+2;
        item.pointPicker.fillColor = [UIColor whiteColor];
        item.pointPicker.lineWidth = item.pointPicker.radius*0.5;
        item.pointPicker.lineColor = randoYHolor;
        item.pointPicker.showReflineVertical = (arc4random()%2 == 0);
        item.pointPicker.showReflineHorizontal = (arc4random()%2 == 0);
        item.pointPicker.reflineHColor = randoYHolor;
        item.pointPicker.reflineVColor = randoYHolor;
        item.pointPicker.reflineDottedH = (arc4random()%2 == 0);
        item.pointPicker.reflineDottedV = (arc4random()%2 == 0);
        [item.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
            YHPointToastView * toastView = [YHPointToastView new];
            NSString * contentY = [NSString stringWithFormat:@"Y轴: %lf",passPoint.valueY];
            NSString * contentX = [NSString stringWithFormat:@"X轴: %lf",passPoint.valueX];
            NSString * content = [NSString stringWithFormat:@"%@\n%@",contentY,contentX];
            toastView.textTitle.text = content;
            return toastView;
        }];
        [chartView3 addLineChart:item];
    };
    
    void(^UpdateLinePoint)(YHLineChartItem * item) = ^(YHLineChartItem * item) {
        
        NSMutableArray * dataList = [NSMutableArray new];
        [dataList addObject:[YHLinePointItem valueX:0 valueY:arc4random()%100 showPoint:(arc4random()%2 == 0)]];
        [dataList addObject:[YHLinePointItem valueX:100 valueY:arc4random()%100 showPoint:(arc4random()%2 == 0)]];
        
        NSInteger pointCount = arc4random()%30+2;
        for(NSInteger i = 0; i<pointCount; i++){
//            [dataList addObject:[YHLinePointItem valueX:arc4random()%100 valueY:arc4random()%100 showPoint:(arc4random()%2 == 0)]];
            [dataList addObject:[YHLinePointItem valueX:arc4random()%100 valueY:arc4random()%100 showPoint:YES]];
        }
        
        [item resetPointList:dataList];
        
        [chartView3 updateLineChart:item];
    };
    
    ///////////
    YHDebugMenu * lineMenu = [YHDebugMenu new];
    [contentView addSubview:lineMenu];
    
    [lineMenu addMenu:@"添加线" action:^{
        AddChartLine();
    }];
    [lineMenu addMenu:@"更新线" action:^{
        if(chartView3.lineLayerCount == 0){
            return;
        }
        NSInteger randomInde = arc4random()%chartView3.lineLayerCount;
        YHLineChartItem * item = [chartView3 getLineChartIndex:randomInde];
        UpdateLinePoint(item);
    }];
    [lineMenu addMenu:@"删除线" action:^{
        if(chartView3.lineLayerCount == 0){
            return;
        }
        NSInteger randomInde = arc4random()%chartView3.lineLayerCount;
        YHLineChartItem * item = [chartView3 getLineChartIndex:randomInde];
        [chartView3 removeLineChart:item];
    }];
    [lineMenu layoutIfNeeded];
    
    
    
    
    [lineMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(chartView3.mas_bottom).offset(Adapted(15));
        make.height.mas_equalTo(Adapted(45));
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
