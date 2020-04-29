//
//  YHDebugBaseViewController.h
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YHLineChartView.h"
#import "YHLineChartView+Refline.h"
#import "YHLineChartView+BarGraph.h"

#import "YHPointToastView.h"

#import "NSMutableAttributedString+YH.h"

#import "YHCountDownTool.h"

#import "YHDebugMenu.h"

#import "YHKit.h"

NS_ASSUME_NONNULL_BEGIN



NSMutableAttributedString * YHVTitle(NSString * title);
NSMutableAttributedString * YHHTitle(NSString * title);

@interface YHDebugBaseViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
