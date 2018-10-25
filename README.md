# JACardView
### 卡片列表视图

###### 效果图
<div align=center><img src="https://github.com/Plotac/JACardView/blob/master/EffectPicture/卡片列表效果图.gif" alt="卡片列表效果图"/></div>

## 依赖
*  [Masonry](https://github.com/SnapKit/Masonry)

## 文件目录
![(文件目录)](https://github.com/Plotac/JACardView/blob/master/EffectPicture/文件目录.png)

## 使用
1. 在你需要使用JACardView的控制器中
```objc
#import "JACardView.h"
```
2. 初始化
```objc
/*
* cardView初始化方法
*/
- (instancetype)initCardViewWithFrame:(CGRect)frame dataSource:(id<JACardViewDataSource>)dataSource delegate:(id<JACardViewDelegate>)delegate;

+ (instancetype)cardViewWithFrame:(CGRect)frame dataSource:(id<JACardViewDataSource>)dataSource delegate:(id<JACardViewDelegate>)delegate;
```
3. 设置cardsCount
  * 该属性控制了显示出来的卡片的数量
  * 建议在网络请求的成功回调里设置并且在主线程刷新JACardView
```objc
/*
* JACardView卡片数量
*/
@property (nonatomic,assign) NSInteger cardsCount;
```

4. 实现JACardViewDataSource (必须)
```objc
/*
* 标题设置
*
* 可返回NSAttributedString类型数组
*/
- (NSArray*)titlesOfCardView;

/*
* 子标题设置
*/
- (NSArray*)subTitlesOfCardView;

/*
* 内容设置
*
* 数组数量需与子标题数组数量一致。若超出，超出部分不显示；若少于，少于的部分显示为 --
*/
- (NSArray*)contentsOfCardView;
```
5. 根据需求实现JACardViewDelegate (可选)
```objc
/*
* 设置标题左侧的headerView
*
*/
- (UIView*)cardView:(JACardView*)cardView viewForTitleHeaderViewAtIndex:(NSInteger)index;

/*
* 设置标题右侧的自定义View
*
*/
- (UIView*)cardView:(JACardView*)cardView viewForRightSettingViewAtIndex:(NSInteger)index;

/*
* 设置工具栏自定义View
*
* @param  cardStatus 当前卡片状态   YES:打开 NO:收起
*
* 使用此方法时，需使用- (CGFloat)cardView:(JACardView*)cardView heightForToolBarViewWithCardOpened:(BOOL)cardStatus atIndex:(NSInteger)index设置对应高度
*
*/
- (UIView*)cardView:(JACardView*)cardView viewForToolBarViewWithCardOpened:(BOOL)cardStatus atIndex:(NSInteger)index;

/*
* 设置工具栏自定义View的高度
*
* @param  cardStatus 当前卡片状态   YES:打开 NO:收起
*
*/
- (CGFloat)cardView:(JACardView*)cardView heightForToolBarViewWithCardOpened:(BOOL)cardStatus atIndex:(NSInteger)index;

/*
* 点击cell触发的方法
*
*/
- (void)cardView:(JACardView*)cardView didSelectRowAtIndex:(NSInteger)index;

/*
* 修改某一条标题label的相关属性
*
* @param titleLab     标题lab
* @param index        titleLab在cardView中的index
*
*/
- (void)cardView:(JACardView*)cardView titleLab:(UILabel*)titleLab atIndex:(NSInteger)index;

/*
* 修改某一条子标题label的相关属性
*
* @param subTitleLab  子标题lab
* @param index        subTitleLab在cardView.subTitles中的index
*
* e.g. 见 cardView:contentLab:atHeaderInfosIndex:
*/
- (void)cardView:(JACardView*)cardView subTitleLab:(UILabel*)subTitleLab atSubTitlesIndex:(NSInteger)index;

/*
* 修改某一条子标题内容label的相关属性
*
* @param contentLab   子标题内容lab
* @param index        contentLab在cardView.subTitles中的index
*
* e.g. 设置“浮动盈亏”字段的内容颜色

- (void)cardView:(JACardView *)cardView contentLab:(UILabel *)contentLab atSubTitlesIndex:(NSInteger)index {
    NSString *subTitle = [self.cardView.subTitles objectAtIndex:index];
    if ([subTitle isEqualToString:@"浮动盈亏"]) {
        NSString *content = contentLab.text;
        if ([content doubleValue] > 0) {
            contentLab.textColor = UIColorFromHexStr(@"#F33939");
        }else if ([content doubleValue] < 0) {
            contentLab.textColor = UIColorFromHexStr(@"#00B44B");
        }else {
            contentLab.textColor = UIColorFromHexStr(@"#333333");
        }
    }
}

*
*/
- (void)cardView:(JACardView*)cardView contentLab:(UILabel*)contentLab atSubTitlesIndex:(NSInteger)index;
```
## 属性
* 卡片显示数量 
```objc
@property (nonatomic,assign) NSInteger cardsCount;
```
* 当前选中的index
```objc
/*
* 获取选中的行数的数据: [cardView.responseData objectAtIndex:cardView.selectedIndex]
*/
@property (nonatomic,assign) NSInteger cardsCount;
```
* 子标题数组 (只读) 
```objc
@property (nonatomic,strong,readonly) NSArray *subTitles;
```
* 数据源协议、代理协议
```objc
@property (nonatomic,weak) id<JACardViewDataSource> dataSource;
@property (nonatomic,weak) id<JACardViewDelegate> delegate;
```
* Main TableView 
```objc
@property (nonatomic,strong) UITableView *tableView;
```
* 自定义默认显示行数
```objc
/*
*
* 默认2行
*/
@property (nonatomic,assign) NSInteger defaultExhibitionLineCount;
```
* 自定义最多显示行数
```objc
/*
* 
* 默认显示 cardsCount / 2 行(向上取整)
*/
@property (nonatomic,assign) NSInteger maxExhibitionLineCount;
```
* 自定义第二列的子标题与卡片中心点的距离
```objc
/*
*
* 该值越大，第二列的子标题距离cardView中心点越远
* 默认20
*/
@property (nonatomic,assign) CGFloat theSecondColumnDistanceFromCenterX;
```
* 子标题与子标题内容之间的距离
```objc
/*
* 默认-10
* 因为使用cardView的界面，大多数为展示界面，子标题后都有中文冒号(：)，若该距离为默认为0则界面上子标题与子标题内容两者距离过远，所以默认为-10
* 子标题后的中文冒号(：)，需手动添加。请设置subTitleSuffix属性
* 该值越大，两者距离越宽
*/
@property (nonatomic,assign) CGFloat theDistanceBetweenSubTitleAndSubTitleContent;
```
* 卡片之间的间隔
```objc
/*
*
* 默认15
*/
@property (nonatomic,assign) CGFloat interval;
```
* 子标题后缀
```objc
/*
*
* 默认无后缀
*/
@property (nonatomic,copy) NSString *subTitleSuffix;
```
* 修改标题下方横线以上的View的背景颜色
```objc
/*
* 十六进制颜色值
*
* 默认白色(#FFFFFF)
*/
@property (nonatomic,copy) NSString *titleViewColorString;
```
* 修改子标题字体颜色
```objc
/*
* 十六进制颜色值
*
* 默认#6478B5
*/
@property (nonatomic,copy) NSString *subTitleColorString;
```
* 修改内容字体颜色
```objc
/*
* 十六进制颜色值
*
* 默认#333333
*/
@property (nonatomic,copy) NSString *contentColorString;
```
* 是否显示标题左侧View
```objc
/*
*
* 默认NO 不显示
*/
@property (nonatomic,assign) BOOL showHeaderView;
```
* 是否显示右侧自定义View
```objc
/*
*
* 默认NO 不显示
*/
@property (nonatomic,assign) BOOL showRightSettingView;
```
* 是否显示标题下方横线
```objc
/*
*
* 默认NO 不显示
*/
@property (nonatomic,assign) BOOL showTitleHorizontalLine;
```
* 是否显示滚动进度条
```objc
/*
*
* 默认YES 显示
*/
@property (nonatomic,assign) BOOL showsVerticalScrollIndicator;
```
* 是否可以滚动
```objc
/*
*
* 默认YES 可滚动
*/
@property (nonatomic,assign) BOOL scrollEnabled;
```
* 是否自动去除子标题文本中的转义字符
```objc
/*
*
* 目前包含的可去除的转义字符: \n , \a , \t , \v , \\ , \" , \'
* 与 autoFilterTransferredMeaningCharacterInContent 属性相同
*
* 默认NO 不去除
*/
@property (nonatomic,assign) BOOL autoFilterTransferredMeaningCharacterInSubTitle;
```
* 是否自动去除内容文本中的转义字符
```objc
/*
*
* 默认NO 不去除
*/
@property (nonatomic,assign) BOOL autoFilterTransferredMeaningCharacterInContent;
```
