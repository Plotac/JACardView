//
//  JACard.h
//  JACardViewDemo
//
//  Created by Ja on 2018/10/24.
//  Copyright © 2018年 Ja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JACard : UITableViewCell

@property (nonatomic,strong) id title;

@property (nonatomic,strong) UILabel *titleLab;

@property (nonatomic,strong) NSArray *subTitles;

@property (nonatomic,strong) NSArray *subContents;

@property (nonatomic,assign) CGFloat theDistanceBetweenSubTitleAndSubTitleContent;

@property (nonatomic,assign) CGFloat interval;

@property (nonatomic,copy) NSString *subTitleSuffix;

@property (nonatomic,copy) NSString *titleViewColorString;

@property (nonatomic,copy) NSString *subTitleColorString;

@property (nonatomic,copy) NSString *contentColorString;

@property (nonatomic,assign) NSInteger visibleExhibitionLineCount;

@property (nonatomic,assign) CGFloat theSecondColumnDistanceFromCenterX;

@property (nonatomic,assign) BOOL showTitleHorizontalLine;

@property (nonatomic,assign) BOOL showLeftTitleView;

@property (nonatomic,assign) BOOL showRightSettingView;

@property (nonatomic,assign) BOOL autoFilterTransferredMeaningCharacterInSubTitle;

@property (nonatomic,assign) BOOL autoFilterTransferredMeaningCharacterInContent;

@property (nonatomic,retain) UIButton *moreBtn;

//存放子标题的lab数组
@property (nonatomic,retain) NSMutableArray *subTitleLabs;

//存放子标题内容的lab数组
@property (nonatomic,retain) NSMutableArray *subContentLabs;

- (void)setHeadViewAndUpdateConstraints:(UIView*)inputView;

- (void)setRightViewAndUpdateConstraints:(UIView*)inputView;

- (void)setToolBarViewAndUpdateConstraints:(UIView*)inputView;

@end
