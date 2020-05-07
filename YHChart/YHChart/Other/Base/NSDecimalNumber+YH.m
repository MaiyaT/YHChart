//
//  NSDecimalNumber+YH.m
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "NSDecimalNumber+YH.h"

@implementation NSDecimalNumber (YH)

+ (NSDecimalNumber *)yh_decimalNumberWithFloat:(float)value{
    
    return [self yh_decimalNumberWithFloat:value scale:2];
}

+ (NSDecimalNumber *)yh_decimalNumberWithFloat:(float)value scale:(short)scale{
    
    return [self yh_decimalNumberWithFloat:value roundingMode:NSRoundBankers scale:scale];
}

+ (NSDecimalNumber *)yh_decimalNumberWithFloat:(float)value roundingMode:(NSRoundingMode)roundingMode scale:(short)scale{
    
    return [[[NSDecimalNumber alloc] initWithFloat:value] yh_decimalNumberHandlerWithRoundingMode:roundingMode scale:scale];
}

+ (NSDecimalNumber *)yh_decimalNumberWithDouble:(double)value{
    
    return [self yh_decimalNumberWithDouble:value scale:2];
}

+ (NSDecimalNumber *)yh_decimalNumberWithDouble:(double)value scale:(short)scale{
    
    return [self yh_decimalNumberWithDouble:value roundingMode:NSRoundBankers scale:scale];
}

+ (NSDecimalNumber *)yh_decimalNumberWithDouble:(double)value roundingMode:(NSRoundingMode)roundingMode scale:(short)scale{
    
    return [[[NSDecimalNumber alloc] initWithFloat:value] yh_decimalNumberHandlerWithRoundingMode:roundingMode scale:scale];
}




/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSDecimalNumber *)yh_decimalNumberHandler{
    
    return [self yh_decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2];
}

- (NSDecimalNumber *)yh_decimalNumberHandlerWithRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale{
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode
                                                                                             scale:scale
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:YES
                                                                                  raiseOnUnderflow:YES
                                                                               raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:handler];
}



/// 只舍不入 六位小数
+ (NSString *)yh_6_decimalDownStr:(NSString *)valueStr{
    return [self yh_decimalWithValueStr:valueStr roundingMode:(NSRoundDown) scale:6];
}
+ (NSString *)yh_6_decimalDownDecimal:(NSDecimal)valueDecimal{
    return [self yh_decimalWithValueDecimal:valueDecimal roundingMode:(NSRoundDown) scale:6];
}
+ (NSString *)yh_2_decimalDownStr:(NSString *)valueStr{
    return [self yh_decimalWithValueStr:valueStr roundingMode:(NSRoundDown) scale:2];
}
+ (NSString *)yh_2_decimalDownDecimal:(NSDecimal)valueDecimal{
    return [self yh_decimalWithValueDecimal:valueDecimal roundingMode:(NSRoundDown) scale:2];
}


NSString * yh_decimalStringFormate(NSString * passStr){
    
    if ([passStr hasPrefix:@"."]) {
        passStr = [@"0" stringByAppendingString:passStr];
    }
    if ([passStr hasPrefix:@"-."]) {
        passStr = [passStr substringFromIndex:2];
        passStr = [@"-0." stringByAppendingString:passStr];
    }
    if ([passStr hasPrefix:@"+."]) {
        passStr = [passStr substringFromIndex:2];
        passStr = [@"+0." stringByAppendingString:passStr];
    }
    return passStr;
}

+ (NSString *)yh_decimalWithValueStr:(NSString *)valueStr
                        roundingMode:(NSRoundingMode)roundingMode
                               scale:(NSInteger)scale{
    NSDecimalNumber * dealDecimal = [NSDecimalNumber decimalNumberWithString:valueStr];
    NSDecimalNumber * roundDecimal = [dealDecimal yh_decimalNumberHandlerWithRoundingMode:roundingMode scale:scale];
    NSString * str = [roundDecimal yh_formatterFractionMinDigits:scale maxDigits:scale];
    
    str = yh_decimalStringFormate(str);
    
    return str;
}

+ (NSString *)yh_decimalWithValueStr:(NSString *)valueStr
                        roundingMode:(NSRoundingMode)roundingMode
                            maxScale:(NSInteger)maxScale{
    NSDecimalNumber * dealDecimal = [NSDecimalNumber decimalNumberWithString:valueStr];
    NSDecimalNumber * roundDecimal = [dealDecimal yh_decimalNumberHandlerWithRoundingMode:roundingMode scale:maxScale];
    NSString * str = [roundDecimal yh_formatterFractionMinDigits:0 maxDigits:maxScale];
    
    str = yh_decimalStringFormate(str);
    
    return str;
}

+ (NSString *)yh_decimalWithValueDecimal:(NSDecimal)valueDecimal
                            roundingMode:(NSRoundingMode)roundingMode
                                   scale:(NSInteger)scale{
    NSDecimalNumber * dealDecimal = [NSDecimalNumber decimalNumberWithDecimal:valueDecimal];
    NSDecimalNumber * roundDecimal = [dealDecimal yh_decimalNumberHandlerWithRoundingMode:roundingMode scale:scale];
    NSString * str = [roundDecimal yh_formatterFractionMinDigits:scale maxDigits:scale];
    
    str = yh_decimalStringFormate(str);
    
    return str;
}


- (NSString *)yh_formatterFractionMinDigits:(NSUInteger)minDigits maxDigits:(NSUInteger)maxDigits{

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:maxDigits];
    [numberFormatter setMinimumFractionDigits:minDigits];

    return [numberFormatter stringFromNumber:self];
}

@end




@implementation NSNumber (YHDecimal)

@dynamic yh_decimalDown,yh_decimalMax;

- (NSString *)yh_decimalDown_6{
    NSString * str = [NSString stringWithFormat:@"%lf", [self doubleValue]];
    return str.yh_decimalDown_6;
}
- (NSString *)yh_decimalDown_2{
    NSString * str = [NSString stringWithFormat:@"%lf", [self doubleValue]];
    return str.yh_decimalDown_2;
}
- (NSString *)yh_decimalDown_0{
    return self.yh_decimalDown(0);
}
- (NSString *)yh_decimalUp_6{
    NSString * str = [NSString stringWithFormat:@"%lf", [self doubleValue]];
    return [NSDecimalNumber yh_decimalWithValueStr:str roundingMode:NSRoundUp scale:6];
}
- (NSString *)yh_decimalUp_2{
    NSString * str = [NSString stringWithFormat:@"%lf", [self doubleValue]];
    return [NSDecimalNumber yh_decimalWithValueStr:str roundingMode:NSRoundUp scale:2];
}

-(NSString * _Nonnull (^)(NSInteger))yh_decimalDown{
    return ^(NSInteger scale){
        NSString * str = [NSString stringWithFormat:@"%lf", [self doubleValue]];
        return [NSDecimalNumber yh_decimalWithValueStr:str roundingMode:NSRoundDown scale:scale];
    };
}

-(NSString * _Nonnull (^)(NSInteger))yh_decimalMax{
    return ^(NSInteger maxScale){
        NSString * str = [NSString stringWithFormat:@"%lf", [self doubleValue]];
        return [NSDecimalNumber yh_decimalWithValueStr:str roundingMode:NSRoundDown maxScale:maxScale];
    };
}

@end

@implementation NSString (YHDecimal)

- (NSString *)yh_decimalDown_6{
    return [NSDecimalNumber yh_6_decimalDownStr:self];
}
- (NSString *)yh_decimalDown_2{
    return [NSDecimalNumber yh_2_decimalDownStr:self];
}


- (NSString *)yh_thousandsTwoDecimals{
    if([self floatValue] == 0){
        return @"0.00";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###.00;"];
        NSString *value = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
        if ([[value substringToIndex:1] isEqualToString:@"."]) {
            value = [@"0" stringByAppendingString:value];
        }
        return value;
    }
    return @"";
}

- (NSString *)yh_thousandsMoreTwoDecimals{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"#,###.##;"];
    NSString *value = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    if ([[value substringToIndex:1] isEqualToString:@"."]) {
        value = [@"0" stringByAppendingString:value];
    }
    return value;
}

- (NSString *)yh_thousands{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    NSNumber *number = [formatter numberFromString:self];
//    formatter.numberStyle=kCFNumberFormatterDecimalStyle;
    [formatter setPositiveFormat:@"#,###.######;"];
    NSString *string = [formatter stringFromNumber:number];
    if((( [string isKindOfClass:[NSNull class]]||string == nil) || ([string isEqual:[NSNull null]]) ||([string isEqualToString:@""]) || ([string isEqualToString:@""]) )) {
        return self;
    }
    return string;
}

@end
