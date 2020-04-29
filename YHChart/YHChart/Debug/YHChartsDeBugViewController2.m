//
//  YHChartsDeBugViewController2.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController2.h"

@interface YHChartsDeBugViewController2 ()

@end

@implementation YHChartsDeBugViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    ///  ================  折线图 自动添加移动
    
    YHLineChartView * chartView1 = [self chartView1];
    [self.view addSubview:chartView1];
    [chartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(Adapted(50));
        make.width.equalTo(self.view).multipliedBy(0.9);
        make.height.mas_equalTo(Adapted(150));
    }];
    
    
    ///  ================  折线图 自动添加移动
    
    YHLineChartView * chartView1_1 = [self chartView1_1];
    [self.view addSubview:chartView1_1];
    [chartView1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(chartView1);
        make.top.equalTo(chartView1.mas_bottom).offset(Adapted(40));
    }];
    
    WS(weakSelf);
    YHDebugMenu * autoMenu = [YHDebugMenu new];
    [autoMenu addMenu:@"开始自动添加点 折线图向左移动" action:^{
        [YHCountDownTool yh_addCountdownTarget:weakSelf
                                      duration:10000
                                      progress:^(NSInteger total, NSInteger remain) {

            YHLineChartItem * itemFirst = [chartView1 getLineChartIndex:0];
            YHLinePointItem * pointLast = itemFirst.dataList.lastObject;

            YHLinePointItem * pointAdd = [YHLinePointItem valueX:pointLast.valueX + arc4random()%5 + 8 valueY:arc4random()%(NSInteger)chartView1.axisInfo.axisInfoY.maxValue];
            pointAdd.axisXAttTitle = YHHTitle(@((NSInteger)pointAdd.valueX).stringValue);
            pointAdd.axisYAttTitle = YHVTitle(@((NSInteger)pointAdd.valueY).stringValue);

            [chartView1 addAutoMoveByPointList:@[pointAdd] lineInfoAtLine:0];
            
            
            
            YHLineChartItem * itemFirst_1 = [chartView1_1 getLineChartIndex:0];
            YHLinePointItem * pointFirst = itemFirst_1.dataList.firstObject;

            YHLinePointItem * pointAdd_1 = [YHLinePointItem valueX:pointFirst.valueX + arc4random()%5 + 8 valueY:arc4random()%(NSInteger)chartView1_1.axisInfo.axisInfoY.maxValue];
            pointAdd_1.axisXAttTitle = YHHTitle(@((NSInteger)pointAdd_1.valueX).stringValue);
            pointAdd_1.axisYAttTitle = YHVTitle(@((NSInteger)pointAdd_1.valueY).stringValue);
            
            [chartView1_1 addAutoMoveByPointList:@[pointAdd_1] lineInfoAtLine:0];
            
        } finish:^{

        }];
    }];
    [self.view addSubview:autoMenu];
    [autoMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chartView1);
        make.right.equalTo(chartView1_1);
        make.top.equalTo(chartView1_1.mas_bottom).offset(Adapted(50));
        make.height.mas_equalTo(Adapted(44));
    }];
}




- (YHLineChartView *)chartView1{
    
    YHLineChartView * chartView1 = [YHLineChartView new];
    
    //添加坐标轴 不设置标题
    chartView1.axisInfo.axisPos(YHChartAxisPos_Bottom).maxValue = 50;
    chartView1.axisInfo.axisPos(YHChartAxisPos_Left).maxValue = 50;
    
    
    //折线数据
    YHLineChartItem * item = [YHLineChartItem new];
    item.smoothness = YES;
    item.isAutoMoveAni = YES;
    item.lineColor = [[UIColor yh_colorWithHexString:@"#FF3D3D"] colorWithAlphaComponent:0.2];
    item.lineShowShadow = YES;
    item.lineShadowColorTop = [[UIColor yh_colorWithHexString:@"#FF3D3D"] colorWithAlphaComponent:0.1];
    item.lineShadowColorBottom = [[UIColor yh_colorWithHexString:@"#FF3D3D"] colorWithAlphaComponent:0.05];
    [item resetPointList:@[
        [YHLinePointItem valueX:0 valueY:14],
        [YHLinePointItem valueX:5 valueY:5],
        [YHLinePointItem valueX:7 valueY:30],
        [YHLinePointItem valueX:15 valueY:10],
        [YHLinePointItem valueX:24 valueY:50],
        [YHLinePointItem valueX:40 valueY:38],
        [YHLinePointItem valueX:43 valueY:40],
        [YHLinePointItem valueX:45 valueY:48],
    ]];
    [chartView1 addLineChart:item];
    
    return chartView1;
}

- (YHLineChartView *)chartView1_1{
    YHLineChartView * chartView1_1 = [YHLineChartView new];
    
    chartView1_1.axisInfo.axisPos(YHChartAxisPos_Bottom).maxValue = 100;
    chartView1_1.axisInfo.axisPos(YHChartAxisPos_Right).maxValue = 100;
    
    chartView1_1.axisInfo.axisPos(YHChartAxisPos_Bottom).axisDirction = YHChartAxisDirection_RightToLeft;
    chartView1_1.axisInfo.axisPos(YHChartAxisPos_Right).axisDirction = YHChartAxisDirection_BottomToTop;
    
    //折线数据
    YHLineChartItem * item = [YHLineChartItem new];
    item.smoothness = YES;
    item.isAutoMoveAni = YES;
    item.lineColor = [[UIColor yh_colorWithHexString:@"#1678FF"] colorWithAlphaComponent:0.2];
    item.lineShowShadow = YES;
    item.lineShadowColorTop = [[UIColor yh_colorWithHexString:@"#1678FF"] colorWithAlphaComponent:0.1];
    item.lineShadowColorBottom = [UIColor clearColor];
    [item resetPointList:@[
        [YHLinePointItem valueX:0 valueY:14],
    ]];
    item.pointFillColor = [UIColor whiteColor];
    item.pointLineColor = [[UIColor yh_colorWithHexString:@"#1678FF"] colorWithAlphaComponent:0.2];
    item.pointLineWidth = 1;
    item.pointRadius = 3;
    item.pointShow = YES;
    [chartView1_1 addLineChart:item];
    
    return chartView1_1;
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
