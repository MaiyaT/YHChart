//
//  YHChartsDeBugViewController9.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController9.h"

@interface YHFormatDebug9 : NSObject<YHFormatProtocol>

@end

@implementation YHFormatDebug9

-(NSAttributedString *)attributeStringFromValue:(CGFloat)value{
    NSString * str = [NSString stringWithFormat:@"%.1f",value];
    return [NSMutableAttributedString yh_initWithStr:str customBlock:^(NSMutableAttributedString *att) {
        [att yh_font:[UIFont yh_pfOfSize:15]];
        [att yh_color:[UIColor yh_blue]];
    }];
}

@end


@interface YHChartsDeBugViewController9 ()

@end

@implementation YHChartsDeBugViewController9

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
    
    NSMutableArray * pointList = [NSMutableArray new];
    for(NSInteger i = 0; i < 11; i++){
        [pointList addObject:[YHLinePointItem valueX:i valueY:(i*4)%11]];
    }
    
    
    YHLineChartView * chartView = [YHLineChartView new];

    [chartView updateAxisAutoScaleCount:20
                              pointList:pointList
                                 format:[YHFormatDebug9 new]
                                  width:40
                               position:YHChartAxisPos_Bottom
                               dirction:YHChartAxisDirection_LeftToRight
                                 config:nil];
    
    [chartView updateAxisAutoScaleCount:5
                              pointList:pointList
                                 format:[YHFormatDebug9 new]
                                  width:40
                               position:YHChartAxisPos_Left
                               dirction:YHChartAxisDirection_BottomToTop
                                 config:nil];
        
    //设置四边的轴的线条
    [chartView addReflineAxisPosition:0xff width:1 color:[UIColor yh_separator] dotted:NO];
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
    [item addPointList:pointList];
    
    [chartView addLineChart:item];
    
    [contentView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(Adapted(180));

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
