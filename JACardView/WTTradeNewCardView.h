//
//  WTTradeNewCardView.h
//  IPhone2018
//
//  卡片视图
//
//  Created by Ja on 2018/9/13.
//  Copyright © 2018年 gw. All rights reserved.
//


#import <UIKit/UIKit.h>

@class WTTradeNewCardView;

@protocol WTTradeNewCardViewDelegate <NSObject>

@required
/*
 * 标题设置
 *
 * 标题较特殊，单独返回处理，可返回NSAttributedString类型数组
 */
- (NSArray*)titlesOfCardView;

/*
 * 根据返回的活字典数据设置子标题
 *
 * 如果活字典中的某些字段不需要显示，那么需要在外部处理
 */
- (NSArray<TableHeaderInfo*>*)headerInfoForSubTitlesOfCardView;

@optional
/*
 * 设置标题左侧的headerView
 *
 */
- (UIView*)cardView:(WTTradeNewCardView*)cardView viewForTitleHeaderViewAtIndex:(NSInteger)index;

/*
 * 设置标题右侧的自定义View
 *
 */
- (UIView*)cardView:(WTTradeNewCardView*)cardView viewForRightSettingViewAtIndex:(NSInteger)index;

/*
 * 设置工具栏自定义View
 *
 * 使用此方法时，需使用- (CGFloat)cardView:(WTTradeNewCardView*)cardView heightForToolBarViewWithCardOpened:(BOOL)cardStatus indexPath:(NSInteger)index设置高度
 *
 */
- (UIView*)cardView:(WTTradeNewCardView*)cardView viewForToolBarViewAtIndex:(NSInteger)index;

/*
 * 设置工具栏自定义View的高度
 *
 * @param  cardStatus 当前卡片状态   YES:打开 NO:收起
 *
 */
- (CGFloat)cardView:(WTTradeNewCardView*)cardView heightForToolBarViewWithCardOpened:(BOOL)cardStatus indexPath:(NSInteger)index;

/*
 * 点击cell触发的方法
 *
 */
- (void)cardView:(WTTradeNewCardView*)cardView didSelectRowAtIndex:(NSInteger)index;

/*
 * 修改某一条标题label的相关属性
 *
 * @param titleLab     标题lab
 * @param index        titleLab在cardView中的index
 *
 */
- (void)cardView:(WTTradeNewCardView*)cardView titleLab:(UILabel*)titleLab atIndex:(NSInteger)index;

/*
 * 修改某一条子标题label的相关属性
 *
 * @param subTitleLab  子标题lab
 * @param index        subTitleLab在cardView.headerInfos中的index
 *
 * e.g. 见 cardView:contentLab:atHeaderInfosIndex:
 */
- (void)cardView:(WTTradeNewCardView*)cardView subTitleLab:(UILabel*)subTitleLab atHeaderInfosIndex:(NSInteger)index;

/*
 * 修改某一条子标题内容label的相关属性
 *
 * @param contentLab   子标题内容lab
 * @param index        contentLab在cardView.headerInfos中的index
 *
 
 e.g. 修改 1064字段 - 浮动盈亏 字体颜色
- (void)cardView:(WTTradeNewCardView *)cardView contentLab:(UILabel *)contentLab atHeaderInfosIndex:(NSInteger)index {
 
    TableHeaderInfo *headerInfo = [self.cardView.headerInfos objectAtIndex:index];
    if ([headerInfo.columnFieldTitle isEqualToString:@"浮动盈亏"] && [headerInfo.columnFieldKey isEqualToString:@"1064"]) {
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
 */
- (void)cardView:(WTTradeNewCardView*)cardView contentLab:(UILabel*)contentLab atHeaderInfosIndex:(NSInteger)index;

@end






@interface WTTradeNewCardView : UIView

/*
 * cardView初始化方法
 *
 * responseData   服务端下发的原始数据数组
 */
- (instancetype)initCardViewWithFrame:(CGRect)frame responseData:(NSArray*)responseData;

+ (instancetype)cardViewWithFrame:(CGRect)frame responseData:(NSArray*)responseData;

/*
 * WTTradeNewCardView数据源
 *
 * 服务端下发的原始数据数组
 */
@property (nonatomic,retain) NSMutableArray *responseData;

/*
 * 当前选中行
 *
 * 获取选中的行数的数据: [cardView.responseData objectAtIndex:cardView.selectedIndex]
 */
@property (nonatomic,assign) NSInteger selectedIndex;

/*
 * WTTradeNewCardView子标题活字典数组
 *
 */
@property (nonatomic,retain,readonly) NSArray <TableHeaderInfo*>*headerInfos;

/*
 * WTTradeNewCardView 代理
 *
 */
@property (nonatomic,weak) id<WTTradeNewCardViewDelegate> delegate;

/*
 * 默认显示几行数据
 *
 * 默认2行
 */
@property (nonatomic,assign) NSInteger defaultExhibitionLineCount;

/*
 * 最多显示几行数据
 *
 * 默认显示 返回的活字典数据数量 / 2 行(向上取整)
 */
@property (nonatomic,assign) NSInteger maxExhibitionLineCount;

/*
 * 第二列的子标题与中心点的距离
 *
 * 该值越大，第二列的子标题距离cardView中心点越远
 * 默认20
 */
@property (nonatomic,assign) CGFloat theSecondColumnDistanceFromCenterX;

/*
 * 子标题与子标题内容之间的距离
 *
 * 默认-10
 * 因为使用cardView的界面，大多数为展示界面，子标题后都有中文冒号(：)，若该距离为默认为0则界面上子标题与子标题内容两者距离过远，所以默认为-10
 * 子标题后的中文冒号(：)，需手动添加。请设置subTitleSuffix属性
 * 该值越大，两者距离越宽
 */
@property (nonatomic,assign) CGFloat theDistanceBetweenSubTitleAndSubTitleContent;

/*
 * 卡片之间的间隔
 *
 * 默认15
 */
@property (nonatomic,assign) CGFloat interval;

/*
 * 子标题后缀
 *
 * 默认无后缀
 */
@property (nonatomic,copy) NSString *subTitleSuffix;

/*
 * 修改标题下方横线以上的View的背景颜色
 * 十六进制颜色值
 *
 * 默认白色(#FFFFFF)
 */
@property (nonatomic,copy) NSString *titleViewColorString;

/*
 * 是否显示标题左侧View
 *
 * 默认NO 不显示
 */
@property (nonatomic,assign) BOOL showHeaderView;

/*
 * 是否显示右侧自定义View
 *
 * 默认NO 不显示
 */
@property (nonatomic,assign) BOOL showRightSettingView;

/*
 * 是否显示标题下方横线
 *
 * 默认NO 不显示
 */
@property (nonatomic,assign) BOOL showTitleHorizontalLine;

/*
 * 是否显示滚动进度条
 *
 * 默认YES 显示
 */
@property (nonatomic,assign) BOOL showsVerticalScrollIndicator;

/*
 * 是否可以滚动
 *
 * 默认YES 可滚动
 */
@property (nonatomic,assign) BOOL scrollEnabled;

/*
 * 是否自动去除子标题文本中的转义字符
 *
 * 目前包含的可去除的转义字符: \n , \a , \t , \v , \\ , \" , \'
 * 与 autoFilterTransferredMeaningCharacterInContent 属性相同
 *
 * 默认NO 不去除
 */
@property (nonatomic,assign) BOOL autoFilterTransferredMeaningCharacterInSubTitle;

/*
 * 是否自动去除内容文本中的转义字符
 *
 * 默认NO 不去除
 */
@property (nonatomic,assign) BOOL autoFilterTransferredMeaningCharacterInContent;

/*
 * 上拉加载
 */
- (void)addUpToLoadingWithActionHandler:(void(^)(UITableView *tableView))block;

/*
 * 下拉刷新
 */
- (void)addPullToRefreshWithActionHandler:(void(^)(UITableView *tableView))block refreshType:(RefreshViewType)type;

/*
 * 结束加载/刷新
 */
- (void)endPullToRefreshOrUpToLoading;

/*
 * 移除下拉刷新
 */
- (void)removeCardViewPullToRefreshHeader;

/*
 * 移除上拉加载
 */
- (void)removeCardViewUpToLoadingFooter;

/*
 * 重置某一卡片的显示状态
 *
 * 重置后的状态在界面上显示为未打开
 */
- (void)resetExhibitionCardStatusAtIndex:(NSInteger)index;

/*
 * 重置cardView所有卡片的显示状态
 *
 * 重置后的状态在界面上显示为未打开
 */
- (void)resetAllExhibitionCardsStatus;

/*
 * 刷新cardView
 */
- (void)reloadCardView;

/*
 * 上滑至顶
 */
- (void)scrollCardViewToTopWithAnimation:(BOOL)animated;

@end

