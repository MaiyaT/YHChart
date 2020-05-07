//
//  YHPointPickerConfig.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/14.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHPointPickerConfig.h"
#import "UIColor+YHStyle.h"

@implementation YHPointPickerConfig

-(void)yh_commonInit{
    self.reflineHWidth = 1;
    self.reflineVWidth = 1;
    
    self.fillColor = [UIColor clearColor];
    self.lineColor = [UIColor clearColor];
    
    self.reflineVColor = [UIColor yh_gray];
    self.reflineHColor = [UIColor yh_gray];
}

@end
