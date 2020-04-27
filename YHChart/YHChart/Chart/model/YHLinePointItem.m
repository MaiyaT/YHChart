//
//  YHLinePointItem.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLinePointItem.h"

@implementation YHLinePointItem

+ (instancetype)valueX:(CGFloat)valueX valueY:(CGFloat)valueY{
    return [YHLinePointItem valueX:valueX valueY:valueY showPoint:NO];
}

+ (instancetype)valueX:(CGFloat)valueX valueY:(CGFloat)valueY showPoint:(BOOL)show{
    YHLinePointItem * item = [YHLinePointItem new];
    item.valueX = valueX;
    item.valueY = valueY;
    item.showPoint = show;
    return item;
}

@end




@implementation YHScaleItemPrice



@end
