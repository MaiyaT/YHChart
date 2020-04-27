//
//  YHLineChartView+ScaleTitleView.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/10.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLineChartView+ScaleTitleView.h"
#import <Masonry.h>

@implementation YHLineChartView (ScaleTitleView)

/// 更新刻度标题
- (void)updateScaleInfoAtPosition:(YHChartAxisPos)position{

    //坐标轴长度
    NSTextAlignment alignment = NSTextAlignmentLeft;
    
    YHAxisElementInfo * axisInfo = self.axisInfo.axisPos(position);
    NSArray * titleList = axisInfo.list;
    if(!axisInfo.titleView){
        axisInfo.titleView = [UIView new];
        [self addSubview:axisInfo.titleView];
    }
    UIView * labContent = axisInfo.titleView;
    
    CGFloat axisLength = axisInfo.valueLength;
    CGFloat minValue = axisInfo.minValue;
    CGFloat maxValue = axisInfo.maxValue;
    CGFloat originValue = minValue; // 坐标原点位置的数值
    BOOL isDeuce = axisInfo.isDeuceByScale;//坐标轴平分
    
//    self.chartView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
    
    switch (position) {
        case YHChartAxisPos_Top:{
            originValue = (axisInfo.axisDirction == YHChartAxisDirection_LeftToRight)?minValue:maxValue;
            alignment = NSTextAlignmentCenter;
            [axisInfo.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.chartView);
                make.right.equalTo(self.chartView);
                if(axisInfo.titleWidth == 0){
                    make.top.equalTo(self.chartView).offset(self.axisInfo.titleSpaceAxis);
                }else{
                    make.bottom.equalTo(self.chartView.mas_top).offset(-self.axisInfo.titleSpaceAxis);
                }
            }];
        }
            break;
        case YHChartAxisPos_Bottom:{
            originValue = (axisInfo.axisDirction == YHChartAxisDirection_LeftToRight)?minValue:maxValue;
            alignment = NSTextAlignmentCenter;
            [axisInfo.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.chartView);
                make.right.equalTo(self.chartView);
                if(axisInfo.titleWidth == 0){
                    make.bottom.equalTo(self.chartView).offset(-self.axisInfo.titleSpaceAxis);
                }else{
                    make.top.equalTo(self.chartView.mas_bottom).offset(self.axisInfo.titleSpaceAxis);
                }
            }];
        }
            break;
        case YHChartAxisPos_Left:{
            originValue = (axisInfo.axisDirction == YHChartAxisDirection_BottomToTop)?maxValue:minValue;
            alignment = NSTextAlignmentRight;
            [axisInfo.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.chartView);
                make.bottom.equalTo(self.chartView);
                if(axisInfo.titleWidth == 0){
                    make.left.equalTo(self.chartView).offset(self.axisInfo.titleSpaceAxis);
                }else{
                    make.right.equalTo(self.chartView.mas_left).offset(-self.axisInfo.titleSpaceAxis);
                }
            }];
        }
            break;
        case YHChartAxisPos_Right:{
            originValue = (axisInfo.axisDirction == YHChartAxisDirection_BottomToTop)?maxValue:minValue;
            alignment = NSTextAlignmentLeft;
            [axisInfo.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.chartView);
                make.bottom.equalTo(self.chartView);
                if(axisInfo.titleWidth == 0){
                    make.right.equalTo(self.chartView).offset(-self.axisInfo.titleSpaceAxis);
                }else{
                    make.left.equalTo(self.chartView.mas_right).offset(self.axisInfo.titleSpaceAxis);
                }
            }];
        }
            break;
        default:
            return;
            break;
    }
    
    if(axisLength == 0){
        NSAssert(NO, @"======》》》 错误❌  没有设置轴的最大值和最小值");
        return;
    }
    
    [labContent.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(YHScaleItem * item in titleList){
        if(item.value > maxValue){
            //超出坐标轴的 刻度不显示
            continue;
        }
        if(item.value < minValue){
            //超出坐标轴的 刻度不显示
            continue;
        }
        
        UILabel * titleLab = [UILabel new];
        titleLab.textAlignment = alignment;
        titleLab.attributedText = item.attString;
        titleLab.numberOfLines = 0;
        [labContent addSubview:titleLab];
        
        
        //该刻度在坐标中的长度
        CGFloat indexLength = ABS(item.value - originValue);
        CGFloat multipliedValue;
        if(isDeuce){
            NSInteger index = [titleList indexOfObject:item];
            if(titleList.count == 1){
                multipliedValue = 0;
            }else{
                multipliedValue = index*1.0/(titleList.count-1);
            }
        }else{
            multipliedValue = indexLength/axisLength;
        }
        
        multipliedValue = multipliedValue * 2;
                
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            if(position == YHChartAxisPos_Top ||
               position == YHChartAxisPos_Bottom){
                make.centerX.equalTo(labContent).multipliedBy(MAX(0.001, multipliedValue));
                if(position == YHChartAxisPos_Bottom){
                    if(axisInfo.titleWidth == 0){
                        make.bottom.equalTo(labContent);
                    }else{
                        make.top.equalTo(labContent);
                    }
                }
                else{
                    if(axisInfo.titleWidth == 0){
                        make.top.equalTo(labContent);
                    }else{
                        make.bottom.equalTo(labContent);
                    }
                }
            }
            else
            {
                make.centerY.equalTo(labContent).multipliedBy(MAX(0.001, multipliedValue));
                if(position == YHChartAxisPos_Left){
                    if(axisInfo.titleWidth == 0){
                        make.left.equalTo(labContent);
                    }else{
                        make.right.equalTo(labContent);
                    }
                }
                else{
                    if(axisInfo.titleWidth == 0){
                        make.right.equalTo(labContent);
                    }else{
                        make.left.equalTo(labContent);
                    }
                }
            }
        }];
    }
}

///// X轴上 自动附加刻度标题
//- (void)autoAddScaleInfoInAxisXByItem:(YHScaleItem *)scale isBottom:(BOOL)isBottom{
//
//    UIView * axisView = isBottom?self.axisInfo.axisBottom.titleView:self.axisInfo.axisTop.titleView;
//    if(!axisView){
//        return;
//    }
//
//    NSMutableArray * axisScaleS = isBottom?self.axisInfo.axisBottom.list:self.axisInfo.axisTop.list;
//    YHScaleItem * lastScale = axisScaleS.lastObject;
//    if(!lastScale){
//        return;
//    }
//
//    if(scale.value < lastScale.value){
//        return;
//    }
//
//    //未超出坐标系
//    if(scale.value < self.axisInfo.maxAxisX){
//        return;
//    }
//
//
//    //新增刻度值 所在的位置
//    CGFloat nextPosX = self.axisInfo.maxAxisX + self.axisInfo.axisStepX;
//    if(lastScale.value > self.axisInfo.maxAxisX){
//        nextPosX = lastScale.value + self.axisInfo.axisStepX;
//    }
//
//    if(scale.value >= nextPosX){
//        //新增 X轴 刻度
//        UILabel * titleLab = [UILabel new];
//        titleLab.textAlignment = NSTextAlignmentCenter;
//        titleLab.attributedText = scale.attString;
//        [axisView addSubview:titleLab];
//
//        //该刻度在坐标中的长度
//        CGFloat indexLength = scale.value - self.axisInfo.minAxisX;
//        CGFloat multipliedValue = indexLength/self.axisInfo.axisLengthX;
//        multipliedValue = multipliedValue * 2;
//
//        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(axisView).multipliedBy(MAX(0.001, multipliedValue));
//            make.bottom.equalTo(axisView);
//        }];
//
//        [axisScaleS addObject:scale];
//    }
//
//    //重新设置该坐标的 宽度
//    CGFloat disTotal = scale.value - self.axisInfo.maxAxisX;
//
//    [self.axisInfo.axisBottom.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.chartView).offset(disTotal);
//    }];
//
//    [UIView animateWithDuration:0 animations:^{
//        self.axisInfo.axisBottom.titleView.transform = CGAffineTransformMakeTranslation(-disTotal, 0);
//    }];
//}


@end
