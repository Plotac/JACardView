//
//  WTTradeNewCardCell.h
//  IPhone2018
//
//  Created by Ja on 2018/9/13.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTTradeNewCardCell : UITableViewCell

@property (nonatomic,retain) id title;

@property (nonatomic,retain) UILabel *titleLab;

@property (nonatomic,retain) NSArray *subTitles;

@property (nonatomic,retain) NSArray *subContents;

@property (nonatomic,assign) CGFloat theDistanceBetweenSubTitleAndSubTitleContent;

@property (nonatomic,assign) CGFloat interval;

@property (nonatomic,copy) NSString *subTitleSuffix;

@property (nonatomic,copy) NSString *titleViewColorString;

@property (nonatomic,assign) NSInteger visibleExhibitionLineCount;

@property (nonatomic,assign) CGFloat theSecondColumnDistanceFromCenterX;

@property (nonatomic,assign) BOOL showTitleHorizontalLine;

@property (nonatomic,assign) BOOL showHeaderView;

@property (nonatomic,assign) BOOL showRightSettingView;

@property (nonatomic,assign) BOOL autoFilterTransferredMeaningCharacterInSubTitle;

@property (nonatomic,assign) BOOL autoFilterTransferredMeaningCharacterInContent;

@property (nonatomic,retain) UIButton *moreBtn;

//存放子标题的数组
@property (nonatomic,retain) NSMutableArray *subTitleLabs;

//存放子标题内容的数组
@property (nonatomic,retain) NSMutableArray *subContentLabs;

- (void)setHeadViewAndUpdateConstraints:(UIView*)inputView;

- (void)setRightViewAndUpdateConstraints:(UIView*)inputView;

- (void)setToolBarViewAndUpdateConstraints:(UIView*)inputView;

@end
