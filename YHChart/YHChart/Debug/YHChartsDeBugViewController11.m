//
//  YHChartsDeBugViewController11.m
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartsDeBugViewController11.h"
#import "YHPieChartView.h"
#import "NSDecimalNumber+YH.h"

@interface YHChartFormat11 : NSObject<YHFormatProtocol>

@end

@implementation YHChartFormat11
-(NSAttributedString *)attributeStringFromValue:(CGFloat)value{
    NSString * percentStr = [NSString stringWithFormat:@"%@%%",@(value*100).yh_decimalMax(2)];
    return [NSMutableAttributedString yh_initWithStr:percentStr customBlock:^(NSMutableAttributedString *att) {
        [att yh_font:[UIFont yh_pfOfSize:14]];
        [att yh_color:[UIColor yh_red]];
    }];
}
@end


@interface YHChartsDeBugViewController11 ()

@end

@implementation YHChartsDeBugViewController11

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
    
    YHPieChartView * chartView = [YHPieChartView new];
    chartView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.05];
    chartView.circleBgFillColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
    chartView.circleTopFillColor = [UIColor whiteColor];
    chartView.circleBorderWidth = 30;
    chartView.circleTopCenterAttTitle = [NSMutableAttributedString yh_initWithStr:@"我是中间的\n标题内容" customBlock:^(NSMutableAttributedString *att) {
        [att yh_font:[UIFont yh_pfOfSize:14]];
        [att yh_color:[UIColor yh_title_h3_note]];
        [att yh_color:[UIColor yh_red] range:[att.string rangeOfString:@"标题内容"]];
    }];
    [contentView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Adapted(200));
        make.width.mas_equalTo(Adapted(200));
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView);
    }];
  
    YHChartFormat11 * format = [YHChartFormat11 new];
    
    YHDebugMenu * menu = [YHDebugMenu new];
    [contentView addSubview:menu];
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.top.equalTo(chartView.mas_bottom).offset(Adapted(10));
        make.height.mas_equalTo(Adapted(45));
    }];

    [menu addMenu:@"新增" action:^{
        YHPieChartItem * item = [YHPieChartItem new];
        item.value = arc4random()%100 + 1;
        item.percent = item.value/200.0;
        item.filleColor = [UIColor yh_randomcolor];
        item.format = format;
        item.showAnnotation = YES;
        item.showAnnotationInside = YES;
        [chartView addPercentPieBlock:item];
    }];
    
    [menu addMenu:@"删除" action:^{
        if(chartView.pieInfoList.count == 0){
            return;
        }
        
        YHPieChartItem * item = chartView.pieInfoList[arc4random()%chartView.pieInfoList.count];
        [chartView deletePieBlock:item];
    }];
    
    [menu addMenu:@"满图" action:^{
        NSMutableArray * list = [NSMutableArray new];
        for(NSInteger i = 0; i<arc4random()%10+5; i++){
            YHPieChartItem * item = [YHPieChartItem new];
            item.value = arc4random()%100 + 1;
            item.filleColor = [UIColor yh_randomcolor];
            [list addObject:item];
        }
        [chartView resetPieAllBlock:list];
    }];
    
    [menu addMenu:@"清除" action:^{
        [chartView clean];
    }];

    [menu layoutIfNeeded];
    
    
    
    
    
    YHDebugMenu * circleMenu = [YHDebugMenu new];
    [contentView addSubview:circleMenu];
    [circleMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.top.equalTo(menu.mas_bottom).offset(Adapted(10));
        make.height.mas_equalTo(Adapted(45));
    }];

    [circleMenu addMenu:@"内圆半径 +" action:^{
        chartView.circleBorderWidth = chartView.circleBorderWidth - 10;
    }];
    
    [circleMenu addMenu:@"内圆半径 -" action:^{
        chartView.circleBorderWidth = chartView.circleBorderWidth + 10;
    }];
    
    [circleMenu addMenu:@"变色 内圆" action:^{
        chartView.circleTopFillColor = [[UIColor yh_randomcolor] colorWithAlphaComponent:0.1];
    }];
    
    [circleMenu addMenu:@"变色 外圆" action:^{
        chartView.circleBgFillColor = [[UIColor yh_randomcolor] colorWithAlphaComponent:0.1];
    }];

    [circleMenu layoutIfNeeded];
    
    
    
    
    YHDebugMenu * annotationMenu = [YHDebugMenu new];
    [contentView addSubview:annotationMenu];
    [annotationMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.top.equalTo(circleMenu.mas_bottom).offset(Adapted(10));
        make.height.mas_equalTo(Adapted(45));
    }];

    [annotationMenu addMenu:@"标注显示" action:^{
        [chartView showAllAnnotation:YES];
    }];
    
    [annotationMenu addMenu:@"标注影藏" action:^{
        [chartView showAllAnnotation:NO];
    }];
    
    [annotationMenu addMenu:@"标注内部" action:^{
        [chartView showAllAnnotationInside:YES];
    }];
    
    [annotationMenu addMenu:@"标注外部" action:^{
        [chartView showAllAnnotationInside:NO];
    }];

    [annotationMenu layoutIfNeeded];
    
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
