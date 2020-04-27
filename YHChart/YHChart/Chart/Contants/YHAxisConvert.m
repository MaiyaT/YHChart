//
//  YHAxisConvert.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHAxisConvert.h"

@implementation YHAxisConvert


+ (YHAxisElementInfo *)queryAxis:(YHAxisInfo *)axisInfo
                           dirtX:(YHChartAxisDirection)dirtX
                           dirtY:(YHChartAxisDirection)dirtY
                         isAxisX:(BOOL)isAxisX{
    
    NSAssert((dirtX == YHChartAxisDirection_LeftToRight ||
              dirtX == YHChartAxisDirection_RightToLeft), @"获取的方向有问题");
    
    NSAssert((dirtY == YHChartAxisDirection_TopToBottom ||
              dirtY == YHChartAxisDirection_BottomToTop), @"获取的方向有问题");
    
    YHChartAxisPos position = YHChartAxisPos_Unknow;
    
    if(dirtX == YHChartAxisDirection_LeftToRight){
        if(dirtY == YHChartAxisDirection_TopToBottom){
            if(isAxisX){
                position = YHChartAxisPos_Top;
            }else{
                position = YHChartAxisPos_Left;
            }
        }else{
            if(isAxisX){
                position = YHChartAxisPos_Bottom;
            }else{
                position = YHChartAxisPos_Left;
            }
        }
    }else{
        if(dirtY == YHChartAxisDirection_TopToBottom){
            if(isAxisX){
                position = YHChartAxisPos_Top;
            }else{
                position = YHChartAxisPos_Right;
            }
        }else{
            if(isAxisX){
                position = YHChartAxisPos_Bottom;
            }else{
                position = YHChartAxisPos_Right;
            }
        }
    }
    
    YHAxisElementInfo * axisEle = axisInfo.axisPos(position);

    return axisEle;
}

/// 坐标点X 转 数值
+ (CGFloat)convertPointXToValue:(YHAxisElementInfo *)axisElement
                      axisWidth:(CGFloat)axisWidth
                         pointX:(CGFloat)pointX{

//    YHAxisElementInfo * axisElement = [YHAxisConvert queryAxis:axisInfo dirtX:dirtX dirtY:dirtY isAxisX:YES];
    
    CGFloat planeWidth = axisWidth;
    CGFloat axisXLength = axisElement.valueLength;
    
    CGFloat valueX = 0;
    if(axisElement.isDeuceByScale &&
          axisElement.list.count > 2){
        //不均等计算
        NSInteger sectionIndex = axisElement.list.count-2;
        planeWidth = planeWidth/(axisElement.list.count-1);
        for(NSInteger i = 0; i<axisElement.list.count-1; i++){
            if(planeWidth*(i+1) > pointX){
                sectionIndex = i;
                break;
            }
        }
        
        YHScaleItem * scale1 = axisElement.list[sectionIndex];
        YHScaleItem * scale2 = axisElement.list[sectionIndex+1];

        CGFloat offHeight = pointX - planeWidth*sectionIndex;
        axisXLength = scale1.value - scale2.value;
        CGFloat value1 = axisXLength*(offHeight/planeWidth);
        CGFloat value2 = scale2.value;
        
        valueX = valueX + axisElement.minValue;
        
        if(axisElement.axisDirction == YHChartAxisDirection_RightToLeft){
            valueX = (axisXLength - value1) + value2;
        }else{
            valueX = value1 + value2;
        }
    }else{
        valueX = axisXLength*(pointX/planeWidth);
        
        if(axisElement.axisDirction == YHChartAxisDirection_RightToLeft){
            valueX = axisXLength - valueX;
        }
    }
    
    valueX = valueX + axisElement.minValue;
    
    return valueX;
}


/// 坐标点Y 转 数值
+ (CGFloat)convertPointYToValue:(YHAxisElementInfo *)axisElement
                     axisHeight:(CGFloat)axisHeight
                         pointY:(CGFloat)pointY{
           
//    YHAxisElementInfo * axisElement = [YHAxisConvert queryAxis:axisInfo dirtX:dirtX dirtY:dirtY isAxisX:NO];
    
    CGFloat planeHeight = axisHeight;
    CGFloat axisYLength = axisElement.valueLength;
    CGFloat valueY = 0;
    
    if(axisElement.isDeuceByScale &&
       axisElement.list.count > 2){
        //不均等计算
        NSInteger sectionIndex = axisElement.list.count-2;
        planeHeight = planeHeight/(axisElement.list.count-1);
        for(NSInteger i = 0; i<axisElement.list.count-1; i++){
            if(planeHeight*(i+1) > pointY){
                sectionIndex = i;
                break;
            }
        }
        
        YHScaleItem * scale1 = axisElement.list[sectionIndex];
        YHScaleItem * scale2 = axisElement.list[sectionIndex+1];

        CGFloat offHeight = pointY - planeHeight*sectionIndex;
        axisYLength = scale1.value - scale2.value;
        CGFloat value1 = axisYLength*(offHeight/planeHeight);
        CGFloat value2 = scale2.value;
        
        valueY = valueY + axisElement.minValue;
        
        if(axisElement.axisDirction == YHChartAxisDirection_BottomToTop){
            valueY = (axisYLength - value1) + value2;
        }else{
            valueY = value1 + value2;
        }
    }else{
        valueY = axisYLength*(pointY/planeHeight);
        
        if(axisElement.axisDirction == YHChartAxisDirection_BottomToTop){
            valueY = axisYLength - valueY;
        }
    }

    valueY = valueY + axisElement.minValue;
    
    return valueY;
}



/// 数值 转 坐标点X
+ (CGFloat)convertValueXToPoint:(YHAxisElementInfo *)axisElement
                      axisWidth:(CGFloat)axisWidth
                         valueX:(CGFloat)valueX{
 
//    YHAxisElementInfo * axisElement = [YHAxisConvert queryAxis:axisInfo dirtX:dirtX dirtY:dirtY isAxisX:YES];
        
    CGFloat planeWidth = axisWidth;
    
    CGFloat axisXLength = axisElement.valueLength;
    CGFloat axisXValue = valueX - axisElement.minValue;
    
    CGFloat pointX = 0;
    if(axisElement.isDeuceByScale &&
       axisElement.list.count > 1){
        //不均等计算
        NSArray * sortList = [axisElement.list sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:NO]]];
        
        YHScaleItem * scaleCurrent = sortList.firstObject;
        YHScaleItem * scalePre = sortList.lastObject;
        
        CGFloat distance = FLT_MAX;
        for(YHScaleItem * item in sortList){
            CGFloat off = ABS(valueX - item.value);
            if(off < distance){
                scaleCurrent = item;
                distance = off;
            }
        }
        distance = FLT_MAX;
        for(YHScaleItem * item in sortList){
            CGFloat off = ABS(valueX - item.value);
            if(off < distance &&
               ![item isEqual:scaleCurrent]){
                if(valueX >= scaleCurrent.value && item.value > scaleCurrent.value){
                    scalePre = item;
                    distance = off;
                }
                else if (valueX <= scaleCurrent.value && item.value < scaleCurrent.value){
                    scalePre = item;
                    distance = off;
                }
            }
        }

        YHScaleItem * scale1 = nil;
        YHScaleItem * scale2 = nil;
        if(axisElement.axisDirction == YHChartAxisDirection_LeftToRight){
            //x轴递增
            scale1 = (scaleCurrent.value > scalePre.value)?scalePre:scaleCurrent;
            scale2 = (scaleCurrent.value > scalePre.value)?scaleCurrent:scalePre;
            
            axisXValue = valueX - scale1.value;
        }else{
            //减
            scale1 = (scaleCurrent.value > scalePre.value)?scaleCurrent:scalePre;
            scale2 = (scaleCurrent.value > scalePre.value)?scalePre:scaleCurrent;
            
            axisXValue = valueX - scale2.value;
        }
        
        axisXLength = ABS(scale2.value - scale1.value);
        
        planeWidth = planeWidth/(axisElement.list.count-1);
        NSInteger index = [axisElement.list indexOfObject:scale1];
        
        CGFloat width1 = planeWidth*(axisXValue/axisXLength);
        CGFloat width2 = planeWidth*index;
        
        if(axisElement.axisDirction == YHChartAxisDirection_RightToLeft){
            pointX = (planeWidth - width1) + width2;
        }else{
            pointX = width1 + width2;
        }
        
    }else{
        pointX = planeWidth*(axisXValue/axisXLength);
        if(axisElement.axisDirction == YHChartAxisDirection_RightToLeft){
            pointX = planeWidth - pointX;
        }
    }
    return pointX;
}


/// 数值 转 坐标点Y
+ (CGFloat)convertValueYToPoint:(YHAxisElementInfo *)axisElement
                     axisHeight:(CGFloat)axisHeight
                         valueY:(CGFloat)valueY{
 
//    YHAxisElementInfo * axisElement = [YHAxisConvert queryAxis:axisInfo dirtX:dirtX dirtY:dirtY isAxisX:NO];
        
    CGFloat planeHeight = axisHeight;
    
    CGFloat axisYLength = axisElement.valueLength;
    CGFloat axisYValue = valueY - axisElement.minValue;
    
    CGFloat pointY = 0;
    if(axisElement.isDeuceByScale &&
       (axisElement.list.count > 1)){
        //不均等计算
        NSArray * sortList = [axisElement.list sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:NO]]];
        
        YHScaleItem * scaleCurrent = sortList.firstObject;
        YHScaleItem * scalePre = sortList.lastObject;
        
        CGFloat distance = FLT_MAX;
        for(YHScaleItem * item in sortList){
            CGFloat off = ABS(valueY - item.value);
            if(off < distance){
                scaleCurrent = item;
                distance = off;
            }
        }
        distance = FLT_MAX;
        for(YHScaleItem * item in sortList){
            CGFloat off = ABS(valueY - item.value);
            if(off < distance &&
               ![item isEqual:scaleCurrent]){
                if(valueY >= scaleCurrent.value && item.value > scaleCurrent.value){
                    scalePre = item;
                    distance = off;
                }
                else if (valueY <= scaleCurrent.value && item.value < scaleCurrent.value){
                    scalePre = item;
                    distance = off;
                }
            }
        }

        YHScaleItem * scale1 = nil;
        YHScaleItem * scale2 = nil;
        if(axisElement.axisDirction == YHChartAxisDirection_TopToBottom){
            //y轴递增
            scale1 = (scaleCurrent.value > scalePre.value)?scalePre:scaleCurrent;
            scale2 = (scaleCurrent.value > scalePre.value)?scaleCurrent:scalePre;
            
            axisYValue = valueY - scale1.value;
        }else{
            //减
            scale1 = (scaleCurrent.value > scalePre.value)?scaleCurrent:scalePre;
            scale2 = (scaleCurrent.value > scalePre.value)?scalePre:scaleCurrent;
            
            axisYValue = valueY - scale2.value;
        }
        
        axisYLength = ABS(scale2.value - scale1.value);
        
        planeHeight = planeHeight/(axisElement.list.count-1);
        NSInteger index = [axisElement.list indexOfObject:scale1];
        
        CGFloat height1 = planeHeight*(axisYValue/axisYLength);
        CGFloat height2 = planeHeight*index;
        
        if(axisElement.axisDirction == YHChartAxisDirection_BottomToTop){
            pointY = (planeHeight - height1) + height2;
        }else{
            pointY = height1 + height2;
        }
    }else{
        pointY = planeHeight*(axisYValue/axisYLength);
        if(axisElement.axisDirction == YHChartAxisDirection_BottomToTop){
            pointY = planeHeight - pointY;
        }
    }
    return pointY;
}




/// 坐标点 转 数值坐标
+ (CGPoint)convertPointToValue:(YHAxisElementInfo *)axisElementX
                  axisElementY:(YHAxisElementInfo *)axisElementY
                    axisHeight:(CGFloat)axisHeight
                     axisWidth:(CGFloat)axisWidth
                         point:(CGPoint)point{
    
    
    return CGPointMake(
                       [YHAxisConvert convertPointXToValue:axisElementX axisWidth:axisWidth pointX:point.x],
                       [YHAxisConvert convertPointYToValue:axisElementY axisHeight:axisHeight pointY:point.y]
                       );
}

/// 数值坐标 转 坐标点
+ (CGPoint)convertValueToPoint:(YHAxisElementInfo *)axisElementX
                  axisElementY:(YHAxisElementInfo *)axisElementY
                    axisHeight:(CGFloat)axisHeight
                     axisWidth:(CGFloat)axisWidth
                         value:(CGPoint)value{
    
    return CGPointMake(
                       [YHAxisConvert convertValueXToPoint:axisElementX axisWidth:axisWidth valueX:value.x],
                       [YHAxisConvert convertValueYToPoint:axisElementY axisHeight:axisHeight valueY:value.y]
                       );
}




@end
