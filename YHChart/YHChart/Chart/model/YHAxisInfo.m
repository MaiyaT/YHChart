//
//  YHAxisInfo.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/13.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHAxisInfo.h"
#import "UIColor+YHStyle.h"
#import "UIFont+YH.h"


@implementation YHAxisInfo

-(void)yh_commonInit{
    
    self.titleSpaceAxis = 5;
    
    self.axisList = [NSMutableArray new];    
}

-(YHAxisElementInfo * _Nonnull (^)(YHChartAxisPos))axisPos{
    return ^YHAxisElementInfo *(YHChartAxisPos pos){
        for(YHAxisElementInfo * info in self.axisList){
            if(info.axisPosition == pos){
                return info;
            }
        }
        //没找到 创建一个
        YHAxisElementInfo * info = [YHAxisElementInfo new];
        info.axisPosition = pos;
        //初始 默认 一个轴的方向
        if(pos == YHChartAxisPos_Bottom || pos == YHChartAxisPos_Top){
            info.axisDirction = YHChartAxisDirection_LeftToRight;
        }else{
            info.axisDirction = YHChartAxisDirection_BottomToTop;
        }
        [self.axisList addObject:info];
        
        return info;
    };
}

-(YHChartAxisDirection)axisDirectionX{
    
    YHChartAxisDirection dirtX = YHChartAxisDirection_Unknow;
    
    YHAxisElementInfo * axisTop = self.axisPos(YHChartAxisPos_Top);
    YHAxisElementInfo * axisBottom = self.axisPos(YHChartAxisPos_Bottom);
    
    if(axisBottom.valueLength > 0 && !axisBottom.otherAxis){
        dirtX = axisBottom.axisDirction;
    }
    else if(axisTop.valueLength > 0 && !axisTop.otherAxis){
        dirtX = axisTop.axisDirction;
    }
    
    if(axisBottom.valueLength > 0){
        dirtX = axisBottom.axisDirction;
    }
    else if(axisTop.valueLength > 0){
        dirtX = axisTop.axisDirction;
    }
    
    if(dirtX == YHChartAxisDirection_Unknow){
        NSAssert(NO, @"没有设置 X轴坐标信息");
    }
    return dirtX;
}

-(YHChartAxisDirection)axisDirectionXOther{
    
    YHChartAxisDirection dirtX = YHChartAxisDirection_Unknow;
    
    YHAxisElementInfo * axisTop = self.axisPos(YHChartAxisPos_Top);
    YHAxisElementInfo * axisBottom = self.axisPos(YHChartAxisPos_Bottom);
    
    if(axisBottom.valueLength > 0 && axisBottom.otherAxis){
        dirtX = axisBottom.axisDirction;
    }
    else if(axisTop.valueLength > 0 && axisTop.otherAxis){
        dirtX = axisTop.axisDirction;
    }
    
    if(axisBottom.valueLength > 0){
        dirtX = axisBottom.axisDirction;
    }
    else if(axisTop.valueLength > 0){
        dirtX = axisTop.axisDirction;
    }
    
    if(dirtX == YHChartAxisDirection_Unknow){
        NSAssert(NO, @"没有设置 X轴坐标信息");
    }
    return dirtX;
}

-(YHChartAxisDirection)axisDirectionY{
    
    YHChartAxisDirection dirtY = YHChartAxisDirection_Unknow;
    
    YHAxisElementInfo * axisLeft = self.axisPos(YHChartAxisPos_Left);
    YHAxisElementInfo * axisRight = self.axisPos(YHChartAxisPos_Right);
    
    if(axisLeft.valueLength > 0 && !axisLeft.otherAxis){
        dirtY = axisLeft.axisDirction;
    }
    else if(axisRight.valueLength > 0 && !axisRight.otherAxis){
        dirtY = axisRight.axisDirction;
    }
    
    if(axisLeft.valueLength > 0){
        dirtY = axisLeft.axisDirction;
    }
    else if(axisRight.valueLength > 0){
        dirtY = axisRight.axisDirction;
    }
    
    if(dirtY == YHChartAxisDirection_Unknow){
        NSAssert(NO, @"没有设置 Y轴坐标信息");
    }
    return dirtY;
}


-(YHChartAxisDirection)axisDirectionYOther{
    
    YHChartAxisDirection dirtY = YHChartAxisDirection_Unknow;
    
    YHAxisElementInfo * axisLeft = self.axisPos(YHChartAxisPos_Left);
    YHAxisElementInfo * axisRight = self.axisPos(YHChartAxisPos_Right);
    
    if(axisLeft.valueLength > 0 && axisLeft.otherAxis){
        dirtY = axisLeft.axisDirction;
    }
    else if(axisRight.valueLength > 0 && axisRight.otherAxis){
        dirtY = axisRight.axisDirction;
    }
    
    if(axisLeft.valueLength > 0){
        dirtY = axisLeft.axisDirction;
    }
    else if(axisRight.valueLength > 0){
        dirtY = axisRight.axisDirction;
    }
    
    if(dirtY == YHChartAxisDirection_Unknow){
        NSAssert(NO, @"没有设置 Y轴坐标信息");
    }
    return dirtY;
}

-(YHAxisElementInfo *)axisInfoX{
    YHAxisElementInfo * axisTop = self.axisPos(YHChartAxisPos_Top);
    if(axisTop.valueLength > 0 && !axisTop.otherAxis){
        return axisTop;
    }
    
    YHAxisElementInfo * axisBottom = self.axisPos(YHChartAxisPos_Bottom);
    if(axisBottom.valueLength > 0 && !axisBottom.otherAxis){
        return axisBottom;
    }
    
    if(axisTop.valueLength > 0){
        return axisTop;
    }
    
    if(axisBottom.valueLength > 0 ){
        return axisBottom;
    }
    
    NSAssert(NO, @"没有设置 X轴坐标信息");
    
    return nil;
}

-(YHAxisElementInfo *)axisInfoXOther{
    YHAxisElementInfo * axisTop = self.axisPos(YHChartAxisPos_Top);
    if(axisTop.valueLength > 0 && axisTop.otherAxis){
        return axisTop;
    }
    
    YHAxisElementInfo * axisBottom = self.axisPos(YHChartAxisPos_Bottom);
    if(axisBottom.valueLength > 0 && axisBottom.otherAxis){
        return axisBottom;
    }
    
    if(axisTop.valueLength > 0){
        return axisTop;
    }
    
    if(axisBottom.valueLength > 0 ){
        return axisBottom;
    }
    
    NSAssert(NO, @"没有设置 X轴坐标信息");
    
    return nil;
}

-(YHAxisElementInfo *)axisInfoY{
    YHAxisElementInfo * axisLeft = self.axisPos(YHChartAxisPos_Left);
    
    if(axisLeft.valueLength > 0 && !axisLeft.otherAxis){
        return axisLeft;
    }
    
    YHAxisElementInfo * axisRight = self.axisPos(YHChartAxisPos_Right);
    if(axisRight.valueLength > 0 && !axisRight.otherAxis){
        return axisRight;
    }
    
    if(axisLeft.valueLength > 0){
        return axisLeft;
    }
    
    if(axisRight.valueLength > 0){
        return axisRight;
    }
    
    NSAssert(NO, @"没有设置 Y轴坐标信息");
    
    return nil;
}

-(YHAxisElementInfo *)axisInfoYOther{
    YHAxisElementInfo * axisLeft = self.axisPos(YHChartAxisPos_Left);
    
    if(axisLeft.valueLength > 0 && axisLeft.otherAxis){
        return axisLeft;
    }
    
    YHAxisElementInfo * axisRight = self.axisPos(YHChartAxisPos_Right);
    if(axisRight.valueLength > 0 && axisRight.otherAxis){
        return axisRight;
    }
    
    if(axisLeft.valueLength > 0){
        return axisLeft;
    }
    
    if(axisRight.valueLength > 0){
        return axisRight;
    }
    
    NSAssert(NO, @"没有设置 Y轴坐标信息");
    
    return nil;
}

- (void)clean{
    for(YHAxisElementInfo * info in self.axisList){
        if(info.titleView){
            [info.titleView removeFromSuperview];
        }
    }
    [self.axisList removeAllObjects];
}

@end



@interface YHAxisElementInfo()

@property (retain, nonatomic, readwrite) NSArray <YHScaleItem *>* list;

@end

@implementation YHAxisElementInfo

-(void)yh_commonInit{
    
    self.list = [NSArray new];
    
    self.lineColor = [UIColor yh_colorWithHexString:@"E9EBF0"];
    self.lineWidth = 0.5;
    
    self.axisStep = 5;
}

-(BOOL)isAxisX{
    return (self.axisPosition == YHChartAxisPos_Top ||
            self.axisPosition == YHChartAxisPos_Bottom);
}

-(BOOL)isAxisY{
    return (self.axisPosition == YHChartAxisPos_Left ||
            self.axisPosition == YHChartAxisPos_Right);
}

- (CGFloat)valueLength{
    return self.maxValue - self.minValue;
}





/// 新增点 里面做排序操作
- (void)addScale:(YHScaleItem *)point{
    
    NSMutableArray * pointList = [[NSMutableArray alloc] initWithArray:self.list];
    [pointList addObject:point];
    
    [self sortScaleList:pointList];
    
    self.list = pointList;
}

- (void)addScaleList:(NSArray <YHScaleItem *>*)addList{
    
    NSMutableArray * pointList = [[NSMutableArray alloc] initWithArray:self.list];
    [pointList addObjectsFromArray:addList];
    
    [self sortScaleList:pointList];
    
    self.list = pointList;
}

- (void)cleanScale{
    self.list = @[];
}

- (void)sortScaleList:(NSMutableArray *)dataList{
    
    switch (self.axisDirction) {
        case YHChartAxisDirection_LeftToRight:
            //升序
            [dataList sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:YES]]];
            break;
        case YHChartAxisDirection_RightToLeft:
            [dataList sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:NO]]];
            break;
        case YHChartAxisDirection_BottomToTop:
            //降序
            [dataList sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:NO]]];
            break;
        case YHChartAxisDirection_TopToBottom:
            [dataList sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:YES]]];
            break;
        default:
            break;
    }
}



@end
