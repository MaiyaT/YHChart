//
//  YHChartsDeBugViewController6.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController6.h"

@interface YHChartsDeBugViewController6 ()

@end

@implementation YHChartsDeBugViewController6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIView * contentView = [UIView new];
    
    
    YHLineChartView * chartView = [YHLineChartView new];
    
    NSMutableArray * scaleList = [NSMutableArray new];
    
    //X轴
    [scaleList removeAllObjects];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"10") value:10]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"30") value:30]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"50") value:50]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"70") value:70]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"90") value:90]];
    [chartView updateAxisScaleList:scaleList width:30 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.minValue = 0;
        axisInfo.maxValue = 100;
    }];
    
    
    //Y轴 左
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
    [chartView updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.minValue = 0;
    }];
    
    //Y轴 右
    [scaleList removeAllObjects];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"1000") value:1000]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"1500") value:1500]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"2000") value:2000]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"2500") value:2500]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3000") value:3000]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3500") value:3500]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"4000") value:4000]];
    [chartView updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Right) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.otherAxis = chartView.axisInfo.axisPos(YHChartAxisPos_Bottom);
    }];
    
    
    
    [chartView addReflineAxisPosition:(YHChartAxisPos_Left) width:1 color:[UIColor yh_title_h1] dotted:NO];
    [chartView addReflineAxisPosition:(YHChartAxisPos_Bottom) width:1 color:[UIColor yh_title_h1] dotted:NO];
    [chartView addReflineConfig:^(YHReflineInfo * _Nonnull refline) {
        refline.showHorizontal = YES;
        refline.axisYValue = 30;
    }];
    [chartView addReflineConfig:^(YHReflineInfo * _Nonnull refline) {
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
        [YHLinePointItem valueX:100 valueY:arc4random()%100],
    ]];
    item.pointLineColor = [UIColor yh_blue];
    item.pointLineWidth = 1;
    item.pointFillColor = [UIColor whiteColor];
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
    item.coordInfoViewShow = YES;
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
    [chartView addLineChart:item];
    
    
    
    YHLineChartItem * item1 = [YHLineChartItem new];
    item1.lineColor = [UIColor yh_red];
    [item1 addPointList:@[
        [YHLinePointItem valueX:0 valueY:arc4random()%3000 + 1000],
        [YHLinePointItem valueX:10 valueY:arc4random()%3000 + 1000],
        [YHLinePointItem valueX:20 valueY:arc4random()%3000 + 1000],
        [YHLinePointItem valueX:30 valueY:arc4random()%3000 + 1000],
        [YHLinePointItem valueX:40 valueY:arc4random()%3000 + 1000],
        [YHLinePointItem valueX:50 valueY:arc4random()%3000 + 1000],
        [YHLinePointItem valueX:60 valueY:arc4random()%3000 + 1000],
        [YHLinePointItem valueX:70 valueY:arc4random()%3000 + 1000],
        [YHLinePointItem valueX:90 valueY:arc4random()%3000 + 1000],
        [YHLinePointItem valueX:100 valueY:arc4random()%3000 + 1000],
    ]];
    item1.pointLineColor = [UIColor yh_red];
    item1.pointFillColor = [UIColor whiteColor];
    item1.pointLineWidth = 1;
    item1.pointRadius = 3;
    item1.pointShow = YES;
    item1.pointPicker.canSelect = YES;
    item1.pointPicker.radius = 4;
    item1.pointPicker.fillColor = [UIColor yh_red];
    item1.pointPicker.lineWidth = 0;
    item1.pointPicker.showReflineVertical = YES;
    item1.pointPicker.showReflineHorizontal = YES;
    item1.pointPicker.reflineHColor = [UIColor yh_red];
    item1.pointPicker.reflineVColor = [UIColor yh_red];
    item1.pointPicker.reflineDottedH = YES;
    item1.pointPicker.reflineDottedV = YES;
    item1.coordInfoViewShow = YES;
    [item1.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
        YHPointToastView * toastView = [YHPointToastView new];
        NSString * contentY = [NSString stringWithFormat:@"Y轴: %lf",passPoint.valueY];
        NSString * contentX = [NSString stringWithFormat:@" X轴: %lf",passPoint.valueX];
        NSString * content = [NSString stringWithFormat:@"%@\n%@",contentY,contentX];
        toastView.textTitle.attributedText = [NSMutableAttributedString yh_initWithStr:content customBlock:^(NSMutableAttributedString *att) {
            [att yh_attachImage:[UIImage imageNamed:@"message_icon1"] imageSize:CGSizeMake(14, 14) atIndex:contentY.length+1];
        }];
        return toastView;
    }];
    item1.referYOther = YES;
    [chartView addLineChart:item1];
    
    
    
    [contentView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(Adapted(200));
        
        
    }];
    
    
    UILabel * titleV = [UILabel new];
    titleV.textAlignment = NSTextAlignmentCenter;
    titleV.text = @"双Y轴";
    [contentView addSubview:titleV];
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(chartView.mas_bottom).offset(Adapted(10));
        make.bottom.equalTo(contentView).offset(Adapted(-20));
    }];
    
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.95);
        make.height.equalTo(self.view).multipliedBy(0.9);
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
