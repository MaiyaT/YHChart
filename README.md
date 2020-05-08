YHChart 是使用Objective-C语言编写，目前支持 折线图 柱状图 饼图 三种图表

###  实现方式
> 主要基于原生CAShareLayer 和 UIBezierPath 结合画线

### 坐标轴支持
- 平面上四个顶点为坐标系的坐标轴
- 标题使用AttributeString来控制显示，支持格式化控制
- 坐标轴显示宽度控制
- 坐标轴显示位置控制 显示在轴内部还是外部
- 支持双Y轴
- 坐标轴刻度设置 
  - 通过给定固定刻度值数值设置
  - 通过给定数据的值来自动设置坐标轴信息
- 坐标轴按刻度设置
  - 按数值 根据具体的数值来定位刻度的位置
  - 不按数值 等分 坐标轴  比如指数坐标轴

### 折线图支持
- 平滑控制 曲线还是折线
- 可虚线
- 可阴影
- 左右自动平移动画
- 多条
- 折线点信息
- 选中点视图信息
- 屏幕旋转适配
- 添加删除更新

### 柱状图支持
- 多条水平平分布局
- 多条垂直叠加布局
- 添加删除更新

###  饼图
- 添加删除
- 内圆
- 标注

`示例：`
![折线图-简单](https://upload-images.jianshu.io/upload_images/2019043-44e984c633ef481e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![折线图-平移动画](https://upload-images.jianshu.io/upload_images/2019043-d6fbe64a66206dcf.gif?imageMogr2/auto-orient/strip)

![折线图-添加更新删除](https://upload-images.jianshu.io/upload_images/2019043-659a900f253a65df.gif?imageMogr2/auto-orient/strip)

![折线图-右上坐标轴](https://upload-images.jianshu.io/upload_images/2019043-6c6cf768b52e2e54.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![折线图-对数坐标轴](https://upload-images.jianshu.io/upload_images/2019043-b60b89e53816cbd9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![折线图-双Y轴](https://upload-images.jianshu.io/upload_images/2019043-ffc12e0de39eab42.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![柱状图-简单](https://upload-images.jianshu.io/upload_images/2019043-81f1c39d8bb61d84.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![柱状图-多条水平布局](https://upload-images.jianshu.io/upload_images/2019043-df72b44d55018e15.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![柱状图-多条垂直布局](https://upload-images.jianshu.io/upload_images/2019043-e3bfad82964e9d94.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![柱状图+折线图](https://upload-images.jianshu.io/upload_images/2019043-3b79ce7f5816f00e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![饼图-简单](https://upload-images.jianshu.io/upload_images/2019043-ac4e897ed146a75d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![饼图-有内圆](https://upload-images.jianshu.io/upload_images/2019043-b660f9168b0c00ff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

`代码示例`
- 坐标轴 
```
方式1：
    NSArray * list = @[@"7.59",@"7.5",@"7.4",@"7.3",@"7.2",@"7.1",@"7.0"];
    for(NSString * str in list){
        [scaleList addObject:[YHScaleItem att:YHVTitle(str) value:str.floatValue]];
    }
    [chartView2 updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.maxValue = 7.6;
        axisInfo.minValue = 7;
    }];

方式2：
    NSMutableArray * pointList = [NSMutableArray new];
    for(NSInteger i = 0; i < 11; i++){
        [pointList addObject:[YHLinePointItem valueX:i valueY:(i*4)%11]];
    }
    [chartView updateAxisAutoScaleCount:20
                              pointList:pointList
                                 format:[YHFormatDebug9 new]
                                  width:40
                               position:YHChartAxisPos_Bottom
                               dirction:YHChartAxisDirection_LeftToRight
                                 config:nil];

方式3：
不显示坐标轴
    chartView1.axisInfo.axisPos(YHChartAxisPos_Bottom).maxValue = 50;
    chartView1.axisInfo.axisPos(YHChartAxisPos_Left).maxValue = 50;

方式4：
平分坐标轴刻度 指数轴
[chartView updateAxisScaleList:scaleList width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop) config:^(YHAxisElementInfo * _Nonnull axisInfo) {
        axisInfo.isDeuceByScale = YES; 
        axisInfo.maxValue = 1000;
        axisInfo.minValue = 0.01;
    }];
```

- 参考线
```
四边坐标轴线条：
[chartView addReflineAxisPosition:0xff width:1 color:[UIColor yh_separator] dotted:NO];

坐标轴刻度对应的参考线：
    [chartView addReflineAllAxisPos:YHChartAxisPos_Left config:^(YHReflineInfo * _Nonnull refline) {
        refline.lineColor = [UIColor yh_separator];
        refline.lineHeight = 1;
    }];
    [chartView addReflineAllAxisPos:(YHChartAxisPos_Bottom) config:^(YHReflineInfo * _Nonnull refline) {
        refline.lineColor = [UIColor yh_separator];
        refline.lineHeight = 1;
    }];

自定义位置添加参考线：
    [chartView3 addReflineConfig:^(YHReflineInfo * _Nonnull refline) {
        refline.showHorizontal = YES;
        refline.axisYValue = 30;
    }];

```
- 折线实例
```
    YHLineChartItem * item = [YHLineChartItem new];
    item.coordInfoViewShow = YES; 显示点坐标数据信息
    item.lineColor = [UIColor yh_blue]; 折线颜色
    item.lineShowShadow = YES; 折线阴影
    item.lineShadowColorTop = [[UIColor yh_blue]  colorWithAlphaComponent:0.8]; 渐变开始颜色
    item.lineShadowColorBottom = [[UIColor yh_blue] colorWithAlphaComponent:0.1]; 渐变结束颜色
    item.pointFillColor = [UIColor whiteColor]; 折线点 填充色
    item.pointLineColor = [UIColor yh_blue]; 折线点 描边色
    item.pointLineWidth = 1; 折线点 描边大小
    item.pointRadius = 3; 折线点 圆点大小
    item.pointPicker.showReflineVertical = YES; 折线点 选中显示垂直参考线
    item.pointPicker.showReflineHorizontal = YES; 折线点 选中显示水平参考线
    item.pointPicker.canSelect = YES; 折线点 可选中
    item.pointPicker.radius = 4; 折线点 选中之后点的颜色
    item.pointPicker.fillColor = [UIColor yh_blue];
    item.pointPicker.lineWidth = 0;
  折线点 可选Toast提示视图
    [item.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
        YHPointToastView * toastView = [YHPointToastView new];
        NSString * contentY = [NSString stringWithFormat:@"Y轴: %lf",passPoint.valueY];
        NSString * contentX = [NSString stringWithFormat:@"X轴: %lf",passPoint.valueX];
        NSString * content = [NSString stringWithFormat:@"%@\n%@",contentY,contentX];
        toastView.textTitle.text = content;
        return toastView;
    }];
    
    折线点的数据信息
    for(NSInteger i = 0; i < 11; i++){
        [item addPoint:[YHLinePointItem valueX:i valueY:(i*4)%11]];
    }
    添加到视图中
    [chartView addLineChart:item];
```
- 柱状图实例
```

        YHLineChartItem * item = [YHLineChartItem new];
        item.showType = YHChartShowType_Bar; 水平
        YHChartShowType_BarCombine 垂直
        item.barCenterToScaleOffset = 0; 水平布局的话 相对刻度点布局
        item.lineWidth = Adapted(5); 柱状图的宽度
        item.pointPicker.canSelect = YES;
        item.pointPicker.radius = Adapted(10);
        item.pointPicker.barSelectSingle = YES;可选中
        ...其他设置跟折线图一样
        [chartView addLineChart:item];

```
- 饼图实例
```
饼图视图
    YHPieChartView * chartView = [YHPieChartView new];
    chartView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.05];
    chartView.circleBgFillColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];底色
    chartView.circleTopFillColor = [UIColor whiteColor];
    chartView.circleBorderWidth = 30;内圆底色
    chartView.circleTopCenterAttTitle = [NSMutableAttributedString yh_initWithStr:@"我是中间的\n标题内容" customBlock:^(NSMutableAttributedString *att) {
        [att yh_font:[UIFont yh_pfOfSize:14]];
        [att yh_color:[UIColor yh_title_h3_note]];
        [att yh_color:[UIColor yh_red] range:[att.string rangeOfString:@"标题内容"]];
    }];
    [contentView addSubview:chartView];


饼块信息
        YHPieChartItem * item = [YHPieChartItem new];
        item.value = arc4random()%100 + 1; 数值信息
        item.percent = item.value/200.0; 占的总比例 
如果添加单个要设置percent比例信息 如果是全部平分可不设置
        item.filleColor = [UIColor yh_randomcolor]; 填充色
        item.format = format;
        item.showAnnotation = YES; 显示标注点
        item.showAnnotationInside = YES; 标注点位置
        [chartView addPercentPieBlock:item];
```

```
    YHLineChartView * chartView = [YHLineChartView new];

    坐标轴Y
    NSMutableArray * scaleList = [NSMutableArray new];
    for(NSInteger i = 0; i < 11; i++){
        [scaleList addObject:[YHScaleItem att:YHHTitle(@(i).stringValue) value:i]];
    }
    [chartView updateAxisScaleList:scaleList width:40 position:(YHChartAxisPos_Bottom) dirction:(YHChartAxisDirection_LeftToRight)];

    坐标轴X
    [scaleList removeAllObjects];
    for(NSInteger i = 0; i < 11; i++){
        [scaleList addObject:[YHScaleItem att:YHHTitle(@(i).stringValue) value:i]];
    }
    [chartView updateAxisScaleList:scaleList width:30 position:(YHChartAxisPos_Left) dirction:(YHChartAxisDirection_BottomToTop)];

    参考线
    [chartView addReflineAxisPosition:(YHChartAxisPos_Left) width:2 color:[UIColor yh_separator_dark] dotted:NO];
    [chartView addReflineAxisPosition:(YHChartAxisPos_Bottom) width:2 color:[UIColor yh_separator_dark] dotted:NO];
    [chartView addReflineAxisPosition:(YHChartAxisPos_Right) width:2 color:[UIColor yh_separator_dark] dotted:NO];
    [chartView addReflineAxisPosition:(YHChartAxisPos_Top) width:2 color:[UIColor yh_separator_dark] dotted:NO];
    [chartView addReflineAllAxisPos:YHChartAxisPos_Left config:^(YHReflineInfo * _Nonnull refline) {
        refline.lineColor = [UIColor yh_separator];
        refline.lineHeight = 1;
    }];
    [chartView addReflineAllAxisPos:(YHChartAxisPos_Bottom) config:^(YHReflineInfo * _Nonnull refline) {
        refline.lineColor = [UIColor yh_separator];
        refline.lineHeight = 1;
    }];

    折线图
    YHLineChartItem * item = [YHLineChartItem new];
    item.coordInfoViewShow = YES;
    item.lineColor = [UIColor yh_blue];
    item.lineShowShadow = YES;
    item.lineShadowColorTop = [[UIColor yh_blue] colorWithAlphaComponent:0.8];
    item.lineShadowColorBottom = [[UIColor yh_blue] colorWithAlphaComponent:0.1];
    item.pointFillColor = [UIColor whiteColor];
    item.pointLineColor = [UIColor yh_blue];
    item.pointLineWidth = 1;
    item.pointRadius = 3;
    item.pointPicker.showReflineVertical = YES;
    item.pointPicker.showReflineHorizontal = YES;
    item.pointPicker.canSelect = YES;
    item.pointPicker.radius = 4;
    item.pointPicker.fillColor = [UIColor yh_blue];
    item.pointPicker.lineWidth = 0;
    [item.pointPicker setToastViewBlock:^UIView * _Nonnull(YHLinePointItem * _Nonnull passPoint) {
        YHPointToastView * toastView = [YHPointToastView new];
        NSString * contentY = [NSString stringWithFormat:@"Y轴: %lf",passPoint.valueY];
        NSString * contentX = [NSString stringWithFormat:@"X轴: %lf",passPoint.valueX];
        NSString * content = [NSString stringWithFormat:@"%@\n%@",contentY,contentX];
        toastView.textTitle.text = content;
        return toastView;
    }];
    
    数据
    for(NSInteger i = 0; i < 11; i++){
        [item addPoint:[YHLinePointItem valueX:i valueY:(i*4)%11]];
    }
    
    [chartView addLineChart:item];
    
    [contentView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(Adapted(180));

    }];
```
