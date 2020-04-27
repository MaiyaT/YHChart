//
//  YHLineChartView+BarGraph.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/22.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLineChartView+BarGraph.h"
#import <NSObject+YYModel.h>

@implementation YHLineChartView (BarGraph)


- (NSArray <YHLineChartItem *>*)getBarList{
    NSMutableArray * list = [NSMutableArray new];
    for(YHLineChartItem * item in self.lineInfoList){
        if(item.showType == YHChartShowType_Bar){
            [list addObject:item];
        }
    }
    return list;
}

- (NSArray <YHLineChartItem *>*)getBarCombineList{
    NSMutableArray * list = [NSMutableArray new];
    for(YHLineChartItem * item in self.lineInfoList){
        if(item.showType == YHChartShowType_BarCombine){
            [list addObject:item];
        }
    }
    return list;
}

- (NSArray <YHLineChartItem *>*)getLineList{
    NSMutableArray * list = [NSMutableArray new];
    for(YHLineChartItem * item in self.lineInfoList){
        if(item.showType == YHChartShowType_Line){
            [list addObject:item];
        }
    }
    return list;
}




/// 同一个刻度下 多条柱状图 展开布局  根据刻度中心点 平分布局
- (void)barCenterOffsetUpdateByContentWidth:(CGFloat)contentMaxWidth
                                   barSpace:(CGFloat)barSpace
                                   barWidth:(CGFloat)barWidth{
    //更新一下 柱状图 宽度 和 偏移信息
    NSArray <YHLineChartItem *>* barList = [self getBarList];
    if(barList.count == 0){
        return;
    }
    
    CGFloat maxWidth = contentMaxWidth;
    CGFloat space = barSpace;
    CGFloat lineWidth = MIN(barWidth, (maxWidth - space*(barList.count-1))/barList.count);
    if(lineWidth < 1){
        lineWidth = 1;
        space = 0;
        lineWidth = MIN(barWidth, (maxWidth - space*(barList.count-1))/barList.count);
    }
    
    CGFloat contentWidth = (lineWidth*barList.count + space*(barList.count-1));
    CGFloat spaceMargin = (maxWidth - contentWidth)*0.5;
    
    CGFloat offsetMax = 0;
    CGFloat offsetMin = 0;
    
    for(NSInteger i = 0; i < barList.count; i++){
        YHLineChartItem * item = barList[i];
        item.lineWidth = lineWidth;
        
        CGFloat offset = -maxWidth*0.5 + spaceMargin + lineWidth * 0.5;
        if(i != 0){
            offset = offset + space*i + lineWidth*i;
        }
        item.barCenterToScaleOffset = offset;
        [self updateLineChart:item];

        if(offset > offsetMax){
            offsetMax = offset;
        }else if (offset < offsetMin){
            offsetMin = offset;
        }
    }
    
    CGFloat width = offsetMax - offsetMin;
    for(NSInteger i = 0; i < barList.count; i++){
        YHLineChartItem * item = barList[i];
        item.barScaleTotalWidth = width;
    }
}


/// 合并的柱状图 偏移值更新
- (void)barCombineValueOffsetUpdate{
    
    NSArray <YHLineChartItem *>* barCombineList = [self getBarCombineList];
    if(barCombineList.count == 0){
        return;
    }
    
    NSMutableArray * points = [NSMutableArray new];
    
    YHLinePointItem *(^GetPointAtList)(YHLinePointItem * pointItem) = ^YHLinePointItem *(YHLinePointItem * pointItem) {
        for(YHLinePointItem * point in points){
            //水平方向
            if(point.valueX == pointItem.valueX){
                return point;
            }
        }
        YHLinePointItem * point = pointItem.yy_modelCopy;
        point.barCombineValueOffset = 0;
        [points addObject:point];
        return point;
    };
    
    CGFloat(^GetOffsetBlock)(YHLinePointItem * pointItem) = ^CGFloat(YHLinePointItem * pointItem) {
        
        YHLinePointItem * prePoint = GetPointAtList(pointItem);
        CGFloat offsetValue = prePoint.barCombineValueOffset;
        
        prePoint.barCombineValueOffset = prePoint.barCombineValueOffset + pointItem.valueY;
        
        return offsetValue;
    };
    
    for(YHLineChartItem * lineItem in barCombineList){
        
        for(YHLinePointItem * pointItem in lineItem.dataList){
            
            CGFloat offset = GetOffsetBlock(pointItem);
            pointItem.barCombineValueOffset = offset;
        }
    }
    
//    barScaleTotalWidth
}


///// 该坐标点位置 所有柱状条合起来的宽度
//- (CGFloat)barSelectBgWidthAtScalePoint:(YHLinePointItem *)point{
//
//    NSArray <YHLineChartItem *>* barCombineList = [self getBarCombineList];
//    if(barCombineList.count == 0){
//        return 0;
//    }
//
//    CGFloat offsetMax = 0;
//    CGFloat offsetMin = 0;
//
//    for(YHLineChartItem * lineItem in barCombineList){
//
//        for(YHLinePointItem * pointItem in lineItem.dataList){
//
//            if(pointItem.valueX == point.valueX){
//                if(pointItem.barCombineValueOffset > offsetMax){
//                    offsetMax = pointItem.barCombineValueOffset;
//                }else if (pointItem.barCombineValueOffset < offsetMin){
//                    offsetMin = pointItem.barCombineValueOffset;
//                }
//            }
//        }
//    }
//
//    CGFloat width = offsetMax - offsetMin;
//
//    return width;
//}

@end
