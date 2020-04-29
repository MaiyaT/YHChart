//
//  YHDebugBaseViewController.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHDebugBaseViewController.h"


NSMutableAttributedString * YHVTitle(NSString * title){
    NSMutableAttributedString * attTitle = [NSMutableAttributedString yh_initWithStr:title customBlock:^(NSMutableAttributedString *att) {
        [att yh_font:[UIFont yh_pfOfSize:12]];
        [att yh_color:[UIColor yh_colorWithHexString:@"#8C9AA8"]];
    }];
    return attTitle;
}
NSMutableAttributedString * YHHTitle(NSString * title){
    NSMutableAttributedString * attTitle = [NSMutableAttributedString yh_initWithStr:title customBlock:^(NSMutableAttributedString *att) {
        [att yh_font:[UIFont yh_pfOfSize:12]];
        [att yh_color:[UIColor yh_colorWithHexString:@"#1E2439"]];
    }];
    return attTitle;
}


@interface YHDebugBaseViewController ()

@end

@implementation YHDebugBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
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
