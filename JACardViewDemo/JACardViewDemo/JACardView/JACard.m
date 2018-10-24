//
//  JACard.m
//  JACardViewDemo
//
//  Created by Ja on 2018/10/24.
//  Copyright © 2018年 Ja. All rights reserved.
//

#import "JACard.h"
#import "Masonry.h"
#import "JAUtilities.h"

@interface JACard ()

@property (nonatomic,strong) UIView *titleView;

@property (nonatomic,strong) UIView *headView;

@property (nonatomic,strong) UIView *horizontalLine;

@property (nonatomic,strong) UIView *rightCustomView;

@property (nonatomic,strong) UIView *toolBarView;

@property (nonatomic,strong) UIView *grayView;

@end

@implementation JACard

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

    self.titleView = [[UIView alloc]init];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(45);
    }];
    
    self.headView = [[UIView alloc]init];
    self.headView.backgroundColor = [UIColor clearColor];
    [self.titleView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleView).with.offset(15);
        make.top.equalTo(self.titleView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    self.headView.hidden = YES;
    
    self.rightCustomView = [[UIView alloc]init];
    self.rightCustomView.backgroundColor = [UIColor clearColor];
    [self.titleView addSubview:self.rightCustomView];
    [self.rightCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleView).with.offset(-15);
        make.top.equalTo(self.titleView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"";
    self.titleLab.textColor = UIColorFromHexStr(@"#333333");
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    [self.titleView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleView).with.offset(15);
        make.right.equalTo(self.rightCustomView.mas_left).with.offset(-10);
        make.top.equalTo(self.titleView).with.offset(15);
        make.height.mas_equalTo(20);
    }];
    
    self.horizontalLine = [[UIView alloc]init];
    self.horizontalLine.backgroundColor = UIColorFromHexStr(@"#ECECEC");
    [self.contentView addSubview:self.horizontalLine];
    [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleView);
        make.top.equalTo(self.titleLab.mas_bottom).with.offset(10);
        make.height.mas_equalTo(0.7);
    }];
    self.horizontalLine.hidden = YES;
    
    self.grayView = [[UIView alloc]init];
    self.grayView.backgroundColor = UIColorFromHexStr(@"#F1F0F1");
    [self.contentView addSubview:self.grayView];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setImage:[UIImage imageNamed:@"card_arrow_down"] forState:UIControlStateNormal];
    [self.moreBtn setImage:[UIImage imageNamed:@"card_arrow_up"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.grayView.mas_top).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    self.toolBarView = [[UIView alloc]init];
    self.toolBarView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.toolBarView];
    [self.toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.size.mas_equalTo(inputView.frame.size);
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
        make.size.mas_equalTo(inputView.frame.size);
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
        make.height.mas_equalTo(inputView.frame.size.height);
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
    }
    
    for (UILabel *lab in self.subContentLabs) {
        [lab removeFromSuperview];
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
        UILabel *subTitleLab = [[UILabel alloc]init];
        subTitleLab.text = subTitle;
        subTitleLab.textColor = UIColorFromHexStr(self.subTitleColorString);
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
        
        UILabel *contentLab = [[UILabel alloc]init];
        contentLab.text = @"";
        contentLab.textColor = UIColorFromHexStr(self.contentColorString);
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
            make.left.equalTo(subTitleLab.mas_right).with.offset(theDistanceBetweenSubTitleAndSubTitleContent);
        }];
    }
}

- (void)setInterval:(CGFloat)interval {
    _interval = interval;
    [self.grayView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(interval);
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

- (void)setSubTitleColorString:(NSString *)subTitleColorString {
    _subTitleColorString = subTitleColorString;
    for (UILabel *subTitleLab in self.subTitleLabs) {
        subTitleLab.textColor = UIColorFromHexStr(_subTitleColorString);
    }
}

- (void)setContentColorString:(NSString *)contentColorString {
    _contentColorString = contentColorString;
    for (UILabel *contentLab in self.subContentLabs) {
        contentLab.textColor = UIColorFromHexStr(_contentColorString);
    }
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
    if (self.headView.hidden) {
        [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleView).with.offset(15);
            make.right.equalTo(self.rightCustomView.mas_left).with.offset(-10);
            make.top.equalTo(self.titleView).with.offset(15);
            make.height.mas_equalTo(20);
        }];
    }
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
        
        NSString *workedStr = verifyStr;
        for (NSString *character in characters) {
            if ([verifyStr containsString:character]) {
                workedStr = [verifyStr stringByReplacingOccurrencesOfString:character withString:@""];
            }
        }
        
        [workedArray addObject:workedStr];
    }
    return workedArray;
}

@end
