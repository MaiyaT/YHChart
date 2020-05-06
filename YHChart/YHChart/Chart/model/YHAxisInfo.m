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
    
//    self.axisStep = 5;
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
















/// 坐标轴重新设置 可动态
/**
     坐标轴设计规则
     
     
     坐标轴长度
     s = 数据的最大值 - 数据的最小值
     s 平分10等分
     m10 = s/10
     
     确定坐标轴的最大值和最小值：
     数据的遍历查找最大值min和最小值max
     最高刻度 即坐标轴最大值  往上加 多一等分
     max = max + m10
     最低刻度 即坐标轴最小值  往下减 多一等分 如果最小值不小于0 坐标轴的最小值也不小于0
     min = min - m10
     
     需要设置坐标轴刻度的数 count c
     自动设置坐标轴刻度信息
     刻度值设置规则
     c==0 不显示坐标轴
     c==1 中间位置
     c==2 中上 中下
     ..
     c==4 定位一个刻度显示最小值刻度
     c==5 定位一个刻度显示最大值刻度
     c==6 内部平分刻度
     ...
     ..
     .
     中间向两边展开
     
     刻度值值定位规则
     c==0 不显示坐标轴刻度
     c==1 坐标轴分 n=2 份
     c==2 坐标轴分 n=3 份
     c==3 坐标轴分 n=4 份
     c==4 坐标轴分 n=4 份 定位一个刻度显示最小值刻度
     c==5 坐标轴分 n=4 份 定位一个刻度显示最大值刻度
     c==6 坐标轴分 n=5 份
     c==7 坐标轴分 n=6 份
     ...
     ..
     .
     
     坐标轴分成n等分 每一份 占有对用的数值信息  mn = s/n
     调整mn的数值 使其他为更优的分段信息
     mn>1:
        上取整 去掉小数信息
        mn的整数位数 mn_c
        mn的整数 取整信息 mn_z = mn/10(mn_c-1 次方)
        mn的整数 取余信息 mn_y = mn%10(mn_c-1 次方)
        mn的一段数值信息  mn_1 = mn_z*10(mn_c-1 次方)
        余数在mn_y 在mn_1中的占比 mn_m = mn_y/mn_1
        mn_m 小于 mn_1的0.4 舍弃
        mn_m 大于 mn_1的0.4 mn的二段数值信息  mn_2 = mn_1*0.5
        
        mn刻度调整 mn = mn_1+mn_2
     
     1>mn>0:
        判断小数点位数 mn_c
        最少一位
        最大值和最小值的小数点位数 d_a 和 d_i
        d_i d_a 相等 mn_c = d_i
        不相等 mn_c = MAX(d_i,d_a)
        mn_c = MAX(mn_c,1)
     
        mn_c = mn*mn_c;
        mn_c 重复上面mn>1的操作
     
     mn < 0:
        绝对值 重复上面操作
        
     
     坐标轴刻度
     c==0 不显示坐标轴刻度
     c==1 坐标轴分 n=2 份    mn
     c==2 坐标轴分 n=3 份    mn  mn*2
     c==3 坐标轴分 n=4 份    mn  mn*2  mn*3
     c==4 坐标轴分 n=4 份    min mn  mn*2  mn*3
     c==5 坐标轴分 n=4 份    min mn  mn*2  mn*3 max
     c==6 坐标轴分 n=5 份    min mn  mn*2  mn*3 mn*4 max
     c==7 坐标轴分 n=6 份    min mn  mn*2  mn*3 mn*4 mn*5 max
     
 */
