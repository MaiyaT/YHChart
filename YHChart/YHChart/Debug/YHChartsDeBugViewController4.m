//
//  YHChartsDeBugViewController4.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController4.h"

@interface YHChartsDeBugViewController4 ()

@end

@implementation YHChartsDeBugViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
