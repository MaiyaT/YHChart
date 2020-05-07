//
//  YHChartsDeBugViewController10.m
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController10.h"


@interface YHChartsFormart10 : NSObject<YHFormatProtocol>

@end
@implementation YHChartsFormart10
-(NSAttributedString *)attributeStringFromValue:(CGFloat)value{
    return [NSMutableAttributedString yh_initWithStr:[NSString stringWithFormat:@"3/%zd",(NSInteger)value] customBlock:^(NSMutableAttributedString *att) {
        [att yh_color:[UIColor yh_title_h1]];
        [att yh_font:[UIFont yh_pflOfSize:15]];
    }];
}
@end


@interface YHChartsDeBugViewController10 ()

@property(nonatomic,assign) BOOL isFullScreen;

@end

@implementation YHChartsDeBugViewController10

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.isFullScreen = YES;
    
    NSArray * pointList1 = @[
        [YHLinePointItem valueX:0 valueY:7.2],
        [YHLinePointItem valueX:5 valueY:7.5],
        [YHLinePointItem valueX:7 valueY:7.1],
        [YHLinePointItem valueX:15 valueY:7.0],
        [YHLinePointItem valueX:24 valueY:7.4],
        [YHLinePointItem valueX:30 valueY:7.3],
    ];
    
    NSArray * pointList2 = @[
        [YHLinePointItem valueX:0 valueY:7.07],
        [YHLinePointItem valueX:8 valueY:7.14],
        [YHLinePointItem valueX:12 valueY:7.08],
        [YHLinePointItem valueX:20 valueY:7.15],
        [YHLinePointItem valueX:22 valueY:7.1],
        [YHLinePointItem valueX:28 valueY:7.05],
        [YHLinePointItem valueX:30 valueY:7.2],
    ];
    
    NSArray * pointListAll = [pointList1 arrayByAddingObjectsFromArray:pointList2];
    
    YHLineChartView * chartView = [YHLineChartView new];
    chartView.backgroundColor = [[UIColor yh_randomcolor] colorWithAlphaComponent:0.02];
    [self.view addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(Adapted(20), Adapted(30), Adapted(20), Adapted(30)));
    }];
        
    [chartView updateAxisAutoScaleCount:20 pointList:pointListAll format:nil width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop) config:nil];
    [chartView updateAxisAutoScaleCount:9 pointList:pointListAll format:[YHChartsFormart10 new] width:30 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight) config:nil];
    
    [chartView addReflineAxisPosition:YHChartAxisPos_Left | YHChartAxisPos_Bottom  width:1 color:[UIColor yh_title_h1] dotted:NO];
    [chartView addReflineAllAxisPos:(YHChartAxisPos_Bottom | YHChartAxisPos_Left) config:nil];
    
    
    YHLineChartItem * item = [YHLineChartItem new];
    item.lineColor = [UIColor yh_colorWithHexString:@"#1678FF"];
    item.lineShowShadow = YES;
    item.lineShadowColorTop = [[UIColor yh_colorWithHexString:@"#1678FF"] colorWithAlphaComponent:0.28];
    item.lineShadowColorBottom = [[UIColor yh_colorWithHexString:@"#0086FF"] colorWithAlphaComponent:0.1];
    [item resetPointList:pointList1];
    item.smoothness = YES;
    item.pointFillColor = [UIColor whiteColor];
    item.pointLineColor = [UIColor yh_colorWithHexString:@"#1678FF"];
    item.pointLineWidth = 1;
    item.pointRadius = 3;
    item.pointShow = YES;
    item.pointPicker.canSelect = YES;
    item.pointPicker.showReflineVertical = YES;
    item.pointPicker.showReflineHorizontal = YES;
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

    item = [YHLineChartItem new];
    item.showType = YHChartShowType_Bar;
    item.lineColor = [UIColor yh_colorWithHexString:@"#AB1BFF"];
    item.lineWidth = 20;
    item.lineShowShadow = YES;
    item.lineShadowColorTop = [[UIColor yh_colorWithHexString:@"#AB1BFF"] colorWithAlphaComponent:0.2];
    item.lineShadowColorBottom = [[UIColor yh_colorWithHexString:@"#AB1BFF"] colorWithAlphaComponent:0.1];
    [item resetPointList:pointList2];
    item.smoothness = YES;
    [chartView addLineChart:item];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if(!self.parentViewController){
        self.isFullScreen = NO;
    }
}

@end
