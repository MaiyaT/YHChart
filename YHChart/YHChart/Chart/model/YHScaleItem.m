//
//  YHScaleItem.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHScaleItem.h"

@implementation YHScaleItem

+ (instancetype)att:(NSAttributedString *)att value:(CGFloat)value{
    YHScaleItem * item = [YHScaleItem new];
    item.attString = att;
    item.value = value;
    return item;
}
+ (instancetype)value:(CGFloat)value{
    YHScaleItem * item = [YHScaleItem new];
    item.value = value;
    return item;
}

-(NSAttributedString *)attString{
    if(_attString){
        return _attString;
    }
    if(self.format){
        _attString = [self.format attributeStringFromValue:self.value];
    }
    return _attString;
}

@end
