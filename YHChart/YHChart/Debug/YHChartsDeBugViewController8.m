//
//  YHChartsDeBugViewController8.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController8.h"

@interface YHChartsDeBugViewController8 ()

@end

@implementation YHChartsDeBugViewController8

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIView * contentView = [UIView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.95);
        make.height.equalTo(self.view).multipliedBy(0.8);
    }];
    
    
    YHLineChartView * chartView = [YHLineChartView new];

    chartView.axisInfo.axisPos(YHChartAxisPos_Left).maxValue = 100;
    chartView.axisInfo.axisPos(YHChartAxisPos_Bottom).maxValue = 100;

    [chartView addReflineAllAxisPos:YHChartAxisPos_Left config:^(YHReflineInfo * _Nonnull refline) {
        refline.lineColor = [UIColor whiteColor];
        refline.lineHeight = 1;
    }];
    
    [contentView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(contentView);
        make.top.equalTo(contentView);
        make.left.equalTo(contentView).offset(Adapted(80));
        make.right.equalTo(contentView).offset(Adapted(-80));
        make.height.mas_equalTo(Adapted(200));
    }];
    
    
    YHLineChartItem * item = [YHLineChartItem new];
    item.isAutoMoveAni = YES;
    item.showType = YHChartShowType_Bar;
    item.lineColor = [UIColor yh_randomcolor];
    item.lineWidth = Adapted(5);
    [item.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
        YHPointToastView * toastView = [YHPointToastView new];
        NSString * contentY = [NSString stringWithFormat:@"Y轴: %lf",passPoint.valueY];
        NSString * contentX = [NSString stringWithFormat:@"X轴: %lf",passPoint.valueX];
        NSString * content = [NSString stringWithFormat:@"%@\n%@",contentY,contentX];
        toastView.textTitle.text = content;
        return toastView;
    }];
    
    for(NSInteger i = 1; i < 100; i++){
        if(i%5 == 0){
            CGFloat preValueY = arc4random()%100;
            YHLinePointItem * point = [YHLinePointItem valueX:i valueY:@(preValueY).doubleValue];
            [item addPoint:point];
        }
    }
    [chartView addLineChart:item];
    
    
    
    WS(weakSelf);
    YHDebugMenu * autoMenu = [YHDebugMenu new];
    [autoMenu addMenu:@"开始自动添加点 折线图向左移动" action:^{
        [YHCountDownTool yh_addCountdownTarget:weakSelf
                                      duration:10000
                                      progress:^(NSInteger total, NSInteger remain) {

            YHLineChartItem * itemFirst = [chartView getLineChartIndex:0];
            YHLinePointItem * pointLast = itemFirst.dataList.lastObject;

            YHLinePointItem * pointAdd = [YHLinePointItem valueX:pointLast.valueX + arc4random()%5 + 8 valueY:arc4random()%(NSInteger)chartView.axisInfo.axisInfoY.maxValue];
            pointAdd.axisXAttTitle = YHHTitle(@((NSInteger)pointAdd.valueX).stringValue);
            pointAdd.axisYAttTitle = YHVTitle(@((NSInteger)pointAdd.valueY).stringValue);

            [chartView addAutoMoveByPointList:@[pointAdd] lineInfoAtLine:0];

        } finish:^{

        }];
    }];
    [contentView addSubview:autoMenu];
    [autoMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chartView);
        make.right.equalTo(chartView);
        make.top.equalTo(chartView.mas_bottom).offset(Adapted(20));
        make.height.mas_equalTo(Adapted(44));
//        make.bottom.equalTo(contentView).offset(Adapted(-20));
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
