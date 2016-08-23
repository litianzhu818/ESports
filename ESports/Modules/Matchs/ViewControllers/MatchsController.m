//
//  MatchsController.m
//  ESports
//
//  Created by Peter Lee on 16/6/30.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchsController.h"
#import "LTZLocalizationKit.h"
#import "HttpSessionManager.h"
#import "DropdownMenu.h"
#import "IonIcons.h"
#import "MJRefresh.h"
#import "TMCache.h"
#import "NewsTableViewHeader.h"
#import "ProcessMatchesManager.h"
#import "ResultMatchesManager.h"
#import "ProcessMatchCell.h"
#import "ResultMatchCell.h"
#import "InsertIndexPathModel.h"
#import "RxWebViewController.h"
#import "MatchReplayController.h"
#import "MatchZoneManager.h"
#import "NSObject+Custom.h"

static NSString *const matchesProcessListCacheKey = @"matches_controller_matchs_process_cache_key";
static NSString *const matchesResultListCacheKey = @"matches_controller_mathcs_result_cache_key";

typedef NS_ENUM(NSUInteger, MatchesType) {
    MatchesTypeProcess = 0,
    MatchesTypeResult
};

@interface MatchsController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *topBackgroundView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UITableView *processTableView;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@property (strong, nonatomic) MJRefreshNormalHeader *processTableViewHeader;
@property (strong, nonatomic) MJRefreshAutoNormalFooter *processTableViewFooter;
@property (strong, nonatomic) MJRefreshNormalHeader *resultTableViewHeader;
@property (strong, nonatomic) MJRefreshAutoNormalFooter *resultTableViewFooter;

@property (strong, nonatomic) DropdownMenu *dropdownMenu;
@property (strong, nonatomic) UIButton *button;

@property (assign, nonatomic) MatchesType currentMatchesType;

@property (assign, nonatomic) NSInteger processMatchesOffset;
@property (assign, nonatomic) NSInteger resultMatchesOffset;

@property (assign, nonatomic) NSInteger limitForRequest;

@property (assign, nonatomic) NSInteger resultMatchesFirstRequest;

@property (strong, nonatomic) ProcessMatchesManager *processMatchesManager;
@property (strong, nonatomic) ResultMatchesManager *resultMatchesManager;

@end

@implementation MatchsController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.rdv_tabBarController setTabBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadViews];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MatchZoneValueDidChangedKey object:nil];
}

- (void)loadViews
{
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"title":@"Matches",
                                           @"matchs_type_process":@"Event process",
                                           @"matchs_type_result":@"The latest results",
                                           @"local_item_global":@"Global",
                                           @"local_item_lck":@"LCK",
                                           @"local_item_eulcs":@"EULCS",
                                           @"local_item_lpl":@"LPL",
                                           @"local_item_nalcs":@"NALCS",
                                           @"local_item_lms":@"LMS",
                                           @"local_bar_item":@"area",
                                           @"tableview_header_pull_down_title":@"Pull down to refresh",
                                           @"tableview_header_release_title":@"Release to refresh",
                                           @"tableview_header_loading_title":@"Loading...",
                                           @"tableview_footer_normal_title":@"Clicking to get more data",
                                           @"tableview_footer_loading_title":@"Loading more...",
                                           @"tableview_footer_no_data_title":@"There is no more data"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"title":@"赛事",
                                           @"matchs_type_process":@"赛事进程",
                                           @"matchs_type_result":@"最新赛果",
                                           @"local_item_global":@"全球",
                                           @"local_item_lck":@"LCK",
                                           @"local_item_eulcs":@"EULCS",
                                           @"local_item_lpl":@"LPL",
                                           @"local_item_nalcs":@"NALCS",
                                           @"local_item_lms":@"LMS",
                                           @"local_bar_item":@"地区",
                                           @"tableview_header_pull_down_title":@"下拉刷新",
                                           @"tableview_header_release_title":@"松开刷新",
                                           @"tableview_header_loading_title":@"获取数据中...",
                                           @"tableview_footer_normal_title":@"点击加载更多数据",
                                           @"tableview_footer_loading_title":@"正在加载数据...",
                                           @"tableview_footer_no_data_title":@"没有更多数据了"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"title":@"賽事",
                                           @"matchs_type_process":@"賽事進程",
                                           @"matchs_type_result":@"最新賽果",
                                           @"local_item_global":@"全球",
                                           @"local_item_lck":@"LCK",
                                           @"local_item_eulcs":@"EULCS",
                                           @"local_item_lpl":@"LPL",
                                           @"local_item_nalcs":@"NALCS",
                                           @"local_item_lms":@"LMS",
                                           @"local_bar_item":@"地區",
                                           @"tableview_header_pull_down_title":@"下拉刷新",
                                           @"tableview_header_release_title":@"鬆開刷新",
                                           @"tableview_header_loading_title":@"獲取數據中...",
                                           @"tableview_footer_normal_title":@"點擊加載更多數據",
                                           @"tableview_footer_loading_title":@"正在加載數據...",
                                           @"tableview_footer_no_data_title":@"沒有更多數據了"

                                           }
                                   };
    self.title = LTZLocalizedString(@"title", nil);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(matchZoneDidChanged:) name:MatchZoneValueDidChangedKey object:nil];
    
    WEAK_SELF;
    self.dropdownMenu = [[DropdownMenu alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]))
                                                      Items:@[[[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_global", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lck", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_eulcs", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lpl", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_nalcs", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lms", nil)]
                                                              ]
                                               currentIndex:[self currentIndexWithMatchZoneId:[[MatchZoneManager sharedInstance] matchZoneId]]
                                              selectedBlock:^(NSInteger index) {
                                                  STRONG_SELF;
                                                  [[MatchZoneManager sharedInstance] setMatchZoneId:[strongSelf currentMatchZoneIdWithIndex:index]];
                                              }];
    [self.view addSubview:self.dropdownMenu];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateNormal];
    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateHighlighted];
    
    [IonIcons label:self.button.titleLabel setIcon:icon_chevron_down size:17.0f color:[UIColor whiteColor] sizeToFit:NO];
    [self.button setImage:[IonIcons imageWithIcon:icon_chevron_down size:15.0f color:[[UIColor whiteColor] colorWithAlphaComponent:0.7]] forState:UIControlStateNormal];
    [self.button setImage:[IonIcons imageWithIcon:icon_chevron_down size:15.0f color:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    
    // Set the title and icon position
    [self.button sizeToFit];
    
    self.button.titleEdgeInsets = UIEdgeInsetsMake(0, -self.button.imageView.frame.size.width-10, 0, self.button.imageView.frame.size.width);
    self.button.imageEdgeInsets = UIEdgeInsetsMake(0, self.button.titleLabel.frame.size.width-5, 0, -self.button.titleLabel.frame.size.width);
    
    // Set color to white
    [self.button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.button];
    
    // 顶部背景颜色
    self.topBackgroundView.backgroundColor = HexColor(0x16212f);
    
    // UISegmentedControl修改
    [self.segmentedControl setTintColor:HexColor(0x213954)];
    
    NSDictionary *normalAttributes = @{
                                       NSForegroundColorAttributeName:HexColor(0x6ed4ff),
                                       NSFontAttributeName:[UIFont systemFontOfSize:16.0f]
                                       };
    NSDictionary *selectedAttributes = @{
                                         NSForegroundColorAttributeName:[UIColor whiteColor],
                                         NSFontAttributeName:[UIFont systemFontOfSize:16.0f]
                                         };
    [self.segmentedControl setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    
    [self.segmentedControl setTitle:LTZLocalizedString(@"matchs_type_process", nil) forSegmentAtIndex:0];
    [self.segmentedControl setTitle:LTZLocalizedString(@"matchs_type_result", nil) forSegmentAtIndex:1];
    
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    
    self.processTableView.backgroundColor = self.view.backgroundColor;
    self.resultTableView.backgroundColor = self.view.backgroundColor;
    
    // 为UITableView添加上下拉
    // 添加下拉刷新
    self.processTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadProcessData)];
    // 隐藏时间
    self.processTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
    [self.processTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.processTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.processTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    self.processTableView.mj_header = self.processTableViewHeader;
    
    
    // 添加上拉加载更多数据
    self.processTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreProcessData)];
    self.processTableViewFooter.refreshingTitleHidden = YES;
    [self.processTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.processTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.processTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    self.processTableView.mj_footer = self.processTableViewFooter;
    
    // 添加下拉刷新
    self.resultTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadResultData)];
    // 隐藏时间
    self.resultTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
    [self.resultTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.resultTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.resultTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    self.resultTableView.mj_header = self.resultTableViewHeader;
    
    
    // 添加上拉加载更多数据
    self.resultTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreResultData)];
    self.resultTableViewFooter.refreshingTitleHidden = YES;
    [self.resultTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.resultTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.resultTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    self.resultTableView.mj_footer = self.resultTableViewFooter;
    

    [self.processTableView registerNib:[NewsTableViewHeader nib]
     forHeaderFooterViewReuseIdentifier:[NewsTableViewHeader headerReuseIdentifier]];
    
    [self.resultTableView registerNib:[NewsTableViewHeader nib]
     forHeaderFooterViewReuseIdentifier:[NewsTableViewHeader headerReuseIdentifier]];
    
    [self.processTableView registerNib:[ProcessMatchCell nib] forCellReuseIdentifier:[ProcessMatchCell cellIdentifier]];
    [self.resultTableView registerNib:[ResultMatchCell nib] forCellReuseIdentifier:[ResultMatchCell cellIdentifier]];
}

- (void)loadData
{
    self.currentMatchesType = MatchesTypeProcess;
    self.limitForRequest = 20;
    self.processMatchesOffset = 0;
    self.resultMatchesOffset = 0;
    self.resultMatchesFirstRequest = YES;

    self.processMatchesManager = [[ProcessMatchesManager alloc] init];
    self.resultMatchesManager = [[ResultMatchesManager alloc] init];
    
    // 取缓存中的轮换图片
    __weak typeof(self) weakSelf = self;
    
    [[TMCache sharedCache] objectForKey:matchesProcessListCacheKey
                                  block:^(TMCache *cache, NSString *key, NSArray<ProcessMatch *> *cacheProcessMatches) {
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      [cacheProcessMatches enumerateObjectsUsingBlock:^(ProcessMatch * _Nonnull processMatch, NSUInteger idx, BOOL * _Nonnull stop) {
                                          [strongSelf.processMatchesManager addProcessMatch:processMatch];
                                      }];
                        
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [strongSelf.processTableView reloadData];
                                      });
                                  }];
    
    [[TMCache sharedCache] objectForKey:matchesResultListCacheKey
                                  block:^(TMCache *cache, NSString *key, NSArray<ResultMatch *> *cacheResultMatches) {
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      [cacheResultMatches enumerateObjectsUsingBlock:^(ResultMatch * _Nonnull resultMatch, NSUInteger idx, BOOL * _Nonnull stop) {
                                          [strongSelf.resultMatchesManager addResultMatch:resultMatch];
                                      }];
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [strongSelf.resultTableView reloadData];
                                      });
                                  }];
    
    // 开始网络请求数据
    [self.processTableView.mj_header beginRefreshing];

}

- (void)showMenu
{
    if (!self.dropdownMenu.isShowing) {
        [self.dropdownMenu showMenu];
    }else{
        [self.dropdownMenu hideMenu];
    }
}

- (void)setCurrentMatchesType:(MatchesType)currentMatchesType
{
    _currentMatchesType = currentMatchesType;
    
    switch (_currentMatchesType) {
        case MatchesTypeProcess:
        {
            self.processTableView.hidden = NO;
            self.resultTableView.hidden = YES;
        }
            break;
        case MatchesTypeResult:
        {
            self.processTableView.hidden = YES;
            self.resultTableView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 切换语言响应方法
- (void)languageDidChanged
{
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    self.dropdownMenu.items = @[[[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_global", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lck", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_eulcs", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lpl", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_nalcs", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lms", nil)]
                                ];
    [self.dropdownMenu reloadItems];
    
    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateNormal];
    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateHighlighted];
    
    [self.segmentedControl setTitle:LTZLocalizedString(@"matchs_type_process", nil) forSegmentAtIndex:0];
    [self.segmentedControl setTitle:LTZLocalizedString(@"matchs_type_result", nil) forSegmentAtIndex:1];
    
    [self.processTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.processTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.processTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    
    [self.processTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.processTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.processTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    
    [self.resultTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.resultTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.resultTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    
    [self.resultTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.resultTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.resultTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    

    [self.processTableView.mj_header beginRefreshing];
    [self.resultTableView.mj_header beginRefreshing];
}

#pragma mark - 切换赛区
- (void)matchZoneDidChanged:(NSNotification *)notification
{
    [self.dropdownMenu setSelectedIndex:[self currentIndexWithMatchZoneId:notification.object]];
    [self.processTableView.mj_header beginRefreshing];
    [self.resultTableView.mj_header beginRefreshing];
}

#pragma mark - UISegmentedControl响应事件
-(void)segmentAction:(UISegmentedControl *)SegmentedControl
{
    NSInteger index = SegmentedControl.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            if (self.currentMatchesType != MatchesTypeProcess) {
                self.currentMatchesType = MatchesTypeProcess;
            }
        }
            break;
        case 1:
        {
            if (self.currentMatchesType != MatchesTypeResult) {
                self.currentMatchesType = MatchesTypeResult;
                if (self.resultMatchesFirstRequest) {
                    // 请求转会新闻数据
                    self.resultMatchesFirstRequest = NO;
                    [self.resultTableView.mj_header beginRefreshing];
                }
            }
        }
            break;
        
        default:
            break;
    }
}

- (void)reloadProcessData
{
    self.processMatchesOffset = 0;
    [self.processTableView.mj_footer resetNoMoreData];
    __weak typeof(self) weakSelf = self;
    
    [[HttpSessionManager sharedInstance] requestMatchProcessWithOffset:self.processMatchesOffset
                                                         numbersOfPage:self.limitForRequest
                                                                 block:^(NSArray<NSDictionary *> *processMatches, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (processMatches.count > 0) {
                                                                             
                                                                             [strongSelf.processMatchesManager removeAllObjects];
                                                                             
                                                                             NSMutableArray<ProcessMatch *> *cacheProcessMatches = [NSMutableArray array];
                                                                             
                                                                             [processMatches enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 ProcessMatch *processMatch = [[ProcessMatch alloc] initWithDictionary:dic error:nil];
                                                                                 if (processMatch) {
                                                                                     [strongSelf.processMatchesManager addProcessMatch:processMatch];
                                                                                     [cacheProcessMatches addObject:processMatch];
                                                                                 }
                                                                             }];
                                                                             
                                                                             
                                                                             strongSelf.processMatchesOffset += processMatches.count;
                                                                             
                                                                             if (processMatches.count < strongSelf.limitForRequest) {
                                                                                 [strongSelf.processTableView.mj_footer endRefreshingWithNoMoreData];
                                                                             }
                                                                             
                                                                             [strongSelf.processTableView reloadData];
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheProcessMatches
                                                                                                       forKey:matchesProcessListCacheKey
                                                                                                        block:NULL];
                                                                             
                                                                         }
                                                                     }
                                                                     
                                                                     [strongSelf.processTableView.mj_header endRefreshing];
                                                                 }];
    
}

- (void)loadMoreProcessData
{
    __weak typeof(self) weakSelf = self;
    
    [[HttpSessionManager sharedInstance] requestMatchProcessWithOffset:self.processMatchesOffset
                                                         numbersOfPage:self.limitForRequest
                                                                 block:^(NSArray<NSDictionary *> *processMatches, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     BOOL hasMoreData = YES;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (processMatches.count > 0) {
                                                                             NSMutableArray<ProcessMatch *> *cacheProcessMatches = [NSMutableArray array];
                                                                             InsertIndexPathModel *insertIndexPathModel = [[InsertIndexPathModel alloc] initWithLastSectionIndex:strongSelf.processMatchesManager.processMatchesContainers.count-1];
                                                                             
                                                                             [processMatches enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 ProcessMatch *processMatch = [[ProcessMatch alloc] initWithDictionary:dic error:nil];
                                                                                 if (processMatch) {
                                                                                     
                                                                                     NSIndexPath *indexPath = [strongSelf.processMatchesManager addProcessMatch:processMatch];
                                                                                     [insertIndexPathModel addIndexPath:indexPath];
                                                                                     [cacheProcessMatches addObject:processMatch];
                                                                                     
                                                                                 }
                                                                             }];
                                                                             
                                                                             [strongSelf.processTableView beginUpdates];
                                                                             
                                                                             [strongSelf.processTableView insertRowsAtIndexPaths:insertIndexPathModel.indexPaths
                                                                                                                withRowAnimation:UITableViewRowAnimationNone];
                                                                             [strongSelf.processTableView insertSections:insertIndexPathModel.sectionsSet
                                                                                                        withRowAnimation:UITableViewRowAnimationNone];
                                                                             
                                                                             [strongSelf.processTableView endUpdates];
                                                                             
                                                                             strongSelf.processMatchesOffset += processMatches.count;
                                                                             if (processMatches.count < strongSelf.limitForRequest) {
                                                                                 [strongSelf.processTableView.mj_footer endRefreshingWithNoMoreData];
                                                                                 hasMoreData = NO;
                                                                             }
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheProcessMatches
                                                                                                       forKey:matchesProcessListCacheKey
                                                                                                        block:NULL];
                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                     if (hasMoreData) {
                                                                         [strongSelf.processTableView.mj_header endRefreshing];
                                                                     }
                                                                     
                                                                 }];
}

- (void)reloadResultData
{
    self.resultMatchesOffset = 0;
    __weak typeof(self) weakSelf = self;
    [self.resultTableView.mj_footer resetNoMoreData];
    [[HttpSessionManager sharedInstance] requestMatchResultWithOffset:self.resultMatchesOffset
                                                        numbersOfPage:self.limitForRequest
                                                                block:^(NSArray<NSDictionary *> *resultMatches, NSError *error) {
                                                                    
                                                                    __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                    
                                                                    if (!error) {
                                                                        if (resultMatches.count > 0) {
                                                                            
                                                                            [strongSelf.resultMatchesManager removeAllObjects];
                                                                            
                                                                            NSMutableArray<ResultMatch *> *cacheResultMatches = [NSMutableArray array];
                                                                            
                                                                            [resultMatches enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                ResultMatch *resultMatch = [[ResultMatch alloc] initWithDictionary:dic error:nil];
                                                                                if (resultMatch) {
                                                                                    [strongSelf.resultMatchesManager addResultMatch:resultMatch];
                                                                                    [cacheResultMatches addObject:resultMatch];
                                                                                }
                                                                            }];
                                                                            
                                                                            
                                                                            strongSelf.resultMatchesOffset += resultMatches.count;
                                                                            
                                                                            if (resultMatches.count < strongSelf.limitForRequest) {
                                                                                [strongSelf.resultTableView.mj_footer endRefreshingWithNoMoreData];
                                                                            }
                                                                            
                                                                            [strongSelf.resultTableView reloadData];
                                                                            
                                                                            [[TMCache sharedCache] setObject:cacheResultMatches
                                                                                                      forKey:matchesResultListCacheKey
                                                                                                       block:NULL];
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                    [strongSelf.resultTableView.mj_header endRefreshing];
                                                                }];
}

- (void)loadMoreResultData
{
    __weak typeof(self) weakSelf = self;
    
    [[HttpSessionManager sharedInstance] requestMatchResultWithOffset:self.resultMatchesOffset
                                                        numbersOfPage:self.limitForRequest
                                                                block:^(NSArray<NSDictionary *> *resultMatches, NSError *error) {
                                                                    __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                    
                                                                    BOOL hasMoreData = YES;
                                                                    
                                                                    if (!error) {
                                                                        
                                                                        if (resultMatches.count > 0) {
                                                                            NSMutableArray<ResultMatch *> *cacheResultMatches = [NSMutableArray array];
                                                                            InsertIndexPathModel *insertIndexPathModel = [[InsertIndexPathModel alloc] initWithLastSectionIndex:strongSelf.resultMatchesManager.resultMatchesContainers.count-1];
                                                                            
                                                                            [resultMatches enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                ResultMatch *resultMatche = [[ResultMatch alloc] initWithDictionary:dic error:nil];
                                                                                
                                                                                if (resultMatche) {
                                                                                    
                                                                                    NSIndexPath *indexPath = [strongSelf.resultMatchesManager addResultMatch:resultMatche];
                                                                                    [insertIndexPathModel addIndexPath:indexPath];
                                                                                    [cacheResultMatches addObject:resultMatche];
                                                                                    
                                                                                }
                                                                            }];
                                                                            
                                                                            [strongSelf.resultTableView beginUpdates];
                                                                            
                                                                            [strongSelf.resultTableView insertRowsAtIndexPaths:insertIndexPathModel.indexPaths
                                                                                                               withRowAnimation:UITableViewRowAnimationNone];
                                                                            [strongSelf.resultTableView insertSections:insertIndexPathModel.sectionsSet
                                                                                                       withRowAnimation:UITableViewRowAnimationNone];
                                                                            
                                                                            [strongSelf.resultTableView endUpdates];
                                                                            
                                                                            strongSelf.resultMatchesOffset += resultMatches.count;
                                                                            if (resultMatches.count < strongSelf.limitForRequest) {
                                                                                [strongSelf.resultTableView.mj_footer endRefreshingWithNoMoreData];
                                                                                hasMoreData = NO;
                                                                            }
                                                                            
                                                                            [[TMCache sharedCache] setObject:cacheResultMatches
                                                                                                      forKey:matchesResultListCacheKey
                                                                                                       block:NULL];
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                    if (hasMoreData) {
                                                                        [strongSelf.resultTableView.mj_header endRefreshing];
                                                                    }
                                                                }];
}


#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.processTableView]){
        return [ProcessMatchCell cellHeight];
    }else if ([tableView isEqual:self.resultTableView]){
        return [ResultMatchCell cellHeight];
    }
    return 44.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [NewsTableViewHeader headerHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NewsTableViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[NewsTableViewHeader headerReuseIdentifier]];
    if ([tableView isEqual:self.processTableView]) {
        header.date = self.processMatchesManager.processMatchesContainers[section].date;
    }else if ([tableView isEqual:self.resultTableView]){
        header.date = self.resultMatchesManager.resultMatchesContainers[section].date;
    }
    return header;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([tableView isEqual:self.processTableView]) {
        
    }else if ([tableView isEqual:self.resultTableView]) {
    
    }
}
#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.processTableView]) {
        return self.processMatchesManager.processMatchesContainers[section].processMatches.count;
    }else if ([tableView isEqual:self.resultTableView]) {
        return self.resultMatchesManager.resultMatchesContainers[section].resultMatches.count;
    }
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.processTableView]) {
        
        ProcessMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProcessMatchCell cellIdentifier]
                                                                forIndexPath:indexPath];
        cell.processMatch = self.processMatchesManager.processMatchesContainers[indexPath.section].processMatches[indexPath.row];
        WEAK_SELF;
        [cell setLiveVideoBlock:^(NSString *liveVideoApp) {
            STRONG_SELF;
            RxWebViewController *webViewController = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:liveVideoApp]];
            [strongSelf.navigationController pushViewController:webViewController animated:YES];
        }];
        
        return cell;
        
    }else if ([tableView isEqual:self.resultTableView]) {
        ResultMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:[ResultMatchCell cellIdentifier]
                                                               forIndexPath:indexPath];
        cell.resultMatch = self.resultMatchesManager.resultMatchesContainers[indexPath.section].resultMatches[indexPath.row];
        WEAK_SELF;
        [cell setReplayBlock:^(ResultMatch *resultMatch) {
            STRONG_SELF;
            MatchReplayController *matchReplayController = [[MatchReplayController alloc] initWithResultMatch:resultMatch];
            [strongSelf.navigationController pushViewController:matchReplayController animated:YES];
        }];
        return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.processTableView]) {
        return self.processMatchesManager.processMatchesContainers.count;
    }else if ([tableView isEqual:self.resultTableView]) {
        return self.resultMatchesManager.resultMatchesContainers.count;
    }
    return 0;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
