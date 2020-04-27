//
//  YHPointPickerConfig.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/14.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseObject.h"
#import "YHLinePointItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHPointPickerConfig : YHBaseObject

@property (assign, nonatomic) BOOL canSelect;

@property (assign, nonatomic) CGFloat radius;
@property (retain, nonatomic) UIColor * fillColor;
@property (retain, nonatomic) UIColor * lineColor;
@property (assign, nonatomic) CGFloat lineWidth;


// 显示参考线  粗细 颜色
@property (assign, nonatomic) BOOL showReflineHorizontal;//显示 选中点的参考线
@property (assign, nonatomic) BOOL showReflineVertical;

@property (assign, nonatomic) CGFloat reflineHWidth;
@property (assign, nonatomic) CGFloat reflineVWidth;

@property (retain, nonatomic) UIColor * reflineHColor;
@property (retain, nonatomic) UIColor * reflineVColor;

@property (assign, nonatomic) BOOL reflineDottedH;
@property (assign, nonatomic) BOOL reflineDottedV;

/// 点击这个点弹出的toast视图  有设置则点击会显示弹窗视图
@property (copy, nonatomic) UIView *(^toastViewBlock)(YHLinePointItem * passPoint);


/// ======== 柱状图下使用
/// 多条 柱状条的时候 该刻度对应的柱状条 是选中 单个还是整块
@property (assign, nonatomic) BOOL barSelectSingle;


@end

NS_ASSUME_NONNULL_END
