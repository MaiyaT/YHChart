//
//  NSDecimalNumber+YH.h
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDecimalNumber (YH)


/*
typedef NS_ENUM(NSUInteger, NSRoundingMode) {
    NSRoundPlain,   // Round up on a tie(四舍五入)
    NSRoundDown,    // Always down == truncate(只舍不入)
    NSRoundUp,      // Always up(只入不舍)
    NSRoundBankers  // on a tie round so last digit is even(也是四舍五入,这是和NSRoundPlain不一样,如果精确的哪位是5,
它要看精确度的前一位是偶数还是奇数,如果是奇数,则入,偶数则舍,例如scale=1,表示精确到小数点后一位, NSDecimalNumber 为1.25时,
NSRoundPlain结果为1.3,而NSRoundBankers则是1.2),下面是例子:
};
 scale表示精确到小数点后几位,并且NSRoundingMode影响的也是scale位
*/



/// 只舍不入 六位小数
+ (NSString *)yh_6_decimalDownStr:(NSString *)valueStr;
+ (NSString *)yh_6_decimalDownDecimal:(NSDecimal)valueDecimal;
+ (NSString *)yh_2_decimalDownStr:(NSString *)valueStr;
+ (NSString *)yh_2_decimalDownDecimal:(NSDecimal)valueDecimal;

+ (NSString *)yh_decimalWithValueStr:(NSString *)valueStr
                        roundingMode:(NSRoundingMode)roundingMode
                               scale:(NSInteger)scale;
+ (NSString *)yh_decimalWithValueDecimal:(NSDecimal)valueDecimal
                            roundingMode:(NSRoundingMode)roundingMode
                                   scale:(NSInteger)scale;

@end


@interface NSNumber (YHDecimal)

/// 保留几位小数
@property (copy, nonatomic) NSString *(^yh_decimalDown)(NSInteger scale);
/// 最多保留几位小数
@property (copy, nonatomic) NSString *(^yh_decimalMax)(NSInteger maxScale);

- (NSString *)yh_decimalDown_6;
- (NSString *)yh_decimalDown_2;
- (NSString *)yh_decimalDown_0;

- (NSString *)yh_decimalUp_6;
- (NSString *)yh_decimalUp_2;

@end

@interface NSString (YHDecimal)

- (NSString *)yh_decimalDown_6;
- (NSString *)yh_decimalDown_2;

/// 利息收益的千分位显示保留2位小数 如果没有小数会自动补0
- (NSString *)yh_thousandsTwoDecimals;
/// 最多两位小数
- (NSString *)yh_thousandsMoreTwoDecimals;

/// 千分位显示
- (NSString *)yh_thousands;

@end

NS_ASSUME_NONNULL_END
