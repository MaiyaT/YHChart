//
//  YHDebugMenu.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHDebugMenu.h"
#import "UIFont+YH.h"
#import "UIColor+YHStyle.h"
#import <Masonry.h>
#import "UIButton+Block.h"
#import "YHConstant.h"

@interface YHDebugMenu()

@property (retain, nonatomic) NSMutableArray <UIButton *>* btnList;


@end

@implementation YHDebugMenu

-(void)yh_commonInit{
    
    self.btnList = [NSMutableArray new];
    
}

- (void)addMenu:(NSString *)title action:(void(^)(void))action{
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.titleLabel.font = [UIFont yh_pfOfSize:14];
    addBtn.titleLabel.numberOfLines = 0;
    addBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [addBtn setTitle:title forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor yh_title_h1] forState:UIControlStateNormal];
    addBtn.backgroundColor = [[UIColor yh_blue] colorWithAlphaComponent:0.1];
    [addBtn addActionHandler:^(NSInteger tag) {
        if(action){
            action();
        }
    }];
    [self addSubview:addBtn];
    
    [self.btnList addObject:addBtn];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if(CGRectIsEmpty(self.frame)){
        return;
    }
    
    for(UIButton * btn in self.btnList){
        [btn removeConstraints:btn.constraints];
    }
    
    if(self.btnList.count == 1){
        [self.btnList.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }else if (self.btnList.count > 1){
        [self.btnList mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:Adapted(10) leadSpacing:Adapted(10) tailSpacing:Adapted(10)];
        [self.btnList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
        }];
    }
}

@end
