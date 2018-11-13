//
//  ViewController.m
//  JACardViewDemo
//
//  Created by Ja on 2018/10/24.
//  Copyright © 2018年 Ja. All rights reserved.
//

#import "ViewController.h"
#import "JACardView.h"
#import "JAUtilities.h"
#import "Masonry.h"
#import "MJRefresh.h"

@interface ViewController ()<JACardViewDataSource,JACardViewDelegate>

@property (nonatomic,strong) JACardView *cardView;

@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,strong) NSArray *subTitles;
@property (nonatomic,strong) NSArray *contents;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CardViewDemo";
    self.view.backgroundColor = UIColorFromHexStr(@"#F1F0F1");
    
    self.titles = @[@"银华核心价值优选 500123",@"国开货币基金A 320031",@"富国低碳环保混合 512399",@"平安大华财富宝货 000412",@"鹏扬汇利债券B 680032",@"中融现金增利货币 234490",@"易方达消费类型A 312442",@"广发理财30天债券B 100034",@"安信宝利债券(LOF) 287001",@"嘉和磐石混合C 900031",@"中银景福回报混合 0005274"].mutableCopy;
    self.subTitles = @[@"基金帐号",@"基金份额",@"可用份额",@"最新市值",@"基金市值",@"成本价格",@"浮动盈亏",@"交易冻结",@"长期冻结",@"基金状态",@"基金净值",@"基金公司代码",@"客户号",@"基金公司",@"收费类型",@"收费名称"];
    self.contents = @[@"0N1100829511",@"50000000.00",@"3000000.00",@"478143.43",@"3000234.89",@"353.43",@"-1341133124.13",@"1000.00",@"0.00",@"正常开放",@"311431412.00",@"0009431",@"1441314630043",@"阿里基金",@"01",@"前端收费"];
    
    [self initSubViews];
    
    [self addCardViewRefreshHeader];
    [self addCardViewRefreshFooter];
}

#pragma mark - JACardViewDataSource
- (NSArray*)titlesOfCardView {
    NSMutableArray *titles = @[].mutableCopy;
    
    for (NSString *title in self.titles) {
        
        NSMutableAttributedString *attTitle = nil;
        attTitle = [[NSMutableAttributedString alloc] initWithString:title];
        
        NSString *codeStr = [[title componentsSeparatedByString:@" "] lastObject];
        NSRange codeRange = [title rangeOfString:codeStr];
        
        [attTitle addAttributes:@{
                                  NSForegroundColorAttributeName : UIColorFromHexStr(@"#999999"),
                                  NSFontAttributeName : [UIFont systemFontOfSize:13]
                                  }
                          range:codeRange];
        
        [titles addObject:attTitle];
    }
    
    return titles;
}

- (NSArray*)subTitlesOfCardView {
    return self.subTitles;
}

- (NSArray*)contentsOfCardView {
    return self.contents;
}

#pragma mark - JACardViewDelegate
- (UIView*)cardView:(JACardView *)cardView viewForTitleHeaderViewAtIndex:(NSInteger)index {
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 19, 19)];
    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%d",(int)index%6 + 1]];
    return imgView;
}

- (UIView*)cardView:(JACardView *)cardView viewForRightSettingViewAtIndex:(NSInteger)index {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 55, 28);
    button.backgroundColor = UIColorFromHexStr(@"#5893FB");
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 14;
    button.tag = 100 + index;
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    return button;
}

- (UIView*)cardView:(JACardView *)cardView viewForToolBarViewWithCardOpened:(BOOL)opened atIndex:(NSInteger)index {
    UIView *toolView = nil;
    
    if (opened) {
        toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
        
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        topLine.backgroundColor = UIColorFromHexStr(@"#EFEFEF");
        [toolView addSubview:topLine];
        
        for (NSInteger i=0; i<3; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i *toolView.frame.size.width/3, 0, toolView.frame.size.width/3, 45);
            button.tag = 500 + i;
            if (i == 0) {
                [button setTitle:@"Red" forState:UIControlStateNormal];
                [button setTitleColor:UIColorFromHexStr(@"#F33939") forState:UIControlStateNormal];
            }else if (i == 1) {
                [button setTitle:@"Blue" forState:UIControlStateNormal];
                [button setTitleColor:UIColorFromHexStr(@"#5893FB") forState:UIControlStateNormal];
            }else {
                [button setTitle:@"Gray" forState:UIControlStateNormal];
                [button setTitleColor:UIColorFromHexStr(@"#999999") forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(toolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [toolView addSubview:button];
            
            if (i != 0) {
                UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(i*toolView.frame.size.width/3, 0, 1, 45)];
                horizontalLine.backgroundColor = UIColorFromHexStr(@"#EFEFEF");
                [toolView addSubview:horizontalLine];
            }
        }
        
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, toolView.frame.size.height - 1, self.view.frame.size.width, 1)];
        bottomLine.backgroundColor = UIColorFromHexStr(@"#EFEFEF");
        [toolView addSubview:bottomLine];
    }
    
    return toolView;
}

- (CGFloat)cardView:(JACardView *)cardView heightForToolBarViewWithCardOpened:(BOOL)opened atIndex:(NSInteger)index {
    if (opened) {
        return 45;
    }
    return 0;
}

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

#pragma mark - Refresh
- (void)addCardViewRefreshHeader {
    
    BLOCK_WEAK_SELF
    self.cardView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.titles removeAllObjects];
        [weakSelf.titles addObjectsFromArray:@[@"银华核心价值优选 500123",@"国开货币基金A 320031",@"富国低碳环保混合 512399",@"平安大华财富宝货 000412",@"鹏扬汇利债券B 680032",@"中融现金增利货币 234490",@"易方达消费类型A 312442",@"广发理财30天债券B 100034",@"安信宝利债券(LOF) 287001",@"嘉和磐石混合C 900031",@"中银景福回报混合 0005274"]];
        
        weakSelf.cardView.cardsCount = self.titles.count;
        
        //1.5s后刷新cardView
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.cardView reloadCardView];
            [weakSelf.cardView.tableView.mj_header endRefreshing];
        });
        
    }];
}

- (void)addCardViewRefreshFooter {
    
    BLOCK_WEAK_SELF
    self.cardView.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        static int countNum = 1;
        NSMutableArray *refreshObjs = @[].mutableCopy;
        for (NSInteger i=0; i<5; i++) {
            NSString *obj = [NSString stringWithFormat:@"RefreshFooterObj %d",countNum];
            [refreshObjs addObject:obj];
            
            countNum ++;
        }
        
        [weakSelf.titles addObjectsFromArray:refreshObjs];
        weakSelf.cardView.cardsCount = self.titles.count;

        //1.5s后刷新cardView
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.cardView reloadCardView];
            [weakSelf.cardView.tableView.mj_footer endRefreshing];
        });
        
    }];
    
}

#pragma mark - Actions
- (void)segmentAction:(UISegmentedControl*)seg {
    switch (seg.selectedSegmentIndex) {
        case 0:{
            self.cardView.showLeftTitleView = NO;
            self.cardView.showRightSettingView = YES;
        }
            break;
        case 1:{
            self.cardView.showLeftTitleView = YES;
            self.cardView.showRightSettingView = NO;
        }
            break;

        case 2:{
            self.cardView.showLeftTitleView = YES;
            self.cardView.showRightSettingView = YES;
        }
            break;
        default:
            break;
    }
}

- (void)rightBtnAction:(UIButton*)sender {
    NSLog(@"RightButton ClickedIndex : %d",(int)sender.tag - 100);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"RightButton Action" message:[NSString stringWithFormat:@"CardIndex:%d",(int)sender.tag - 100] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)toolBtnAction:(UIButton*)sender {
    
    NSLog(@"ToolButton ClickedIndex : %d",(int)sender.tag - 500);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ToolButton Action" message:[NSString stringWithFormat:@"ButtonIndex:%d",(int)sender.tag - 500] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Private
- (void)initSubViews {
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"不显示leftView",@"不显示rightView",@"重置"]];
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(kStatusBarHeight + kNavToolBarHeight + 15);
        make.right.equalTo(self.view).with.offset(-15);
        make.height.mas_equalTo(30);
    }];
    
    self.cardView = [JACardView cardViewWithFrame:CGRectZero dataSource:self delegate:self];
    self.cardView.backgroundColor = [UIColor clearColor];
    self.cardView.showsVerticalScrollIndicator = NO;
    self.cardView.showLeftTitleView = YES;
    self.cardView.showRightSettingView = YES;
    self.cardView.showTitleHorizontalLine = YES;
    self.cardView.subTitleSuffix = @"：";
    self.cardView.autoFilterTransferredMeaningCharacterInSubTitle = YES;
    [self.view addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segment.mas_bottom).with.offset(15);
        make.left.right.bottom.equalTo(self.view);
    }];
    /*
     cardsCount属性 在开发中，最好在请求完数据之后设置
     */
    self.cardView.cardsCount = self.titles.count;
}

@end
