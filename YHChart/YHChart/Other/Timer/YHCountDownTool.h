//
//  YHCountDownTool.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/3/17.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHCountDownTool : NSObject

/// 倒计时
/// @param target 关联的对象 该对象释放也跟着释放  不能为空
/// @param duration 时长 秒
/// @param progressBlock 开始倒计时回调
/// @param finishBlock 完成
+ (void)yh_addCountdownTarget:(id _Nonnull)target
                     duration:(NSInteger)duration
                     progress:(void(^)(NSInteger total, NSInteger remain))progressBlock
                       finish:(void(^ _Nullable)(void))finishBlock;

+ (void)yh_cleanCountdownTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
