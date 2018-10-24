//
//  WTTradeNewCardCell.m
//  IPhone2018
//
//  Created by Ja on 2018/9/13.
//  Copyright © 2018年 gw. All rights reserved.
//

#import "WTTradeNewCardCell.h"

@interface WTTradeNewCardCell ()

@property (nonatomic,retain) UIView *titleView;

@property (nonatomic,retain) UIView *headView;

@property (nonatomic,retain) UIView *horizontalLine;

@property (nonatomic,retain) UIView *rightCustomView;

@property (nonatomic,retain) UIView *toolBarView;

@property (nonatomic,retain) UIView *grayView;

@end

@implementation WTTradeNewCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.subTitleLabs = [[NSMutableArray alloc]init];
        self.subContentLabs = [[NSMutableArray alloc]init];
        
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    
    self.titleView = [UIView dzh_viewWithBackgroundColor:[UIColor whiteColor] superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(45);
    }];
    
    self.headView = [UIView dzh_viewWithBackgroundColor:[UIColor clearColor] superViewView:self.titleView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleView).with.offset(15);
        make.top.equalTo(self.titleView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    self.headView.hidden = YES;
    
    self.rightCustomView = [UIView dzh_viewWithBackgroundColor:[UIColor clearColor] superViewView:self.titleView constraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleView).with.offset(-15);
        make.top.equalTo(self.titleView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    self.titleLab = [UILabel dzh_labelWithText:@"" textColor:UIColorFromHexStr(@"#333333") font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft superView:self.titleView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleView).with.offset(15);
        make.right.equalTo(self.rightCustomView.mas_left).with.offset(-10);
        make.top.equalTo(self.titleView).with.offset(15);
        make.height.mas_equalTo(20);
    }];
    
    self.horizontalLine = [UIView dzh_viewWithBackgroundColor:UIColorFromHexStr(@"#ECECEC") superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleView);
        make.top.equalTo(self.titleLab.mas_bottom).with.offset(10);
        make.height.mas_equalTo(0.7);
    }];
    self.horizontalLine.hidden = YES;
    
    self.grayView = [UIView dzh_viewWithBackgroundColor:UIColorFromHexStr(@"#F1F0F1") superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
  
    self.moreBtn = [UIButton dzh_buttonWithImage:@"NOF_menu_cd_arrow_nor" selectImage:@"NOF_menu_cd_arrow_sel" cornerRadius:0 superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.grayView.mas_top).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    self.toolBarView = [UIView dzh_viewWithBackgroundColor:[UIColor clearColor] superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.moreBtn.mas_top).with.offset(-10);
        make.height.mas_equalTo(0);
    }];
}

#pragma mark - Public
- (void)setHeadViewAndUpdateConstraints:(UIView *)inputView {
    
    for (UIView *view in self.headView.subviews) {
        [view removeFromSuperview];
    }
    
    if (!inputView) {
        [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(15);
            make.right.equalTo(self.rightCustomView.mas_left).with.offset(-10);
            make.top.equalTo(self.contentView).with.offset(15);
            make.height.mas_equalTo(20);
        }];
        return;
    }
    
    [self.headView addSubview:inputView];
    [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.top.equalTo(self.contentView).with.offset(15);
        make.size.mas_equalTo(inputView.size);
    }];
    
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_right).with.offset(10);
        make.right.equalTo(self.rightCustomView.mas_left).with.offset(-10);
        make.centerY.equalTo(self.headView);
        make.height.mas_equalTo(20);
    }];
}

- (void)setRightViewAndUpdateConstraints:(UIView*)inputView {
    for (UIView *view in self.rightCustomView.subviews) {
        [view removeFromSuperview];
    }
    
    if (!inputView) {
        return;
    }
    
    [self.rightCustomView addSubview:inputView];
    [self.rightCustomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-15);
        make.centerY.equalTo(self.titleLab);
        make.size.mas_equalTo(inputView.size);
    }];
}

- (void)setToolBarViewAndUpdateConstraints:(UIView *)inputView {
    for (UIView *view in self.toolBarView.subviews) {
        [view removeFromSuperview];
    }
    
    if (!inputView) {
        return;
    }
    
    [self.toolBarView addSubview:inputView];
    [self.toolBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.moreBtn.mas_top).with.offset(-10);
        make.height.mas_equalTo(inputView.sizeHeight);
    }];
}

#pragma mark - Setter
- (void)setTitle:(id)title {
    _title = title;
    if ([title isKindOfClass:[NSAttributedString class]]) {
        self.titleLab.attributedText = _title;
    }else if ([title isKindOfClass:[NSString class]]) {
        self.titleLab.text = _title;
    }
}

- (void)setSubTitles:(NSArray *)subTitles {
    _subTitles = subTitles;

    for (UILabel *lab in self.subTitleLabs) {
        [lab removeFromSuperview];
        lab = nil;
    }
    
    for (UILabel *lab in self.subContentLabs) {
        [lab removeFromSuperview];
        lab = nil;
    }
    
    [self.subTitleLabs removeAllObjects];
    [self.subContentLabs removeAllObjects];
    
    for (NSInteger i=0; i<_subTitles.count; i++) {
        
        if (i >= self.visibleExhibitionLineCount * 2) {
            break;
        }
        
        NSString *subTitle = [_subTitles objectAtIndex:i];
        UIFont *subTitleFont = [UIFont systemFontOfSize:14];
        CGSize subTitleSize = [subTitle sizeWithAttributes:@{
                                                             NSFontAttributeName:subTitleFont
                                                             }];
        UILabel *subTitleLab = [[UILabel new]autorelease];
        subTitleLab.text = subTitle;
        subTitleLab.textColor = UIColorFromHexStr(@"#6478B5");
        subTitleLab.font = subTitleFont;
        
        [self.contentView addSubview:subTitleLab];
        [subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i % 2 == 0) {
                make.left.equalTo(self.contentView).with.offset(15);
            }else {
                make.left.equalTo(self.contentView.mas_centerX).with.offset(20);
            }
            make.top.equalTo(self.titleLab.mas_bottom).with.offset(20 + i / 2 * 30);
            make.size.mas_equalTo(CGSizeMake(subTitleSize.width + 5, 20));
        }];
        
        UILabel *contentLab = [[UILabel new]autorelease];
        contentLab.text = @"";
        contentLab.textColor = UIColorFromHexStr(@"#333333");
        contentLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:contentLab];
        
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(subTitleLab.mas_right).with.offset(self.theDistanceBetweenSubTitleAndSubTitleContent);
            if (i % 2 == 0) {
                make.right.equalTo(self.contentView.mas_centerX).with.offset(- 5);
            }else {
                make.right.equalTo(self.contentView.mas_right).with.offset(- 15);
            }
            make.centerY.equalTo(subTitleLab.mas_centerY);
            make.height.mas_equalTo(20);
        }];
        
        [self.subTitleLabs addObject:subTitleLab];
        [self.subContentLabs addObject:contentLab];
    }
}

- (void)setTheDistanceBetweenSubTitleAndSubTitleContent:(CGFloat)theDistanceBetweenSubTitleAndSubTitleContent {
    _theDistanceBetweenSubTitleAndSubTitleContent = theDistanceBetweenSubTitleAndSubTitleContent;
    for (NSInteger i=0; i<self.subContentLabs.count; i++) {
        UILabel *subTitleLab = [self.subTitleLabs objectAtIndex:i];
        UILabel *subContentLab = [self.subContentLabs objectAtIndex:i];
        [subContentLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(subTitleLab.mas_right).with.offset(_theDistanceBetweenSubTitleAndSubTitleContent);
        }];
    }
}

- (void)setInterval:(CGFloat)interval {
    _interval = interval;
    [self.grayView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(_interval);
    }];
}

- (void)setSubTitleSuffix:(NSString *)subTitleSuffix {
    _subTitleSuffix = subTitleSuffix;
    if (_subTitleSuffix && _subTitleSuffix.length > 0) {
        for (NSInteger i=0; i<self.subTitleLabs.count; i++) {
            UILabel *lab = [self.subTitleLabs objectAtIndex:i];
            lab.text = [NSString stringWithFormat:@"%@%@",lab.text,_subTitleSuffix];
            CGSize subTitleSize = [lab.text sizeWithAttributes:@{
                                                                 NSFontAttributeName:lab.font
                                                                 }];
            [lab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(subTitleSize.width + 5, 20));
            }];
        }
    }
}

- (void)setTitleViewColorString:(NSString *)titleViewColorString {
    _titleViewColorString = titleViewColorString;
    _titleView.backgroundColor = UIColorFromHexStr(_titleViewColorString);
}

- (void)setSubContents:(NSArray *)subContents {
    _subContents = subContents;
    
    for (NSInteger i=0; i<self.subContentLabs.count; i++) {
        UILabel *lab = [self.subContentLabs objectAtIndex:i];
        NSString *content = [_subContents objectAtIndex:i];
        lab.text = content.length > 0 ? content : @"--";
    }
}

- (void)setShowHeaderView:(BOOL)showHeaderView {
    _showHeaderView = showHeaderView;
    self.headView.hidden = !showHeaderView;
}

- (void)setShowRightSettingView:(BOOL)showRightSettingView {
    _showRightSettingView = showRightSettingView;
    self.rightCustomView.hidden = !showRightSettingView;
}

- (void)setShowTitleHorizontalLine:(BOOL)showTitleHorizontalLine {
    _showTitleHorizontalLine = showTitleHorizontalLine;
    self.horizontalLine.hidden = !showTitleHorizontalLine;
}

- (void)setTheSecondColumnDistanceFromCenterX:(CGFloat)theSecondColumnDistanceFromCenterX {
    _theSecondColumnDistanceFromCenterX = theSecondColumnDistanceFromCenterX;
    
    for (NSInteger i=0; i<self.subTitleLabs.count; i++) {
        UILabel *lab = [self.subTitleLabs objectAtIndex:i];
        [lab mas_updateConstraints:^(MASConstraintMaker *make) {
            if (i % 2 == 0) {
                make.left.equalTo(self.contentView).with.offset(15);
            }else {
                make.left.equalTo(self.contentView.mas_centerX).with.offset(theSecondColumnDistanceFromCenterX);
            }
        }];
    }
}

- (void)setAutoFilterTransferredMeaningCharacterInSubTitle:(BOOL)autoFilterTransferredMeaningCharacterInSubTitle {
    _autoFilterTransferredMeaningCharacterInSubTitle = autoFilterTransferredMeaningCharacterInSubTitle;
    if (_autoFilterTransferredMeaningCharacterInSubTitle) {
        self.subTitles = [self filterTransferredMeaningCharacterWithArray:self.subTitles];
        [self setSubContents:_subContents];
    }
}

- (void)setAutoFilterTransferredMeaningCharacterInContent:(BOOL)autoFilterTransferredMeaningCharacterInContent {
    _autoFilterTransferredMeaningCharacterInContent = autoFilterTransferredMeaningCharacterInContent;
    if (_autoFilterTransferredMeaningCharacterInContent) {
        self.subContents = [self filterTransferredMeaningCharacterWithArray:self.subContents];
    }
}

#pragma mark - Private
- (NSMutableArray*)filterTransferredMeaningCharacterWithArray:(NSArray*)strings {
    
    NSArray *characters = @[@"\n",@"\a",@"\t",@"\v",@"\\",@"\"",@"\'"];
    
    NSMutableArray *workedArray = [[NSMutableArray alloc]init];
    for (NSString *verifyStr in strings) {

        for (NSString *character in characters) {
            if ([verifyStr containsString:character]) {
                verifyStr = [verifyStr stringByReplacingOccurrencesOfString:character withString:@""];
            }
        }
        
        [workedArray addObject:verifyStr];
    }
    return workedArray;
}

@end
