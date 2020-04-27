//
//  YHPointToastView.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/15.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHPointToastView.h"
#import "UIColor+YHStyle.h"
#import "UIFont+YH.h"
#import <Masonry/Masonry.h>
#import "YHConstant.h"

@implementation YHPointToastView

-(void)yh_commonInit{
    
    self.backgroundColor = [[UIColor yh_colorWithHexString:@"#494D5E"] colorWithAlphaComponent:0.8];
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    
    self.textTitle = [UILabel new];
    self.textTitle.textAlignment = NSTextAlignmentLeft;
    self.textTitle.textColor = [UIColor whiteColor];
    self.textTitle.font = [UIFont yh_pfOfSize:14];
    self.textTitle.numberOfLines = 0;
    [self addSubview:self.textTitle];
    [self.textTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Adapted(5));
        make.top.equalTo(self).offset(Adapted(5));
        make.right.equalTo(self).offset(Adapted(-5));
        make.bottom.equalTo(self).offset(Adapted(-5));
    }];
}

@end
