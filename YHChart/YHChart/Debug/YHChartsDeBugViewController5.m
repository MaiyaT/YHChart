//
//  YHChartsDeBugViewController5.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController5.h"

@interface YHChartsDeBugViewController5 ()

@end

@implementation YHChartsDeBugViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIView * contentView = [UIView new];
    
    YHLineChartView * chartView = [YHLineChartView new];
    chartView.backgroundColor = [UIColor whiteColor];

    NSMutableArray * scaleList = [NSMutableArray new];

    [scaleList addObject:[YHScaleItem att:YHHTitle(@"2011") value:5]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"2013") value:11]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"2015") value:17]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"2017") value:23]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"2019") value:28]];
    [chartView updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.maxValue = 30;
        axisInfo.minValue = 0;
    }];


    [scaleList removeAllObjects];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"0.01") value:0.01]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"0.1") value:0.1]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"1") value:1]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"10") value:10]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"100") value:100]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"1000") value:1000]];
    [chartView updateAxisScaleList:scaleList width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.isDeuceByScale = YES;
        axisInfo.maxValue = 1000;
        axisInfo.minValue = 0.01;
    }];
    
    [chartView addReflineAllAxisPos:YHChartAxisPos_Left config:^(YHReflineInfo * _Nonnull refline) {
        refline.lineColor = [UIColor whiteColor];
        refline.lineHeight = 1;
    }];


    YHLineChartItem * item = [YHLineChartItem new];
    item.lineColor = [UIColor yh_blue];
    item.lineShowShadow = YES;
    item.lineShadowColorTop = [[UIColor yh_blue] colorWithAlphaComponent:0.8];
    item.lineShadowColorBottom = [[UIColor yh_blue] colorWithAlphaComponent:0.1];
    item.coordInfoViewShow = YES;
    item.pointShow = YES;
    item.pointFillColor = [UIColor whiteColor];
    item.pointLineColor = [UIColor yh_blue];
    item.pointLineWidth = 1;
    item.pointRadius = 3;
    item.pointPicker.canSelect = YES;
    item.pointPicker.radius = 4;
    item.pointPicker.lineColor = [UIColor yh_blue];
    item.pointPicker.fillColor = [UIColor whiteColor];
    item.pointPicker.lineWidth = 0;
    [item.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
        YHPointToastView * toastView = [YHPointToastView new];
        NSString * contentY = [NSString stringWithFormat:@"Y轴: %lf",passPoint.valueY];
        NSString * contentX = [NSString stringWithFormat:@"X轴: %lf",passPoint.valueX];
        NSString * content = [NSString stringWithFormat:@"%@\n%@",contentY,contentX];
        toastView.textTitle.text = content;
        return toastView;
    }];
    
    for(NSInteger i = 0; i < 30+1; i++){
        if(i%3 == 0){
            CGFloat preValueY = 1;
            if(arc4random()%2 == 0){
                preValueY = preValueY + arc4random()%1000;
            }else{
                preValueY = preValueY - arc4random()%100/100.0;
            }
            if(preValueY < 0){
                preValueY = preValueY + 0.1;
            }else if(preValueY > 1000){
                preValueY = preValueY - 50;
            }
            YHLinePointItem * point = [YHLinePointItem valueX:i valueY:@(preValueY).doubleValue];
            [item addPoint:point];
        }
    }
    [chartView addLineChart:item];

    
    [contentView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(Adapted(200));
    }];
    
    
    UILabel * titleV = [UILabel new];
    titleV.textAlignment = NSTextAlignmentCenter;
    titleV.text = @"囤币曲线";
    [contentView addSubview:titleV];
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.equalTo(contentView);
       make.top.equalTo(chartView.mas_bottom).offset(Adapted(10));
    }];
    
    
    void(^TunBiUpdateBlock)(NSInteger type) = ^(NSInteger type) {
        
//        [chartView clean];
        
        if(type == 0){
            //五分钟
            [scaleList removeAllObjects];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"5′") value:5]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"10′") value:10]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"25′") value:25]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"30′") value:30]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"35′") value:35]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"40′") value:40]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"45′") value:45]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"60′") value:60]];
            
            [chartView updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
                axisInfo.maxValue = 60;
                axisInfo.minValue = 0;
            }];
        }else if(type == 1){
            //一小时
            [scaleList removeAllObjects];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"5H") value:5]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"10H") value:10]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"25H") value:25]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"30H") value:30]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"35H") value:35]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"40H") value:40]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"45H") value:45]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"60H") value:60]];
            [chartView updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
                axisInfo.maxValue = 60;
                axisInfo.minValue = 0;
            }];
        }else{
            //一天
            [scaleList removeAllObjects];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"5D") value:5]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"10D") value:10]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"25D") value:25]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"30D") value:30]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"35D") value:35]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"40D") value:40]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"45D") value:45]];
            [scaleList addObject:[YHScaleItem att:YHHTitle(@"60D") value:60]];
            [chartView updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
                axisInfo.maxValue = 60;
                axisInfo.minValue = 0;
            }];
        }
        
        NSMutableArray * dataList = [NSMutableArray new];
        NSInteger count = 60;
        for(NSInteger i = 0; i < count; i++){
            if(i%3 == 0){
                CGFloat preValueY = 1;
                if(arc4random()%2 == 0){
                    preValueY = preValueY + arc4random()%1000;
                }else{
                    preValueY = preValueY - arc4random()%100/100.0;
                }
                if(preValueY < 0){
                    preValueY = preValueY + 0.1;
                }else if(preValueY > 1000){
                    preValueY = preValueY - 50;
                }
                YHLinePointItem * point = [YHLinePointItem valueX:i valueY:@(preValueY).doubleValue];
                [dataList addObject:point];
            }
        }
        [item resetPointList:dataList];
        [chartView updateLineChart:item];
    };
    
    YHDebugMenu * timeMenu = [YHDebugMenu new];
    [contentView addSubview:timeMenu];
    [timeMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(Adapted(45));
        make.top.equalTo(titleV.mas_bottom).offset(Adapted(15));
        make.bottom.equalTo(contentView).offset(Adapted(-10));
    }];

    [timeMenu addMenu:@"五分钟" action:^{
        TunBiUpdateBlock(0);
    }];
    [timeMenu addMenu:@"一小时" action:^{
        TunBiUpdateBlock(1);
    }];
    [timeMenu addMenu:@"一天" action:^{
        TunBiUpdateBlock(2);
    }];
    [timeMenu layoutIfNeeded];
    
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.95);
        make.height.equalTo(self.view).multipliedBy(0.6);
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
