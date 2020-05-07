//
//  YHPieChartItem.m
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHPieChartItem.h"
#import "UIColor+YHStyle.h"
#import "NSDecimalNumber+YH.h"
#import "NSMutableAttributedString+YH.h"
#import "UIFont+YH.h"

@implementation YHPieChartItem

-(CGFloat)endPos{
    CGFloat pos = self.startPos + self.percent;
    pos = MIN(pos, 1);
    return pos;
}



-(NSAttributedString *)attString{
    if(_attString){
        return _attString;
    }
    if(self.format){
        _attString = [self.format attributeStringFromValue:self.percent];
        return _attString;
    }
    NSString * percentStr = [NSString stringWithFormat:@"%@%%",@(self.percent*100).yh_decimalMax(2)];
    _attString = [NSMutableAttributedString yh_initWithStr:percentStr customBlock:^(NSMutableAttributedString *att) {
        [att yh_font:[UIFont yh_pfOfSize:14]];
        [att yh_color:[UIColor yh_title_h2]];
    }];
    return _attString;
}


@end
