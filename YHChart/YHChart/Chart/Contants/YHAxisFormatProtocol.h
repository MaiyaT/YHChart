//
//  YHAxisFormatProtocol.h
//  YHChart
//
//  Created by 林宁宁 on 2020/5/6.
//  Copyright © 2020 林宁宁. All rights reserved.
//

@protocol YHAxisFormatProtocol <NSObject>

@required
- (NSAttributedString *)attributeStringFromValue:(CGFloat)value;

@end
