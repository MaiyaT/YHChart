//
//  YHChartsDeBugViewController1.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController1.h"

@interface YHChartsDeBugViewController1 ()

@end

@implementation YHChartsDeBugViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    YHLineChartView * chartView2 = [YHLineChartView new];
    [self.view addSubview:chartView2];
    [chartView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.9);
        make.height.mas_equalTo(Adapted(300));
    }];
    
    NSMutableArray * scaleList = [NSMutableArray new];
    
    NSArray * list = @[@"7.59",@"7.5",@"7.4",@"7.3",@"7.2",@"7.1",@"7.0"];
    for(NSString * str in list){
        [scaleList addObject:[YHScaleItem att:YHVTitle(str) value:str.floatValue]];
    }
    [chartView2 updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.maxValue = 7.6;
        axisInfo.minValue = 7;
    }];
    
    [scaleList removeAllObjects];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3/0") value:0]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3/4") value:4]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3/8") value:8]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3/12") value:12]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3/15") value:15]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3/20") value:20]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3/24") value:24]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"3/30") value:30]];
    [chartView2 updateAxisScaleList:scaleList width:30 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight)];
    
    
    [chartView2 addReflineAllAxisPos:YHChartAxisPos_Bottom config:nil];
    [chartView2 addReflineAllAxisPos:YHChartAxisPos_Left config:nil];
    [chartView2 addReflineAxisPosition:(YHChartAxisPos_Left) width:1 color:[UIColor yh_title_h1] dotted:NO];
    [chartView2 addReflineAxisPosition:(YHChartAxisPos_Bottom) width:1 color:[UIColor yh_title_h1] dotted:NO];
    
    YHLineChartItem * item = [YHLineChartItem new];
    item.lineColor = [UIColor yh_colorWithHexString:@"#1678FF"];
    item.lineShowShadow = YES;
    item.lineShadowColorTop = [[UIColor yh_colorWithHexString:@"#1678FF"] colorWithAlphaComponent:0.28];
    item.lineShadowColorBottom = [[UIColor yh_colorWithHexString:@"#0086FF"] colorWithAlphaComponent:0.1];
    [item resetPointList:@[
        [YHLinePointItem valueX:0 valueY:7.2],
        [YHLinePointItem valueX:5 valueY:7.5],
        [YHLinePointItem valueX:7 valueY:7.1],
        [YHLinePointItem valueX:15 valueY:7.0],
        [YHLinePointItem valueX:24 valueY:7.4],
        [YHLinePointItem valueX:30 valueY:7.3],
    ]];
    item.smoothness = YES;
    item.pointFillColor = [UIColor whiteColor];
    item.pointLineColor = [UIColor yh_colorWithHexString:@"#1678FF"];
    item.pointLineWidth = 1;
    item.pointRadius = 3;
    item.pointShow = YES;
    [chartView2 addLineChart:item];

    item = [YHLineChartItem new];
    item.lineColor = [UIColor yh_colorWithHexString:@"#AB1BFF"];
    item.lineShowShadow = YES;
    item.lineShadowColorTop = [[UIColor yh_colorWithHexString:@"#AB1BFF"] colorWithAlphaComponent:0.2];
    item.lineShadowColorBottom = [[UIColor yh_colorWithHexString:@"#AB1BFF"] colorWithAlphaComponent:0.1];
    [item resetPointList:@[
        [YHLinePointItem valueX:0 valueY:7.07],
        [YHLinePointItem valueX:8 valueY:7.14],
        [YHLinePointItem valueX:12 valueY:7.08],
        [YHLinePointItem valueX:20 valueY:7.15],
        [YHLinePointItem valueX:22 valueY:7.1],
        [YHLinePointItem valueX:28 valueY:7.05],
        [YHLinePointItem valueX:30 valueY:7.2],
    ]];
    item.smoothness = YES;
    [chartView2 addLineChart:item];
    
    
    
    
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
