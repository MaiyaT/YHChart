//
//  YHLineChartItem.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLineChartItem.h"

@interface YHLineChartItem()

/// 选中点信息
@property (retain, nonatomic, readwrite) YHPointPickerConfig * pointPicker;

@property (retain, nonatomic, readwrite) NSArray <YHLinePointItem *>* dataList;

// 确定布局向量方向
/// 该线条坐标轴 X 方向
@property (assign, nonatomic, readwrite) YHChartAxisDirection axisXDirection;
/// 该线条坐标轴 Y 方向
@property (assign, nonatomic, readwrite) YHChartAxisDirection axisYDirection;
/// 坐标原点位置
@property (assign, nonatomic, readwrite) YHChartOriginCoorPos originCoorPos;


@end

@implementation YHLineChartItem

- (void)yh_commonInit{
    self.lineWidth = 1;
    
    self.dataList = [NSArray new];
}

-(YHPointPickerConfig *)pointPicker{
    if(!_pointPicker){
        _pointPicker = [YHPointPickerConfig new];
    }
    return _pointPicker;
}

-(void)setAxisXDirection:(YHChartAxisDirection)axisXDirection{
    NSAssert((axisXDirection == YHChartAxisDirection_LeftToRight ||
              axisXDirection == YHChartAxisDirection_RightToLeft), @"方向设置有问题 只能水平");
    
    _axisXDirection = axisXDirection;
}

-(void)setAxisYDirection:(YHChartAxisDirection)axisYDirection{
    NSAssert((axisYDirection == YHChartAxisDirection_TopToBottom ||
              axisYDirection == YHChartAxisDirection_BottomToTop), @"方向设置有问题 只能垂直");
    
    _axisYDirection = axisYDirection;
    
}

- (YHChartOriginCoorPos)originCoorPos{
    if(self.axisXDirection == YHChartAxisDirection_LeftToRight &&
       self.axisYDirection == YHChartAxisDirection_BottomToTop){
        return YHChartOriginCoorPos_LeftDown;
    }
    if(self.axisXDirection == YHChartAxisDirection_LeftToRight &&
       self.axisYDirection == YHChartAxisDirection_TopToBottom){
        return YHChartOriginCoorPos_LeftTop;
    }
    if(self.axisXDirection == YHChartAxisDirection_RightToLeft &&
       self.axisYDirection == YHChartAxisDirection_BottomToTop){
        return YHChartOriginCoorPos_RightDown;
    }
    if(self.axisXDirection == YHChartAxisDirection_RightToLeft &&
       self.axisYDirection == YHChartAxisDirection_TopToBottom){
        return YHChartOriginCoorPos_RightTop;
    }
    return YHChartOriginCoorPos_Unknow;
}

-(CGFloat)barCenterToScaleOffset{
    if(self.showType == YHChartShowType_Bar){
        return _barCenterToScaleOffset;
    }
    return 0;
}

- (void)updateLineReferenceAxisXDirection:(YHChartAxisDirection)axisXDirection axisYDirection:(YHChartAxisDirection)axisYDirection{
    
    self.axisXDirection = axisXDirection;
    self.axisYDirection = axisYDirection;
    
    //重新排序
    [self resetPointList:self.dataList];
}


/// 新增点 里面做排序操作
- (void)addPoint:(YHLinePointItem *)point{
    
    NSMutableArray * pointList = [[NSMutableArray alloc] initWithArray:self.dataList];
    [pointList addObject:point];
    
    [self sortPointList:pointList];
    
    self.dataList = pointList;
}

- (void)addPointList:(NSArray <YHLinePointItem *>*)addList{
    
    NSMutableArray * pointList = [[NSMutableArray alloc] initWithArray:self.dataList];
    [pointList addObjectsFromArray:addList];
    
    [self sortPointList:pointList];
    
    self.dataList = pointList;
}

- (void)resetPointList:(NSArray <YHLinePointItem *>*)addList{
    
    self.dataList = @[];
    
    [self addPointList:addList];
}

- (void)sortPointList:(NSMutableArray *)dataList{
    
    if(self.axisType == YHAxisTypeHorizontal){
        if(self.axisXDirection == YHChartAxisDirection_LeftToRight){
            //升序
            [dataList sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"valueX" ascending:YES]]];
        }else{
            [dataList sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"valueX" ascending:NO]]];
        }
    }else{
        if(self.axisYDirection == YHChartAxisDirection_BottomToTop){
            //降序
            [dataList sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"valueY" ascending:NO]]];
        }else{
            [dataList sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"valueY" ascending:YES]]];
        }
    }
}

@end
