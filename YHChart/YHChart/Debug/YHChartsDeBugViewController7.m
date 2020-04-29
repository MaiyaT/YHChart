//
//  YHChartsDeBugViewController7.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController7.h"

@interface YHChartsDeBugViewController7 ()

@end

@implementation YHChartsDeBugViewController7

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

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
    
    
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.95);
        make.height.equalTo(self.view).multipliedBy(0.8);
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
