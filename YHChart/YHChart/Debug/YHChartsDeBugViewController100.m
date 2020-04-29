//
//  YHChartsDeBugViewController.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController100.h"


@interface YHChartsDeBugViewController100 ()

@end

@implementation YHChartsDeBugViewController100


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"折线";
    
    WS(weakSelf);
    
    UIScrollView * scrollview = [UIScrollView new];
    [self.view addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    ///
    /// 滚动方向是 垂直方向

    
    /// 柱状图
    UIView * chartView8 = [self chartView8];
    [scrollview addSubview:chartView8];
    [chartView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollview).offset(Adapted(10));
        make.right.equalTo(self.view).offset(Adapted(-10));
        make.right.equalTo(scrollview).offset(Adapted(-10));
        make.top.equalTo(scrollview).offset(Adapted(30));
    }];
    
    
    
    /// 柱状图
    UIView * chartView7 = [self chartView7];
    [scrollview addSubview:chartView7];
    [chartView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollview).offset(Adapted(10));
        make.right.equalTo(self.view).offset(Adapted(-10));
        make.right.equalTo(scrollview).offset(Adapted(-10));
        make.top.equalTo(chartView8.mas_bottom).offset(Adapted(30));
    }];
    
    
    
    /// 单X 双Y轴
    UIView * chartView6 = [self chartView6];
    [scrollview addSubview:chartView6];
    [chartView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollview).offset(Adapted(10));
        make.right.equalTo(self.view).offset(Adapted(-10));
        make.right.equalTo(scrollview).offset(Adapted(-10));
        make.top.equalTo(chartView7.mas_bottom).offset(Adapted(30));
    }];


    /// 不均等值 坐标  ========================  囤币指数 坐标等分 但是不等值
    /// https://www.qkl123.com/data/ahr999/btc

    UIView * chartView5 = [self chartView5];
    [scrollview addSubview:chartView5];
    [chartView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollview).offset(Adapted(10));
        make.right.equalTo(self.view).offset(Adapted(-10));
        make.right.equalTo(scrollview).offset(Adapted(-10));
        make.top.equalTo(chartView6.mas_bottom).offset(Adapted(30));
    }];

    
    /// ========================  折线视图 坐标轴 各个方向 设置
    
    UIView * chartView4 = [self chartView4];
    [scrollview addSubview:chartView4];
    [chartView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollview).offset(Adapted(10));
        make.right.equalTo(self.view).offset(Adapted(-10));
        make.right.equalTo(scrollview).offset(Adapted(-10));
        make.top.equalTo(chartView5.mas_bottom).offset(Adapted(30));
    }];
    
    

    /// ========================  折线视图 圆点选中 选中之后 toast提示信息
    
    
    UIView * chartView3 = [self chartView3];
    [scrollview addSubview:chartView3];
    [chartView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollview).offset(Adapted(10));
        make.right.equalTo(self.view).offset(Adapted(-10));
        make.right.equalTo(scrollview).offset(Adapted(-10));
        make.top.equalTo(chartView4.mas_bottom).offset(Adapted(30));
    }];
    
    
    
    
    /// =================== 折线图 坐标轴
    
    
    YHLineChartView * chartView2 = [self chartView2];
    [scrollview addSubview:chartView2];
    [chartView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chartView3);
        make.right.equalTo(chartView3);
        make.top.equalTo(chartView3.mas_bottom).offset(Adapted(30));
        make.height.mas_equalTo(Adapted(180));
    }];
    
    
    
    
    
    
    
    ///  ================  折线图 自动添加移动
    
    YHLineChartView * chartView1 = [self chartView1];
    [scrollview addSubview:chartView1];
    [chartView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chartView2);
        make.top.equalTo(chartView2.mas_bottom).offset(Adapted(20));
        make.right.equalTo(scrollview.mas_centerX).offset(Adapted(-10));
        make.height.mas_equalTo(Adapted(120));
    }];
    
    
    ///  ================  折线图 自动添加移动
    
    YHLineChartView * chartView1_1 = [self chartView1_1];
    [scrollview addSubview:chartView1_1];
    [chartView1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(chartView2);
        make.top.height.equalTo(chartView1);
        make.left.equalTo(scrollview.mas_centerX).offset(Adapted(10));
    }];
    
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
    [scrollview addSubview:autoMenu];
    [autoMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chartView1);
        make.right.equalTo(chartView1_1);
        make.top.equalTo(chartView1_1.mas_bottom).offset(Adapted(20));
        make.height.mas_equalTo(Adapted(44));
        make.bottom.equalTo(scrollview).offset(Adapted(-40));
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

- (YHLineChartView *)chartView2{
    YHLineChartView * chartView2 = [YHLineChartView new];

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
    
    return chartView2;
}

- (UIView *)chartView3{
    
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
    [lineMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(chartView3.mas_bottom).offset(Adapted(15));
        make.height.mas_equalTo(Adapted(45));
        
        make.bottom.equalTo(contentView).offset(Adapted(-15));
    }];
    
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
    
    
    

    return contentView;
}

- (UIView *)chartView4{
    
    UIView * contentView = [UIView new];
    
    YHLineChartView * chartView = [YHLineChartView new];

    NSMutableArray * scaleList = [NSMutableArray new];
    for(NSInteger i = 0; i < 11; i++){
        [scaleList addObject:[YHScaleItem att:YHHTitle(@(i).stringValue) value:i]];
    }
    [chartView updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight)];


    [scaleList removeAllObjects];
    for(NSInteger i = 0; i < 11; i++){
        [scaleList addObject:[YHScaleItem att:YHHTitle(@(i).stringValue) value:i]];
    }
    [chartView updateAxisScaleList:scaleList width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop)];

    [chartView addReflineAxisPosition:(YHChartAxisPos_Left) width:2 color:[UIColor yh_separator_dark] dotted:NO];
    [chartView addReflineAxisPosition:(YHChartAxisPos_Bottom) width:2 color:[UIColor yh_separator_dark] dotted:NO];
    [chartView addReflineAxisPosition:(YHChartAxisPos_Right) width:2 color:[UIColor yh_separator_dark] dotted:NO];
    [chartView addReflineAxisPosition:(YHChartAxisPos_Top) width:2 color:[UIColor yh_separator_dark] dotted:NO];
    [chartView addReflineAllAxisPos:YHChartAxisPos_Left config:^(YHReflineInfo * _Nonnull refline) {
        refline.lineColor = [UIColor yh_separator];
        refline.lineHeight = 1;
    }];
    [chartView addReflineAllAxisPos:(YHChartAxisPos_Bottom) config:^(YHReflineInfo * _Nonnull refline) {
        refline.lineColor = [UIColor yh_separator];
        refline.lineHeight = 1;
    }];


    YHLineChartItem * item = [YHLineChartItem new];
    item.coordInfoViewShow = YES;
    item.lineColor = [UIColor yh_blue];
    item.lineShowShadow = YES;
    item.lineShadowColorTop = [[UIColor yh_blue] colorWithAlphaComponent:0.8];
    item.lineShadowColorBottom = [[UIColor yh_blue] colorWithAlphaComponent:0.1];
    item.pointFillColor = [UIColor whiteColor];
    item.pointLineColor = [UIColor yh_blue];
    item.pointLineWidth = 1;
    item.pointRadius = 3;
    item.pointPicker.showReflineVertical = YES;
    item.pointPicker.showReflineHorizontal = YES;
    item.pointPicker.canSelect = YES;
    item.pointPicker.radius = 4;
    item.pointPicker.fillColor = [UIColor yh_blue];
    item.pointPicker.lineWidth = 0;
    [item.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
        YHPointToastView * toastView = [YHPointToastView new];
        NSString * contentY = [NSString stringWithFormat:@"Y轴: %lf",passPoint.valueY];
        NSString * contentX = [NSString stringWithFormat:@"X轴: %lf",passPoint.valueX];
        NSString * content = [NSString stringWithFormat:@"%@\n%@",contentY,contentX];
        toastView.textTitle.text = content;
        return toastView;
    }];
    
    for(NSInteger i = 0; i < 11; i++){
        [item addPoint:[YHLinePointItem valueX:i valueY:(i*4)%11]];
    }
    
    [chartView addLineChart:item];
    
    [contentView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(Adapted(180));

    }];
    
    
    YHDebugMenu * axisMenu = [YHDebugMenu new];
    [contentView addSubview:axisMenu];
    [axisMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chartView.mas_bottom).offset(Adapted(10));
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(Adapted(45));
    }];

    NSMutableArray * scaleList4_1 = [NSMutableArray new];;
    NSMutableArray * scaleList4_2 = [NSMutableArray new];;
    
    for(NSInteger i = 0; i < 11; i++){
        [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@(i+20).stringValue) value:i+20]];
    }

    for(NSInteger i = 0; i < 11; i++){
        [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@(i).stringValue) value:i]];
    }

    void(^AddLineBlock)(void) = ^(void) {
        
        NSInteger xMin = chartView.axisInfo.axisInfoX.minValue;
        NSInteger xMax = chartView.axisInfo.axisInfoX.maxValue;
        NSInteger yMin = chartView.axisInfo.axisInfoY.minValue;
        NSInteger yMax = chartView.axisInfo.axisInfoY.maxValue;
        
        YHLineChartItem * addItem = item.yy_modelCopy;
        NSMutableArray * pointList = [NSMutableArray new];
        for(NSInteger i = 0; i < xMax-xMin+1; i++){
            CGFloat valueY = (i*4 + arc4random()%MAX(5, yMin) + arc4random()%yMax)%yMax;
            while (valueY < yMin ||
                   valueY > yMax) {
                valueY = (i*4 + arc4random()%MAX(5, yMin) + arc4random()%yMax)%yMax;
            }
            [pointList addObject:[YHLinePointItem valueX:i+xMin valueY:valueY]];
        }
        [addItem resetPointList:pointList];

        [addItem updateLineReferenceAxisXDirection:chartView.axisInfo.axisDirectionX axisYDirection:chartView.axisInfo.axisDirectionY];
        [chartView addLineChart:addItem];
    };
    
    void(^AddReflineBlock)(void) = ^(void) {

        [chartView addReflineAxisPosition:(YHChartAxisPos_Left) width:2 color:[UIColor yh_separator_dark] dotted:NO];
        [chartView addReflineAxisPosition:(YHChartAxisPos_Bottom) width:2 color:[UIColor yh_separator_dark] dotted:NO];
        [chartView addReflineAxisPosition:(YHChartAxisPos_Right) width:2 color:[UIColor yh_separator_dark] dotted:NO];
        [chartView addReflineAxisPosition:(YHChartAxisPos_Top) width:2 color:[UIColor yh_separator_dark] dotted:NO];

        [chartView addReflineAllAxisPos:YHChartAxisPos_Left config:^(YHReflineInfo * _Nonnull refline) {
            refline.lineColor = [UIColor yh_separator];
            refline.lineHeight = 1;
        }];
        [chartView addReflineAllAxisPos:YHChartAxisPos_Top config:^(YHReflineInfo * _Nonnull refline) {
            refline.lineColor = [UIColor yh_separator];
            refline.lineHeight = 1;
        }];
        [chartView addReflineAllAxisPos:YHChartAxisPos_Right config:^(YHReflineInfo * _Nonnull refline) {
            refline.lineColor = [UIColor yh_separator];
            refline.lineHeight = 1;
        }];
        [chartView addReflineAllAxisPos:YHChartAxisPos_Bottom config:^(YHReflineInfo * _Nonnull refline) {
            refline.lineColor = [UIColor yh_separator];
            refline.lineHeight = 1;
        }];

        //折线数据
        AddLineBlock();
    };

    [axisMenu addMenu:@"坐标轴\nY左X下" action:^{
        [chartView clean];
        
        [chartView updateAxisScaleList:scaleList4_2 width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop)];
        [chartView updateAxisScaleList:scaleList4_1 width:30 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight)];

        AddReflineBlock();
    }];
    [axisMenu addMenu:@"Y左X上" action:^{
        [chartView clean];

        [chartView updateAxisScaleList:scaleList4_2 width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_TopToBottom)];
        [chartView updateAxisScaleList:scaleList4_1 width:30 position:(YHChartAxisPos_Top) dirction:(YHChartAxisDirection_LeftToRight)];

        AddReflineBlock();
    }];
    [axisMenu addMenu:@"Y右X下" action:^{
        [chartView clean];

        [chartView updateAxisScaleList:scaleList4_2 width:30 position:(YHChartAxisPos_Right) dirction:(YHChartAxisDirection_BottomToTop)];
        [chartView updateAxisScaleList:scaleList4_1 width:30 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_RightToLeft)];

        AddReflineBlock();
    }];
    [axisMenu addMenu:@"Y右X上" action:^{
        [chartView clean];
        
        [chartView updateAxisScaleList:scaleList4_2 width:30 position:(YHChartAxisPos_Right) dirction:(YHChartAxisDirection_TopToBottom)];
        [chartView updateAxisScaleList:scaleList4_1 width:30 position:(YHChartAxisPos_Top) dirction:(YHChartAxisDirection_RightToLeft)];

        AddReflineBlock();
    }];

    [axisMenu layoutIfNeeded];
    


    //坐标轴的宽度 设置位置信息
    YHDebugMenu * axisWidthMenu = [YHDebugMenu new];
    [contentView addSubview:axisWidthMenu];
    [axisWidthMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.top.equalTo(axisMenu.mas_bottom).offset(Adapted(10));
        make.height.mas_equalTo(Adapted(45));
    }];

    void(^UpdateAxisWidth)(CGFloat wx,CGFloat wy) = ^(CGFloat wx,CGFloat wy) {

        YHAxisElementInfo * axisInfoX = chartView.axisInfo.axisInfoX;
        NSArray * listX = axisInfoX.list.copy;
        YHChartAxisPos posX = axisInfoX.axisPosition;
        YHChartAxisDirection directionX = axisInfoX.axisDirction;
        BOOL deuceX = axisInfoX.isDeuceByScale;

        YHAxisElementInfo * axisInfoY = chartView.axisInfo.axisInfoY;
        NSArray * listY = axisInfoY.list.copy;
        YHChartAxisPos posY = axisInfoY.axisPosition;
        YHChartAxisDirection directionY = axisInfoY.axisDirction;
        BOOL deuceY = axisInfoY.isDeuceByScale;

        [chartView clean];

        [chartView updateAxisScaleList:listX width:wx position:posX dirction:directionX config:^(YHAxisElementInfo * _Nonnull axisInfo) {
            axisInfo.isDeuceByScale = deuceX;
        }];
        [chartView updateAxisScaleList:listY width:wy position:posY dirction:directionY config:^(YHAxisElementInfo * _Nonnull axisInfo) {
            axisInfo.isDeuceByScale = deuceY;
        }];

        AddReflineBlock();
    };

    [axisWidthMenu addMenu:@"轴宽度\nX:30 Y:0" action:^{
        UpdateAxisWidth(30,0);
    }];

    [axisWidthMenu addMenu:@"X:0 Y:30" action:^{
        UpdateAxisWidth(0,30);
    }];

    [axisWidthMenu addMenu:@"X:0 Y:0" action:^{
        UpdateAxisWidth(0,0);
    }];

    [axisWidthMenu addMenu:@"X:30 Y:30" action:^{
        UpdateAxisWidth(30,30);
    }];

    [axisWidthMenu layoutIfNeeded];
    
    
    
    //坐标轴的刻度变化
    YHDebugMenu * axisScaleMenu = [YHDebugMenu new];
    [contentView addSubview:axisScaleMenu];
    [axisScaleMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.top.equalTo(axisWidthMenu.mas_bottom).offset(Adapted(10));
        make.height.mas_equalTo(Adapted(60));
    }];

    
    void(^ScaleMenuBlock)(NSInteger xMin, NSInteger xMax, NSInteger yMin, NSInteger yMax) = ^(NSInteger xMin, NSInteger xMax, NSInteger yMin, NSInteger yMax) {
        [scaleList4_1 removeAllObjects];
        [scaleList4_2 removeAllObjects];
        
        for(NSInteger i = 0; i < xMax-xMin+1; i++){
            [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@(i+xMin).stringValue) value:i+xMin]];
        }

        for(NSInteger i = 0; i < yMax-yMin+1; i++){
            [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@(i+yMin).stringValue) value:i+yMin]];
        }
        
        YHAxisElementInfo * axisInfoX = chartView.axisInfo.axisInfoX;
        YHChartAxisPos posX = axisInfoX.axisPosition;
        YHChartAxisDirection directionX = axisInfoX.axisDirction;
        CGFloat wx = axisInfoX.titleWidth;
        
        YHAxisElementInfo * axisInfoY = chartView.axisInfo.axisInfoY;
        YHChartAxisPos posY = axisInfoY.axisPosition;
        YHChartAxisDirection directionY = axisInfoY.axisDirction;
        CGFloat wy = axisInfoY.titleWidth;
        
        [chartView clean];

        [chartView updateAxisScaleList:scaleList4_1 width:wx position:posX dirction:directionX];
        [chartView updateAxisScaleList:scaleList4_2 width:wy position:posY dirction:directionY];

        AddLineBlock();
    };
    
    
    [axisScaleMenu addMenu:@"轴刻度范围\nX:20-30\nY:40-50" action:^{
        ScaleMenuBlock(20,30,40,50);
    }];

    [axisScaleMenu addMenu:@"X:20-30\nY:0-10" action:^{
        ScaleMenuBlock(20,30,0,10);
    }];

    [axisScaleMenu addMenu:@"X:0-10\nY:40-50" action:^{
        ScaleMenuBlock(0,10,40,50);
    }];

    [axisScaleMenu addMenu:@"X:0-10\nY:0-10" action:^{
        ScaleMenuBlock(0,10,0,10);
    }];

    [axisScaleMenu layoutIfNeeded];
    
    
    void(^DeuceAxixMenuBlock)(BOOL deuceX,BOOL deuceY) = ^(BOOL deuceX,BOOL deuceY) {
        
        [scaleList4_1 removeAllObjects];
        [scaleList4_2 removeAllObjects];
        
        [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@"1") value:1]];
        [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@"3") value:3]];
        [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@"9") value:9]];
        [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@"27") value:27]];

        [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@"1") value:1]];
        [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@"3") value:3]];
        [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@"9") value:9]];
        [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@"27") value:27]];
        

        YHAxisElementInfo * axisInfoX = chartView.axisInfo.axisInfoX;
        YHChartAxisPos posX = axisInfoX.axisPosition;
        YHChartAxisDirection directionX = axisInfoX.axisDirction;
        CGFloat wx = axisInfoX.titleWidth;

        YHAxisElementInfo * axisInfoY = chartView.axisInfo.axisInfoY;
        YHChartAxisPos posY = axisInfoY.axisPosition;
        YHChartAxisDirection directionY = axisInfoY.axisDirction;
        CGFloat wy = axisInfoY.titleWidth;
        
        [chartView clean];

        [chartView updateAxisScaleList:scaleList4_1 width:wx position:(posX) dirction:(directionX) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
            axisInfo.isDeuceByScale = deuceX;
        }];
        [chartView updateAxisScaleList:scaleList4_2 width:wy position:(posY) dirction:(directionY) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
            axisInfo.isDeuceByScale = deuceY;
        }];
        
        AddLineBlock();
    };
    
    //刻度 平分坐标轴
    YHDebugMenu * axisDeuceMenu = [YHDebugMenu new];
    [contentView addSubview:axisDeuceMenu];
    [axisDeuceMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.top.equalTo(axisScaleMenu.mas_bottom).offset(Adapted(10));
        make.height.mas_equalTo(Adapted(60));
//        make.bottom.equalTo(contentView).offset(Adapted(-10));
    }];

    [axisDeuceMenu addMenu:@"平分轴刻度\nX:平分\nY:不平分" action:^{
        DeuceAxixMenuBlock(YES,NO);
    }];

    [axisDeuceMenu addMenu:@"X:不平分\nY:平分" action:^{
        DeuceAxixMenuBlock(NO,YES);
    }];

    [axisDeuceMenu addMenu:@"X:平分\nY:平分" action:^{
        DeuceAxixMenuBlock(YES,YES);
    }];

    [axisDeuceMenu addMenu:@"X:不平分\nY:不平分" action:^{
        DeuceAxixMenuBlock(NO,NO);
    }];

    [axisDeuceMenu layoutIfNeeded];
    

    
    //双X Y 轴
    
    void(^DoubleAxisBlock)(BOOL doubleX, BOOL doubleY) = ^(BOOL doubleX, BOOL doubleY) {
         
        [scaleList4_1 removeAllObjects];
        [scaleList4_2 removeAllObjects];
        
        NSMutableArray * scaleList4_1_1 = [NSMutableArray new];
        NSMutableArray * scaleList4_2_1 = [NSMutableArray new];
        
        [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@"1") value:1]];
        [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@"3") value:3]];
        [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@"9") value:9]];
        [scaleList4_1 addObject:[YHScaleItem att:YHHTitle(@"27") value:27]];
        
        [scaleList4_1_1 addObject:[YHScaleItem att:YHHTitle(@"10") value:10]];
        [scaleList4_1_1 addObject:[YHScaleItem att:YHHTitle(@"20") value:20]];
        [scaleList4_1_1 addObject:[YHScaleItem att:YHHTitle(@"30") value:30]];
        [scaleList4_1_1 addObject:[YHScaleItem att:YHHTitle(@"40") value:40]];
        [scaleList4_1_1 addObject:[YHScaleItem att:YHHTitle(@"50") value:50]];
        [scaleList4_1_1 addObject:[YHScaleItem att:YHHTitle(@"60") value:60]];

        [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@"1") value:1]];
        [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@"3") value:3]];
        [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@"9") value:9]];
        [scaleList4_2 addObject:[YHScaleItem att:YHHTitle(@"27") value:27]];
        
        [scaleList4_2_1 addObject:[YHScaleItem att:YHHTitle(@"10") value:10]];
        [scaleList4_2_1 addObject:[YHScaleItem att:YHHTitle(@"20") value:20]];
        [scaleList4_2_1 addObject:[YHScaleItem att:YHHTitle(@"30") value:30]];
        [scaleList4_2_1 addObject:[YHScaleItem att:YHHTitle(@"40") value:40]];
        [scaleList4_2_1 addObject:[YHScaleItem att:YHHTitle(@"50") value:50]];
        
        [chartView clean];

        if(doubleX){
            
            [chartView updateAxisScaleList:scaleList4_1 width:30 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight)];
            
            if(doubleY){
                [chartView updateAxisScaleList:scaleList4_2 width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop)];
                [chartView updateAxisScaleList:scaleList4_2_1 width:30 position:(YHChartAxisPos_Right) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
                    axisInfo.otherAxis = chartView.axisInfo.axisPos(YHChartAxisPos_Bottom);
                }];
            }else{
                [chartView updateAxisScaleList:scaleList4_2 width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop)];
            }
            
            [chartView updateAxisScaleList:scaleList4_1_1 width:30 position:(YHChartAxisPos_Top) dirction:(YHChartAxisDirection_LeftToRight) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
                axisInfo.otherAxis = chartView.axisInfo.axisPos(YHChartAxisPos_Left);
            }];
        }else{
            [chartView updateAxisScaleList:scaleList4_1 width:30 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight)];
            
            if(doubleY){
                [chartView updateAxisScaleList:scaleList4_2 width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop)];
                [chartView updateAxisScaleList:scaleList4_2_1 width:30 position:(YHChartAxisPos_Right) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
                    axisInfo.otherAxis = chartView.axisInfo.axisPos(YHChartAxisPos_Bottom);
                }];
            }else{
                [chartView updateAxisScaleList:scaleList4_2 width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop)];
            }
        }
        

        [chartView addReflineAxisPosition:(YHChartAxisPos_Left) width:2 color:[UIColor yh_separator_dark] dotted:NO];
        [chartView addReflineAxisPosition:(YHChartAxisPos_Bottom) width:2 color:[UIColor yh_separator_dark] dotted:NO];
        [chartView addReflineAxisPosition:(YHChartAxisPos_Right) width:2 color:[UIColor yh_separator_dark] dotted:NO];
        [chartView addReflineAxisPosition:(YHChartAxisPos_Top) width:2 color:[UIColor yh_separator_dark] dotted:NO];

        [chartView addReflineAllAxisPos:YHChartAxisPos_Left config:^(YHReflineInfo * _Nonnull refline) {
            refline.lineColor = [UIColor redColor];
            refline.lineHeight = 1;
        }];
        [chartView addReflineAllAxisPos:YHChartAxisPos_Top config:^(YHReflineInfo * _Nonnull refline) {
            refline.lineColor = [UIColor redColor];
            refline.lineHeight = 1;
        }];
        [chartView addReflineAllAxisPos:YHChartAxisPos_Right config:^(YHReflineInfo * _Nonnull refline) {
            refline.lineColor = [UIColor blueColor];
            refline.lineHeight = 1;
        }];
        [chartView addReflineAllAxisPos:YHChartAxisPos_Bottom config:^(YHReflineInfo * _Nonnull refline) {
            refline.lineColor = [UIColor blueColor];
            refline.lineHeight = 1;
        }];
        
        
        
        NSInteger xMin = chartView.axisInfo.axisInfoX.minValue;
        NSInteger xMax = chartView.axisInfo.axisInfoX.maxValue;
        NSInteger yMin = chartView.axisInfo.axisInfoY.minValue;
        NSInteger yMax = chartView.axisInfo.axisInfoY.maxValue;
        
        [chartView removeLineChart:item];
        
        //添加一条线 参考默认坐标轴的方向
        YHLineChartItem * addItem = item.yy_modelCopy;
        NSMutableArray * pointList = [NSMutableArray new];
        for(NSInteger i = 0; i < xMax-xMin+1; i++){
            if(i%3 == 0 || i == xMax-xMin){
                CGFloat valueY = (i*4 + arc4random()%MAX(5, yMin) + arc4random()%yMax)%yMax;
                while (valueY < yMin ||
                       valueY > yMax) {
                    valueY = (i*4 + arc4random()%MAX(5, yMin) + arc4random()%yMax)%yMax;
                }
                [pointList addObject:[YHLinePointItem valueX:i+xMin valueY:valueY]];
            }
        }
        [addItem resetPointList:pointList];
        [chartView addLineChart:addItem];
        
        if(doubleY){
            NSInteger yMin = chartView.axisInfo.axisInfoYOther.minValue;
            NSInteger yMax = chartView.axisInfo.axisInfoYOther.maxValue;
            
            //再新增一条线 参考方向是坐标轴的另外一边
            YHLineChartItem * addItem = item.yy_modelCopy;
            addItem.lineShadowColorTop = [[UIColor redColor] colorWithAlphaComponent:0.8];
            addItem.lineShadowColorBottom = [[UIColor redColor] colorWithAlphaComponent:0.1];
            addItem.lineColor = [UIColor redColor];
            NSMutableArray * pointList = [NSMutableArray new];
            for(NSInteger i = 0; i < xMax-xMin+1; i++){
                if(i%3 == 0 || i == xMax-xMin){
                    CGFloat valueY = (i*4 + arc4random()%MAX(5, yMin) + arc4random()%yMax)%yMax;
                    while (valueY < yMin ||
                           valueY > yMax) {
                        valueY = (i*4 + arc4random()%MAX(5, yMin) + arc4random()%yMax)%yMax;
                    }
                    [pointList addObject:[YHLinePointItem valueX:i+xMin valueY:valueY]];
                }
            }
            [addItem resetPointList:pointList];
            addItem.referYOther = YES;
            [chartView addLineChart:addItem];
        }
    };
        
    YHDebugMenu * doubleAxisMenu = [YHDebugMenu new];
    [contentView addSubview:doubleAxisMenu];
    [doubleAxisMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(Adapted(45));
        make.top.equalTo(axisDeuceMenu.mas_bottom).offset(Adapted(15));
        make.bottom.equalTo(contentView).offset(Adapted(-10));
    }];

    [doubleAxisMenu addMenu:@"单 X 单 Y" action:^{
        DoubleAxisBlock(NO,NO);
    }];
    [doubleAxisMenu addMenu:@"单 X 双 Y" action:^{
        DoubleAxisBlock(NO,YES);
    }];
    [doubleAxisMenu addMenu:@"双 X 单 Y" action:^{
        DoubleAxisBlock(YES,NO);
    }];
    [doubleAxisMenu addMenu:@"双 X 双 Y" action:^{
        DoubleAxisBlock(YES,YES);
    }];
    [doubleAxisMenu layoutIfNeeded];
    
    
    
    return contentView;
}



- (UIView *)chartView5{
    
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
    
    return contentView;
}

///  X 双Y 轴
- (UIView *)chartView6{
    
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
    
    return contentView;
}



- (UIView *)chartView7{
    
    UIView * contentView = [UIView new];
        
    YHLineChartView * chartView = [YHLineChartView new];
    
    NSMutableArray * scaleList = [NSMutableArray new];

    [scaleList addObject:[YHScaleItem att:YHHTitle(@"10%") value:10]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"20%") value:20]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"30%") value:30]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"40%") value:40]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"50%") value:50]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"60%") value:60]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"70%") value:70]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"80%") value:80]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"90%") value:90]];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"100%") value:100]];
    [chartView updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.minValue = 0;
    }];
    
    
    [scaleList removeAllObjects];
    [scaleList addObject:[YHScaleItem att:YHHTitle(@"0") value:0]];
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
    [chartView updateAxisScaleList:scaleList width:30 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.minValue = 0;
    }];
    
    
    [chartView addReflineAllAxisPos:YHChartAxisPos_Left config:^(YHReflineInfo * _Nonnull refline) {
        refline.lineColor = [UIColor whiteColor];
        refline.lineHeight = 1;
    }];

    
    [contentView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(Adapted(200));
    }];
    
    
    UILabel * titleV = [UILabel new];
    titleV.textAlignment = NSTextAlignmentCenter;
    titleV.text = @"柱状图";
    [contentView addSubview:titleV];
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.equalTo(contentView);
       make.top.equalTo(chartView.mas_bottom).offset(Adapted(10));
    }];
    
    
   
    
    void(^AddLineBarBlock)(BOOL isBar) = ^(BOOL isBar) {

        YHLineChartItem * item = [YHLineChartItem new];
        item.showType = isBar?YHChartShowType_Bar:YHChartShowType_Line;
        item.barCenterToScaleOffset = 0;
        item.lineColor = [UIColor yh_randomcolor];
        item.lineWidth = isBar?Adapted(5):Adapted(1);
        item.smoothness = YES;
        item.lineShowShadow = YES;
        item.lineShadowColorTop = [item.lineColor colorWithAlphaComponent:0.8];
        item.lineShadowColorBottom = [item.lineColor colorWithAlphaComponent:0.2];
        item.pointShow = YES;
        item.pointRadius = 3;
        item.pointFillColor = [UIColor whiteColor];
        item.pointLineColor = item.lineColor;
        item.pointLineWidth = 2;
        item.pointPicker.canSelect = YES;
        item.pointPicker.radius = Adapted(10);
        item.pointPicker.barSelectSingle = NO;
        item.pointPicker.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
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

        if(isBar){
            [chartView barCenterOffsetUpdateByContentWidth:16 barSpace:2 barWidth:Adapted(5)];
        }
    };
    
    
    
    AddLineBarBlock(YES);
    
    YHDebugMenu * barMenu = [YHDebugMenu new];
    [contentView addSubview:barMenu];
    [barMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(Adapted(45));
        make.top.equalTo(titleV.mas_bottom).offset(Adapted(15));
//        make.bottom.equalTo(contentView).offset(Adapted(-10));
    }];

    [barMenu addMenu:@"添加柱状" action:^{
        AddLineBarBlock(YES);
    }];
    [barMenu addMenu:@"更新柱状" action:^{
        NSArray <YHLineChartItem *>* barList = [chartView getBarList];
        if(barList.count == 0){
            return;
        }
        YHLineChartItem * randomLine = barList[arc4random()%barList.count];
        
        NSMutableArray * list = [NSMutableArray new];
        for(NSInteger i = 1; i < 100; i++){
            if(i%5 == 0){
                CGFloat preValueY = arc4random()%100;
                YHLinePointItem * point = [YHLinePointItem valueX:i valueY:@(preValueY).doubleValue];
                [list addObject:point];
            }
        }
        [randomLine resetPointList:list];
        
        [chartView updateLineChart:randomLine];
    }];
    [barMenu addMenu:@"删除柱状" action:^{
        NSArray <YHLineChartItem *>* barList = [chartView getBarList];
        if(barList.count == 0){
            return;
        }
        YHLineChartItem * randomLine = barList[arc4random()%barList.count];
        [chartView removeLineChart:randomLine];
        
        [chartView barCenterOffsetUpdateByContentWidth:16 barSpace:2 barWidth:Adapted(5)];
    }];
    [barMenu layoutIfNeeded];
    
    
    
    
    
    void(^RemoveBarSingle)(void) = ^(void) {
        NSArray <YHLineChartItem *>* barList = [chartView getBarList];
        for(YHLineChartItem * item in barList){
            [chartView removeLineChart:item];
        }
    };
    
    void(^CombineAdd)(void) = ^(void) {
        YHLineChartItem * item = [YHLineChartItem new];
        item.showType = YHChartShowType_BarCombine;
        item.lineColor = [UIColor yh_randomcolor];
        item.lineWidth = Adapted(5);
        item.pointPicker.canSelect = YES;
        item.pointPicker.radius = Adapted(10);
        item.pointPicker.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
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
                CGFloat preValueY = arc4random()%30;
                YHLinePointItem * point = [YHLinePointItem valueX:i valueY:@(preValueY).doubleValue];
                [item addPoint:point];
            }
        }
        [chartView addLineChart:item];
    };
    
    
    YHDebugMenu * combineMenu = [YHDebugMenu new];
    [contentView addSubview:combineMenu];
    [combineMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(Adapted(45));
        make.top.equalTo(barMenu.mas_bottom).offset(Adapted(15));
//        make.bottom.equalTo(contentView).offset(Adapted(-10));
    }];

    [combineMenu addMenu:@"多柱状图添加" action:^{
        RemoveBarSingle();
        
        CombineAdd();
    }];
    [combineMenu addMenu:@"多柱状图更新" action:^{
        RemoveBarSingle();
        
        NSArray <YHLineChartItem *>* barComList = [chartView getBarCombineList];
        if(barComList.count == 0){
            return;
        }
        YHLineChartItem * randomLine = barComList[arc4random()%barComList.count];
        
        NSMutableArray * list = [NSMutableArray new];
        for(NSInteger i = 1; i < 100; i++){
            if(i%5 == 0){
                CGFloat preValueY = arc4random()%30;
                YHLinePointItem * point = [YHLinePointItem valueX:i valueY:@(preValueY).doubleValue];
                [list addObject:point];
            }
        }
        [randomLine resetPointList:list];
        
        [chartView updateLineChart:randomLine];
    }];
    [combineMenu addMenu:@"多柱状图删除" action:^{
        RemoveBarSingle();
        
        NSArray <YHLineChartItem *>* lineList = [chartView getBarCombineList];
        if(lineList.count == 0){
            return;
        }
        YHLineChartItem * randomLine = lineList[arc4random()%lineList.count];
        [chartView removeLineChart:randomLine];
    }];
    [combineMenu layoutIfNeeded];
    
    
    
    YHDebugMenu * lineMenu = [YHDebugMenu new];
    [contentView addSubview:lineMenu];
    [lineMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(Adapted(45));
        make.top.equalTo(combineMenu.mas_bottom).offset(Adapted(15));
//        make.bottom.equalTo(contentView).offset(Adapted(-10));
    }];

    [lineMenu addMenu:@"添加折线" action:^{
        AddLineBarBlock(NO);
    }];
    [lineMenu addMenu:@"更新折线" action:^{
        NSArray <YHLineChartItem *>* lineList = [chartView getLineList];
        if(lineList.count == 0){
            return;
        }
        YHLineChartItem * randomLine = lineList[arc4random()%lineList.count];
        
        NSMutableArray * list = [NSMutableArray new];
        for(NSInteger i = 1; i < 100; i++){
            if(i%5 == 0){
                CGFloat preValueY = arc4random()%100;
                YHLinePointItem * point = [YHLinePointItem valueX:i valueY:@(preValueY).doubleValue];
                [list addObject:point];
            }
        }
        [randomLine resetPointList:list];
        
        [chartView updateLineChart:randomLine];
    }];
    [lineMenu addMenu:@"删除折线" action:^{
        NSArray <YHLineChartItem *>* lineList = [chartView getLineList];
        if(lineList.count == 0){
            return;
        }
        YHLineChartItem * randomLine = lineList[arc4random()%lineList.count];
        [chartView removeLineChart:randomLine];
    }];
    [lineMenu layoutIfNeeded];

    //颜色
   YHDebugMenu * colorMenu = [YHDebugMenu new];
   [contentView addSubview:colorMenu];
   [colorMenu mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(contentView);
       make.right.equalTo(contentView);
       make.top.equalTo(lineMenu.mas_bottom).offset(Adapted(10));
       make.height.mas_equalTo(Adapted(45));

       make.bottom.equalTo(contentView).offset(Adapted(-10));
   }];

   [colorMenu addMenu:@"线条色/阴影色" action:^{
       NSArray <YHLineChartItem *>* lineList = [chartView getLineList];
       if(lineList.count == 0){
           return;
       }
       YHLineChartItem * randomLine = lineList[arc4random()%lineList.count];

       UIColor * randoYHolor = [UIColor yh_randomcolor];
       randomLine.lineWidth = arc4random()%5 + 2;
       randomLine.lineColor = randoYHolor;
       randomLine.lineShadowColorTop = [randoYHolor colorWithAlphaComponent:0.8];
       randomLine.lineShadowColorBottom = [randoYHolor colorWithAlphaComponent:0.1];
       [chartView updateLineChartUnRelayout:randomLine];
   }];

   [colorMenu addMenu:@"线条点" action:^{
       NSArray <YHLineChartItem *>* lineList = [chartView getLineList];
       if(lineList.count == 0){
           return;
       }
       YHLineChartItem * randomLine = lineList[arc4random()%lineList.count];

       UIColor * randoYHolor = [UIColor yh_randomcolor];
       randomLine.pointRadius = arc4random()%5 + 2;
       randomLine.pointLineColor = randoYHolor;
       randomLine.pointLineWidth = arc4random()%3 + 1;
       [chartView updateLineChartUnRelayout:randomLine];
   }];

   [colorMenu addMenu:@"柱状图色" action:^{
       NSArray <YHLineChartItem *>* barList = [chartView getBarList];
       if(barList.count == 0){
           return;
       }
       YHLineChartItem * randomBar = barList[arc4random()%barList.count];

       randomBar.lineColor = [UIColor yh_randomcolor];
       randomBar.lineWidth = arc4random()%5 + 2;
       [chartView updateLineChartUnRelayout:randomBar];
   }];

   [colorMenu layoutIfNeeded];
    
    
    return contentView;

}



- (UIView *)chartView8{
    
    UIView * contentView = [UIView new];
            
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
        make.bottom.equalTo(contentView).offset(Adapted(-20));
    }];
   
    
    return contentView;
    
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
