//
//  YHPointInfoView.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/17.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHPointInfoView.h"
#import "UIColor+YHStyle.h"
#import "UIFont+YH.h"
#import <Masonry.h>
#import "YHConstant.h"

@implementation YHPointInfoView


-(void)yh_commonInit{
    
    self.backgroundColor = [[UIColor yh_colorWithHexString:@"#494D5E"] colorWithAlphaComponent:0.2];
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    
    self.textTitle = [UILabel new];
    self.textTitle.textAlignment = NSTextAlignmentCenter;
    self.textTitle.textColor = [UIColor whiteColor];
    self.textTitle.font = [UIFont yh_pfOfSize:9];
    self.textTitle.numberOfLines = 0;
    [self addSubview:self.textTitle];
    [self.textTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Adapted(2));
        make.top.equalTo(self).offset(Adapted(2));
        make.right.equalTo(self).offset(Adapted(-2));
        make.bottom.equalTo(self).offset(Adapted(-2));
    }];
}


@end
