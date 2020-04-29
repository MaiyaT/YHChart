//
//  YHDebugMenu.h
//  YHChart
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHDebugMenu : YHBaseView

- (void)addMenu:(NSString *)title action:(void(^)(void))action;


@end

NS_ASSUME_NONNULL_END
