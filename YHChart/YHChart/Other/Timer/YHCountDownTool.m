//
//  YHCountDownTool.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/3/17.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHCountDownTool.h"
#import "YHConstant.h"

@interface YHCountDownItem : NSObject

@property (weak, nonatomic) id target;
@property (assign, nonatomic) NSInteger duration;
@property (assign, nonatomic) NSInteger remain;
@property (copy, nonatomic) void(^progressBlock)(NSInteger total, NSInteger remain);
@property (copy, nonatomic) void(^finishBlock)(void);

@end

@implementation YHCountDownItem


@end




@interface YHCountDownTool()

@property (retain, nonatomic) NSMutableArray <YHCountDownItem *>* dataList;
@property (retain, nonatomic) NSTimer * timer;

@end


@implementation YHCountDownTool

+ (instancetype)share{
    static YHCountDownTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [YHCountDownTool new];
        tool.dataList = [NSMutableArray new];
    });
    return tool;
}


/// 倒计时
/// @param target 关联的对象 该对象释放也跟着释放
/// @param duration 时长 秒
/// @param progressBlock 开始倒计时回调
/// @param finishBlock 完成
+ (void)yh_addCountdownTarget:(id)target
                     duration:(NSInteger)duration
                     progress:(void(^)(NSInteger total, NSInteger remain))progressBlock
                       finish:(void(^ _Nullable)(void))finishBlock{
    
    [YHCountDownTool yh_cleanCountdownTarget:target];
    
    YHCountDownItem * item = [YHCountDownItem new];
    item.target = target;
    item.duration = duration;
    item.remain = duration;
    item.progressBlock = progressBlock;
    item.finishBlock = finishBlock;
    
    [[YHCountDownTool share] addCountDown:item];
}

+ (void)yh_cleanCountdownTarget:(id)target{
    [[YHCountDownTool share] cleanCountDownByTarget:target];
}

- (void)addCountDown:(YHCountDownItem *)item{
    
    if(item.progressBlock){
        item.progressBlock(item.duration,item.remain);
    }
    [self.dataList addObject:item];
    
    [self restartTimer];
}

- (void)removeCountDown:(YHCountDownItem *)item{
    
    [self.dataList removeObject:item];
    
    [self restartTimer];
}

- (void)cleanCountDownByTarget:(id)target{
    
    [self.dataList enumerateObjectsUsingBlock:^(YHCountDownItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if(obj.target && [obj.target isEqual:target]){
           [self.dataList removeObject:obj];
           *stop = YES;
       }
    }];
    
    [self restartTimer];
}

- (void)restartTimer{
    if(self.dataList.count > 0){
        if(!self.timer){
            [self timerBegin];
        }
    }else{
        [self timerClean];
    }
}

- (void)timerBegin{
    
    [self timerClean];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerClean{
    
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
        
        NSLog(@"倒计时 timer 释放计时器");
    }
}


- (void)timerUpdate{
    
    [self.dataList enumerateObjectsUsingBlock:^(YHCountDownItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if(IsNull(obj.target)){
            [self removeCountDown:obj];
        }
    }];
    
    [self.dataList enumerateObjectsUsingBlock:^(YHCountDownItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        obj.remain = obj.remain - 1;
        
        if(obj.progressBlock){
            obj.progressBlock(obj.duration, obj.remain);
        }
        
        if(obj.remain <= 0){
            if(obj.finishBlock){
                obj.finishBlock();
            }
            [self removeCountDown:obj];
        }
    }];

}





@end
