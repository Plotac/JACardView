//
//  WTTradeNewCardView.m
//  IPhone2018
//
//  Created by Ja on 2018/9/13.
//  Copyright © 2018年 gw. All rights reserved.
//
//
//                         CardView
//  |--------------------------------------------------|
//  | (headerView)Title                     (rightView)|
//  |(---------------(titleHorizontalLine)------------)|
//  |                                                  |
//  | subTile：subTitleContent  subTile：subTitleContent|
//  | subTile：subTitleContent  subTile：subTitleContent|
//  |                        ...                       |
//  |--------------------------------------------------|
//  |                   (toolbarView)                  |
//  |--------------------------------------------------|
//  |                      (arrow)                     |
//  |__________________________________________________|
//  |                      grayView                    |
//  |__________________________________________________|


#import "WTTradeNewCardView.h"
#import "WTTradeNewCardCell.h"

static NSString *const kWTTradeNewCardViewCell = @"kWTTradeNewCardViewCell";

#define kDefaultExhibitionLineCount      2

@interface WTTradeNewCardView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *btntStatus;

@property (nonatomic,retain) UITableView *tableView;

@property (nonatomic,retain) UIView *noDataView;

@end

@implementation WTTradeNewCardView

#pragma mark - Public
- (instancetype)initCardViewWithFrame:(CGRect)frame responseData:(NSArray*)responseData {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.responseData = [[NSMutableArray alloc]initWithArray:responseData];
        
        self.btntStatus = [[NSMutableArray alloc]init];
        for (NSInteger i=0; i<self.responseData.count; i++) {
            BOOL selected = NO;
            [self.btntStatus addObject:@(selected)];
        }
        
        self.defaultExhibitionLineCount = kDefaultExhibitionLineCount;
        self.maxExhibitionLineCount = 0;
        self.theSecondColumnDistanceFromCenterX = 20;
        self.interval = 15;
        self.showHeaderView = NO;
        self.showRightSettingView = NO;
        self.showTitleHorizontalLine = NO;
        self.showsVerticalScrollIndicator = YES;
        self.scrollEnabled = YES;
        self.autoFilterTransferredMeaningCharacterInSubTitle = NO;
        self.autoFilterTransferredMeaningCharacterInContent = NO;
        self.theDistanceBetweenSubTitleAndSubTitleContent = -10;
        self.subTitleSuffix = @"";
        self.titleViewColorString = @"#FFFFFF";
        
        [self configNoDataView];
        [self initSubViews];
        
    }
    return self;
}

+ (instancetype)cardViewWithFrame:(CGRect)frame responseData:(NSArray*)responseData {
    return [[self alloc]initCardViewWithFrame:frame responseData:responseData];
}

- (void)addUpToLoadingWithActionHandler:(void (^)(UITableView *))block {
    [self removeCardViewUpToLoadingFooter];
    [self.tableView addUpToLoadingWithActionHandler:^{
        if (block) {
            block(_tableView);
        }
    }];
    self.tableView.upToLoadingView.labelTitle.textColor = [UIColor blackColor];
    self.tableView.upToLoadingView.labelSubTitle.textColor = [UIColor blackColor];
    self.tableView.upToLoadingView.busyIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)addPullToRefreshWithActionHandler:(void(^)(UITableView *tableView))block refreshType:(RefreshViewType)type {
    [self removeCardViewPullToRefreshHeader];
    [self.tableView addPullToRefreshWithActionHandler:^{
        if (block) {
            block(_tableView);
        }
    } type:type];
}

- (void)endPullToRefreshOrUpToLoading {
    [self.tableView endLoading];
    [self.tableView endRefresh];
}

- (void)removeCardViewPullToRefreshHeader {
    if (self.tableView.pullToRefreshView) {
        [self.tableView.pullToRefreshView removeFromSuperview];
        self.tableView.pullToRefreshView = nil;
    }
}

- (void)removeCardViewUpToLoadingFooter {
    if (self.tableView.upToLoadingView) {
        [self.tableView.upToLoadingView removeFromSuperview];
        self.tableView.upToLoadingView = nil;
    }
}

- (void)resetExhibitionCardStatusAtIndex:(NSInteger)index {
    [self.btntStatus replaceObjectAtIndex:index withObject:@(NO)];
    NSIndexPath *refreshPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[refreshPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)resetAllExhibitionCardsStatus {

    NSArray *tempStatusArray = [NSArray arrayWithArray:self.btntStatus];
    for (NSInteger i=0; i<tempStatusArray.count; i++) {
        [self.btntStatus replaceObjectAtIndex:i withObject:@(NO)];
    }
    [self.tableView reloadData];
}

- (void)reloadCardView {
    [self.tableView reloadData];
}

- (void)scrollCardViewToTopWithAnimation:(BOOL)animated {
    [self.tableView scrollsToTop];
    [self.tableView setContentOffset:CGPointZero animated:animated];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.responseData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WTTradeNewCardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kWTTradeNewCardViewCell forIndexPath:indexPath];
    
    if (self.maxExhibitionLineCount == 0) {
        self.maxExhibitionLineCount = ceil(self.delegate.headerInfoForSubTitlesOfCardView.count / 2);
    }
    
    [cell.moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.moreBtn.tag = indexPath.row + 100;
    
    BOOL selected = [[self.btntStatus objectAtIndex:indexPath.row] boolValue];
    cell.moreBtn.selected = selected;
    if (selected) {
        cell.visibleExhibitionLineCount = self.maxExhibitionLineCount;
    }else {
        cell.visibleExhibitionLineCount = self.defaultExhibitionLineCount;
    }
    
    cell.title = [self.delegate.titlesOfCardView objectAtIndex:indexPath.row];
    
    NSMutableArray *subTitles = [[[NSMutableArray alloc]init]autorelease];
    NSMutableArray *contents = [[[NSMutableArray alloc]init]autorelease];
    
    NSDictionary *dict = [self.responseData objectAtIndex:indexPath.row];
    
    for (NSInteger i=0; i<self.delegate.headerInfoForSubTitlesOfCardView.count; i++) {
        TableHeaderInfo *info = [self.delegate.headerInfoForSubTitlesOfCardView objectAtIndex:i];
        
        NSString *subTitle = info.columnFieldTitle;
        
        NSString *contentKey = info.columnFieldKey;
        
        NSString *content = @"--";
        id ct = [dict objectForKey:contentKey];
        if (ct) {
            content = [NSString stringWithFormat:@"%@",ct];
        }
 
        [subTitles addObject:subTitle];
        [contents addObject:content];
    }
    
    cell.subTitles = subTitles;
    cell.subContents = contents;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    WTTradeNewCardCell *cardCell = (WTTradeNewCardCell*)cell;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardView:viewForTitleHeaderViewAtIndex:)]) {
        UIView *view = [self.delegate cardView:self viewForTitleHeaderViewAtIndex:indexPath.row];
        [cardCell setHeadViewAndUpdateConstraints:view];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardView:viewForRightSettingViewAtIndex:)]) {
        UIView *view = [self.delegate cardView:self viewForRightSettingViewAtIndex:indexPath.row];
        [cardCell setRightViewAndUpdateConstraints:view];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardView:viewForToolBarViewAtIndex:)]) {
        UIView *view = [self.delegate cardView:self viewForToolBarViewAtIndex:indexPath.row];
        [cardCell setToolBarViewAndUpdateConstraints:view];
    }

    cardCell.showHeaderView = self.showHeaderView;
    cardCell.showRightSettingView = self.showRightSettingView;
    cardCell.showTitleHorizontalLine = self.showTitleHorizontalLine;
    cardCell.autoFilterTransferredMeaningCharacterInSubTitle = self.autoFilterTransferredMeaningCharacterInSubTitle;
    cardCell.theSecondColumnDistanceFromCenterX = self.theSecondColumnDistanceFromCenterX;
    cardCell.interval = self.interval;
    cardCell.theDistanceBetweenSubTitleAndSubTitleContent = self.theDistanceBetweenSubTitleAndSubTitleContent;
    cardCell.subTitleSuffix = self.subTitleSuffix;
    cardCell.titleViewColorString = self.titleViewColorString;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardView:titleLab:atIndex:)]) {
        UILabel *titleLab = cardCell.titleLab;
        [self.delegate cardView:self titleLab:titleLab atIndex:indexPath.row];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardView:subTitleLab:atHeaderInfosIndex:)]) {
        for (NSInteger i=0; i<cardCell.subTitleLabs.count; i++) {
            UILabel *subTitleLab = [cardCell.subTitleLabs objectAtIndex:i];
            [self.delegate cardView:self subTitleLab:subTitleLab atHeaderInfosIndex:i];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardView:contentLab:atHeaderInfosIndex:)]) {
        for (NSInteger i=0; i<cardCell.subContentLabs.count; i++) {
            UILabel *contentLab = [cardCell.subContentLabs objectAtIndex:i];
            [self.delegate cardView:self contentLab:contentLab atHeaderInfosIndex:i];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardView:didSelectRowAtIndex:)]) {
        [self.delegate cardView:self didSelectRowAtIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL status = [[self.btntStatus objectAtIndex:indexPath.row] boolValue];
    
    CGFloat toolBarHeight = 0;
    if ([self.delegate respondsToSelector:@selector(cardView:heightForToolBarViewWithCardOpened:indexPath:)]) {
        toolBarHeight = [self.delegate cardView:self heightForToolBarViewWithCardOpened:status indexPath:indexPath.row] + 20;
    }
    
    if (status) {
        return 15 + 20 + 20 + self.maxExhibitionLineCount *30 + 10 + toolBarHeight + 10 + self.interval;
    }
    return 15 + 20 + 20 + self.defaultExhibitionLineCount *30 + 10 + toolBarHeight + 10 + self.interval;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView loadingScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView loadingScrollViewDidEndDragging:scrollView];
}

#pragma mark - Action
- (void)moreBtnAction:(UIButton*)sender {
    
    NSNumber *selectNum = [self.btntStatus objectAtIndex:sender.tag - 100];
    NSIndexPath *path = [NSIndexPath indexPathForRow:sender.tag - 100 inSection:0];
    
    if ([selectNum isEqualToNumber:@(NO)]) {//关闭状态，即将打开
        [self.btntStatus replaceObjectAtIndex:sender.tag - 100 withObject:@(YES)];
        
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if ([selectNum isEqualToNumber:@(YES)]) {//打开状态，即将关闭
        
        [self.btntStatus replaceObjectAtIndex:sender.tag - 100 withObject:@(NO)];
        
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

#pragma mark - Setter
- (void)setResponseData:(NSMutableArray *)responseData {
    _responseData = nil;
    _responseData = responseData;
    
    if (_responseData.count == 0) {
        _tableView.hidden = YES;
        _noDataView.hidden = NO;
        
        return;
        
    }else {
        _tableView.hidden = NO;
        _noDataView.hidden = YES;
    }
    
    if (self.delegate.headerInfoForSubTitlesOfCardView.count != 0) {
        _maxExhibitionLineCount = ceil(self.delegate.headerInfoForSubTitlesOfCardView.count / 2);
    }
    
    if (!_btntStatus) {
        _btntStatus = [[NSMutableArray alloc]init];
    }
    
    [_btntStatus removeAllObjects];
    for (NSInteger i=0; i<_responseData.count; i++) {
        BOOL selected = NO;
        [_btntStatus addObject:@(selected)];
    }
    
    [_tableView reloadData];
}

- (void)setDefaultExhibitionLineCount:(NSInteger)defaultExhibitionLineCount {
    _defaultExhibitionLineCount = defaultExhibitionLineCount;
    if (_defaultExhibitionLineCount != kDefaultExhibitionLineCount) {
        [_tableView reloadData];
    }
}

- (void)setMaxExhibitionLineCount:(NSInteger)maxExhibitionLineCount {
    _maxExhibitionLineCount = maxExhibitionLineCount;
    if (_maxExhibitionLineCount != _responseData.count / 2) {
        [_tableView reloadData];
    }
}

- (void)setShowHeaderView:(BOOL)showHeaderView {
    _showHeaderView = showHeaderView;
    if (_showHeaderView) {
        [_tableView reloadData];
    }
}

- (void)setShowRightSettingView:(BOOL)showRightSettingView {
    _showRightSettingView = showRightSettingView;
    if (_showRightSettingView) {
        [_tableView reloadData];
    }
}

- (void)setShowTitleHorizontalLine:(BOOL)showTitleHorizontalLine {
    _showTitleHorizontalLine = showTitleHorizontalLine;
    if (_showTitleHorizontalLine) {
        [_tableView reloadData];
    }
}

- (void)setShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator {
    _showsVerticalScrollIndicator = showsVerticalScrollIndicator;
    _tableView.showsVerticalScrollIndicator = _showsVerticalScrollIndicator;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    _tableView.scrollEnabled = _scrollEnabled;
}

- (void)setTheDistanceBetweenSubTitleAndSubTitleContent:(CGFloat)theDistanceBetweenSubTitleAndSubTitleContent {
    _theDistanceBetweenSubTitleAndSubTitleContent = theDistanceBetweenSubTitleAndSubTitleContent;
    if (_theDistanceBetweenSubTitleAndSubTitleContent != -10) {
        [_tableView reloadData];
    }
}

- (void)setInterval:(CGFloat)interval {
    _interval = interval;
    if (_interval != 15) {
        [_tableView reloadData];
    }
}

- (void)setSubTitleSuffix:(NSString *)subTitleSuffix {
    _subTitleSuffix = subTitleSuffix;
    if (_subTitleSuffix && _subTitleSuffix.length > 0) {
        [_tableView reloadData];
    }
}

- (void)setTitleViewColorString:(NSString *)titleViewColorString {
    _titleViewColorString = titleViewColorString;
    if (_titleViewColorString && _titleViewColorString.length > 0) {
        [_tableView reloadData];
    }
}

- (void)setAutoFilterTransferredMeaningCharacterInSubTitle:(BOOL)autoFilterTransferredMeaningCharacterInSubTitle {
    _autoFilterTransferredMeaningCharacterInSubTitle = autoFilterTransferredMeaningCharacterInSubTitle;
    if (!_autoFilterTransferredMeaningCharacterInSubTitle) {
        [_tableView reloadData];
    }
}

- (void)setAutoFilterTransferredMeaningCharacterInContent:(BOOL)autoFilterTransferredMeaningCharacterInContent {
    _autoFilterTransferredMeaningCharacterInContent = autoFilterTransferredMeaningCharacterInContent;
    if (!_autoFilterTransferredMeaningCharacterInContent) {
        [_tableView reloadData];
    }
}

#pragma mark - Getter
- (NSArray*)headerInfos {
    return self.delegate.headerInfoForSubTitlesOfCardView;
}

#pragma mark - Override
/*
 如果cardView响应了：
 cardView:viewForTitleHeaderViewAtIndex:
 cardView:viewForRightSettingViewAtIndex:
 这两个设置标题头部view、右侧view的方法，那么如果设置的是按钮等UIControl类型，点击按钮，会因为第一响应者为按钮而导致selectedIndex不准确，在这里重写hitTest，可以准确获取selectedIndex
 */
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    
    if ([view isKindOfClass:[UIControl class]]) {
        UIControl *control = (UIControl*)view;
        
        UIView *superView = control.superview;
        while (![superView isKindOfClass:[WTTradeNewCardCell class]]) {
            superView = superView.superview;
        }
        
        if ([superView isKindOfClass:[WTTradeNewCardCell class]]) {
            WTTradeNewCardCell *selectedCell = (WTTradeNewCardCell*)superView;
            NSIndexPath *selectedPath = [self.tableView indexPathForCell:selectedCell];
            self.selectedIndex = selectedPath.row;
        }
    }
    
    return view;
}

#pragma mark - Private
/*
 无数据时显示的view
 */
- (void)configNoDataView {
    self.noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, ScreenW, 185)];
    self.noDataView.backgroundColor = [UIColor clearColor];
    self.noDataView.hidden = YES;
    [self addSubview:self.noDataView];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NOF_menu_jjcp_nodata"]];
    imgView.centerX = _noDataView.centerX;
    imgView.originY = 0;
    imgView.bounds = CGRectMake(0, 0, 215, 170);
    [self.noDataView addSubview:imgView];
    
    UILabel *lab = [UILabel new];
    lab.centerX = imgView.centerX;
    lab.originY = CGRectGetMaxY(imgView.frame);
    lab.bounds = CGRectMake(0, 0, ScreenW, 15);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"暂无记录";
    lab.textColor = UIColorFromHexStr(@"#999999");
    lab.font = [UIFont systemFontOfSize:14];
    [self.noDataView addSubview:lab];
    
    [imgView release];
    [lab release];
}

- (void)initSubViews {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = self.showsVerticalScrollIndicator;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[WTTradeNewCardCell class] forCellReuseIdentifier:kWTTradeNewCardViewCell];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
