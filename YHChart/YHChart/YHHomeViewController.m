//
//  YHHomeViewController.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/29.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHHomeViewController.h"


@interface YHCellItem : NSObject

@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * subTitle;
/// cell点击
@property (copy, nonatomic) void(^clickBlock)(__kindof YHCellItem * passItem);

@end

@implementation YHCellItem

@end



@interface YHHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UITableView * tableView;

@property (retain, nonatomic) NSMutableArray <YHCellItem *>* dataList;


@end

@implementation YHHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"ChartView";
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
    
    self.dataList = [NSMutableArray new];
    
    __weak typeof(&*self)weakSelf = self;
    
    void(^PushBlock)(NSInteger index, NSString * title) = ^(NSInteger index, NSString * title) {
        NSString * vcname = [NSString stringWithFormat:@"YHChartsDeBugViewController%zd",index];
        UIViewController * vc = [NSClassFromString(vcname) new];
        vc.title = title;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    YHCellItem * item = [YHCellItem new];
    item.title = @"简单折线图";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(1,passItem.title);
    }];
    [self.dataList addObject:item];
    
    
    item = [YHCellItem new];
    item.title = @"折线图平移动画";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(2,passItem.title);
    }];
    [self.dataList addObject:item];
    
    item = [YHCellItem new];
    item.title = @"折线图添加删除";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(3,passItem.title);
    }];
    [self.dataList addObject:item];
    
    item = [YHCellItem new];
    item.title = @"折线图坐标轴-1";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(4,passItem.title);
    }];
    [self.dataList addObject:item];
    
    item = [YHCellItem new];
    item.title = @"折线图特殊坐标轴示例";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(5,passItem.title);
    }];
    [self.dataList addObject:item];
    
    item = [YHCellItem new];
    item.title = @"折线图双Y轴示例";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(6,passItem.title);
    }];
    [self.dataList addObject:item];
    
    item = [YHCellItem new];
    item.title = @"柱状图";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(7,passItem.title);
    }];
    [self.dataList addObject:item];
    
    item = [YHCellItem new];
    item.title = @"柱状图平移动画";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(8,passItem.title);
    }];
    [self.dataList addObject:item];
    
    item = [YHCellItem new];
    item.title = @"折线图坐标轴-2-自动设置坐标轴";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(9,passItem.title);
    }];
    [self.dataList addObject:item];
    
    
    item = [YHCellItem new];
    item.title = @"折线图屏幕旋转适配";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(10,passItem.title);
    }];
    [self.dataList addObject:item];
    
    
    item = [YHCellItem new];
    item.title = @"饼状图";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        PushBlock(11,passItem.title);
    }];
    [self.dataList addObject:item];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifyPage"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"CellIdentifyPage"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd: %@",indexPath.row+1,self.dataList[indexPath.row].title];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YHCellItem * item = self.dataList[indexPath.row];
    
    if(item.clickBlock){
        item.clickBlock(item);
    }
}


@end
