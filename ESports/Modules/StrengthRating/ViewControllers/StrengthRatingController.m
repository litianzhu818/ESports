//
//  StrengthRatingController.m
//  ESports
//
//  Created by Peter Lee on 16/6/30.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengthRatingController.h"
#import "LTZLocalizationKit.h"
#import "HttpSessionManager.h"
#import "DropdownMenu.h"
#import "IonIcons.h"
#import "MJRefresh.h"
#import "TMCache.h"
#import "StrengScoreTeam.h"
#import "StrengScorePlayer.h"
#import "StrengScoreTeamCell.h"
#import "StrengScorePlayerCell.h"
#import "StrengthRankingTeamController.h"
#import "StrengthRankingPlayerController.h"

static NSString *const strengthScoreTeamsListCacheKey = @"strengthScore_controller_teams_list_cache_key";
static NSString *const strengthScorePlayersListCacheKey = @"strengthScore_controller_players_list_cache_key";
static NSString *const strengthScorePlayerRoleListCacheKey = @"strengthScore_controller_player_role_list_cache_key";

typedef NS_ENUM(NSUInteger, StrengthScoreType) {
    StrengthScoreTypeTeams = 0,
    StrengthScoreTypePlayers
};

@interface StrengthRatingController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *topBackgroundView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *rankingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankingTitleLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scoreTitleLabelWidthConstraint;

@property (weak, nonatomic) IBOutlet UITableView *teamsTableView;
@property (weak, nonatomic) IBOutlet UITableView *playersTableView;

@property (strong, nonatomic) MJRefreshNormalHeader *teamsTableViewHeader;
@property (strong, nonatomic) MJRefreshAutoNormalFooter *teamsTableViewFooter;
@property (strong, nonatomic) MJRefreshNormalHeader *playersTableViewHeader;
@property (strong, nonatomic) MJRefreshAutoNormalFooter *playersTableViewFooter;

@property (strong, nonatomic) DropdownMenu *dropdownMenu;
@property (strong, nonatomic) UIButton *button;

@property (assign, nonatomic) StrengthScoreType currentStrengthScoreType;

@property (assign, nonatomic) NSInteger teamsListOffset;
@property (assign, nonatomic) NSInteger playersListOffset;

@property (assign, nonatomic) NSInteger limitForRequest;

@property (assign, nonatomic) NSInteger playersListFirstRequest;

@property (strong, nonatomic) NSMutableArray<StrengScoreTeam *> *teams;
@property (strong, nonatomic) NSMutableArray<StrengScorePlayer *> *players;
@property (strong, nonatomic) NSMutableArray<NSString *> *roleIds;
@property (strong, nonatomic) NSString *currentRoleId;

@end

@implementation StrengthRatingController

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

- (void)loadViews
{
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"title":@"Ranking",
                                           @"ranking_type_team":@"Team",
                                           @"ranking_type_player":@"Player",
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
                                           @"tableview_footer_no_data_title":@"There is no more data",
                                           @"ranking_label_title":@"ranking",
                                           @"team_name_label_title":@"team",
                                           @"player_name_label_title":@"name",
                                           @"region_label_title":@"region",
                                           @"score_label_title":@"StrengScore"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"title":@"实力评级",
                                           @"ranking_type_team":@"战队",
                                           @"ranking_type_player":@"选手",
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
                                           @"tableview_footer_no_data_title":@"没有更多数据了",
                                           @"ranking_label_title":@"排名",
                                           @"team_name_label_title":@"战队",
                                           @"player_name_label_title":@"姓名",
                                           @"region_label_title":@"地区",
                                           @"score_label_title":@"实力评分"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"title":@"實力評級",
                                           @"ranking_type_team":@"戰隊",
                                           @"ranking_type_player":@"選手",
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
                                           @"tableview_footer_no_data_title":@"沒有更多數據了",
                                           @"ranking_label_title":@"排名",
                                           @"team_name_label_title":@"戰隊",
                                           @"player_name_label_title":@"姓名",
                                           @"region_label_title":@"地區",
                                           @"score_label_title":@"實力評分"
                                           }
                                   };
    self.title = LTZLocalizedString(@"title", nil);
    
    self.dropdownMenu = [[DropdownMenu alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]))
                                                      Items:@[[[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_global", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lck", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_eulcs", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lpl", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_nalcs", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lms", nil)]
                                                              ]
                                               currentIndex:0
                                              selectedBlock:^(NSInteger index) {
                                                  
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
    
    [self.segmentedControl setTitle:LTZLocalizedString(@"ranking_type_team", nil) forSegmentAtIndex:0];
    [self.segmentedControl setTitle:LTZLocalizedString(@"ranking_type_player", nil) forSegmentAtIndex:1];
    
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    // 修改Label字体颜色
    self.rankingTitleLabel.textColor = HexColor(0x8b8d95);
    self.nameTitleLabel.textColor = HexColor(0x8b8d95);
    self.regionTitleLabel.textColor = HexColor(0x8b8d95);
    self.scoreTitleLabel.textColor = HexColor(0x8b8d95);
    
    self.rankingTitleLabel.text = LTZLocalizedString(@"ranking_label_title", nil);
    self.nameTitleLabel.text = (self.currentStrengthScoreType == StrengthScoreTypeTeams) ? LTZLocalizedString(@"team_name_label_title", nil):LTZLocalizedString(@"player_name_label_title", nil);
    self.regionTitleLabel.text = LTZLocalizedString(@"region_label_title", nil);
    self.scoreTitleLabel.text = LTZLocalizedString(@"score_label_title", nil);
    
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:50.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:80.0f forView:self.scoreTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:30.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:55.0f forView:self.scoreTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:30.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:55.0f forView:self.scoreTitleLabel];
    }
    
    // 修改tableview的背景颜色
    self.teamsTableView.backgroundColor = self.view.backgroundColor;
    self.playersTableView.backgroundColor = self.view.backgroundColor;
    
    // 消除多余cell
    UIView *view = [UIView new];
    view.backgroundColor = self.view.backgroundColor;
    [self.teamsTableView setTableFooterView:view];
    [self.playersTableView setTableFooterView:view];
    
    // 注册cell
    [self.teamsTableView registerNib:[StrengScoreTeamCell nib] forCellReuseIdentifier:[StrengScoreTeamCell cellIdentifier]];
    [self.playersTableView registerNib:[StrengScorePlayerCell nib] forCellReuseIdentifier:[StrengScorePlayerCell cellIdentifier]];
    
    // 为UITableView添加上下拉
    // 添加下拉刷新
    self.teamsTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTeamsData)];
    // 隐藏时间
    self.teamsTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
    [self.teamsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.teamsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.teamsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    self.teamsTableView.mj_header = self.teamsTableViewHeader;
    
    
    // 添加上拉加载更多数据
    self.teamsTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTeamsData)];
    self.teamsTableViewFooter.refreshingTitleHidden = YES;
    [self.teamsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.teamsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.teamsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    self.teamsTableView.mj_footer = self.teamsTableViewFooter;
    
    // 添加下拉刷新
    self.playersTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadPlayerData)];
    // 隐藏时间
    self.playersTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
    [self.playersTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.playersTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.playersTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    self.playersTableView.mj_header = self.playersTableViewHeader;
    
    
    // 添加上拉加载更多数据
    self.playersTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorePlayerData)];
    self.playersTableViewFooter.refreshingTitleHidden = YES;
    [self.playersTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.playersTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.playersTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    self.playersTableView.mj_footer = self.playersTableViewFooter;
}

- (void)loadData
{
    self.currentStrengthScoreType = StrengthScoreTypeTeams;
    self.currentRoleId = @"0";
    self.limitForRequest = 20;
    self.teamsListOffset = 0;
    self.playersListOffset = 0;
    self.playersListFirstRequest = YES;
    
    self.teams = [NSMutableArray array];
    self.players = [NSMutableArray array];
    self.roleIds = [NSMutableArray array];
    
    
    // 取缓存中的轮换图片
    __weak typeof(self) weakSelf = self;
    
    [[TMCache sharedCache] objectForKey:strengthScorePlayerRoleListCacheKey
                                  block:^(TMCache *cache, NSString *key, NSArray<NSString *> *cacheStrengScorePlayerRoles) {
                                      
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      [strongSelf.roleIds addObjectsFromArray:cacheStrengScorePlayerRoles];
                                      
                                    }];
    
    [[TMCache sharedCache] objectForKey:strengthScoreTeamsListCacheKey
                                  block:^(TMCache *cache, NSString *key, NSArray<StrengScoreTeam *> *cacheStrengScoreTeams) {
                                      
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      [strongSelf.teams addObjectsFromArray:cacheStrengScoreTeams];
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [strongSelf.teamsTableView reloadData];
                                      });
                                  }];
    
    [[TMCache sharedCache] objectForKey:strengthScorePlayersListCacheKey
                                  block:^(TMCache *cache, NSString *key, NSArray<StrengScorePlayer *> *cacheStrengScorePlayers) {
                                      
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      [strongSelf.players addObjectsFromArray:cacheStrengScorePlayers];
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [strongSelf.playersTableView reloadData];
                                      });
                                  }];
    
    // 开始网络请求数据
    [self.teamsTableView.mj_header beginRefreshing];
    
    // 请求role列表
    [[HttpSessionManager sharedInstance] requestStrengthScorePlayerRolesWithBlock:^(NSArray<NSString *> *dics, NSError *error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!error) {
            
            if (dics.count > 0) {
                
                [strongSelf.roleIds removeAllObjects];
                
                NSMutableArray<NSString *> *cachePlayerRoleList = [NSMutableArray array];
                
                [dics enumerateObjectsUsingBlock:^(NSString * _Nonnull roleId, NSUInteger idx, BOOL * _Nonnull stop) {
                    [strongSelf.roleIds addObject:roleId];
                    [cachePlayerRoleList addObject:roleId];
                }];
                
                [[TMCache sharedCache] setObject:cachePlayerRoleList
                                          forKey:strengthScorePlayerRoleListCacheKey
                                           block:NULL];
                
            }
        }
        
    }];
    
}

- (void)showMenu
{
    if (!self.dropdownMenu.isShowing) {
        [self.dropdownMenu showMenu];
    }else{
        [self.dropdownMenu hideMenu];
    }
}

- (void)setCurrentStrengthScoreType:(StrengthScoreType)currentStrengthScoreType
{
    _currentStrengthScoreType = currentStrengthScoreType;
    
    switch (_currentStrengthScoreType) {
        case StrengthScoreTypeTeams:
        {
            self.teamsTableView.hidden = NO;
            self.playersTableView.hidden = YES;
            self.nameTitleLabel.text = LTZLocalizedString(@"team_name_label_title", nil);
        }
            break;
        case StrengthScoreTypePlayers:
        {
            self.teamsTableView.hidden = YES;
            self.playersTableView.hidden = NO;
            self.nameTitleLabel.text = LTZLocalizedString(@"player_name_label_title", nil);
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
    
    [self.segmentedControl setTitle:LTZLocalizedString(@"ranking_type_team", nil) forSegmentAtIndex:0];
    [self.segmentedControl setTitle:LTZLocalizedString(@"ranking_type_player", nil) forSegmentAtIndex:1];
    
    self.rankingTitleLabel.text = LTZLocalizedString(@"ranking_label_title", nil);
    self.nameTitleLabel.text = (self.currentStrengthScoreType == StrengthScoreTypeTeams) ? LTZLocalizedString(@"team_name_label_title", nil):LTZLocalizedString(@"player_name_label_title", nil);
    self.regionTitleLabel.text = LTZLocalizedString(@"region_label_title", nil);
    self.scoreTitleLabel.text = LTZLocalizedString(@"score_label_title", nil);
    
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:50.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:80.0f forView:self.scoreTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:30.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:55.0f forView:self.scoreTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:30.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:55.0f forView:self.scoreTitleLabel];
    }
    
    [self.teamsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.teamsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.teamsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    
    [self.teamsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.teamsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.teamsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    
    [self.playersTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.playersTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.playersTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    
    [self.playersTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.playersTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.playersTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    
    
    [self.teamsTableView.mj_header beginRefreshing];
    [self.playersTableView.mj_header beginRefreshing];
}

#pragma mark - UISegmentedControl响应事件
-(void)segmentAction:(UISegmentedControl *)SegmentedControl
{
    NSInteger index = SegmentedControl.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            if (self.currentStrengthScoreType != StrengthScoreTypeTeams) {
                self.currentStrengthScoreType = StrengthScoreTypeTeams;
            }
        }
            break;
        case 1:
        {
            if (self.currentStrengthScoreType != StrengthScoreTypePlayers) {
                self.currentStrengthScoreType = StrengthScoreTypePlayers;
                if (self.playersListFirstRequest) {
                    // 请求转会新闻数据
                    self.playersListFirstRequest = NO;
                    [self.playersTableView.mj_header beginRefreshing];
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)reloadTeamsData
{
    self.teamsListOffset = 0;
    [self.teamsTableView.mj_footer resetNoMoreData];
    __weak typeof(self) weakSelf = self;
    
    [[HttpSessionManager sharedInstance] requestStrengthScoreTeamsListWithOffset:self.teamsListOffset
                                                         numbersOfPage:self.limitForRequest
                                                                 block:^(NSArray<NSDictionary *> *dics, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (dics.count > 0) {
                                                                             
                                                                             [strongSelf.teams removeAllObjects];
                                                                             
                                                                             NSMutableArray<StrengScoreTeam *> *cacheStrengScoreTeams = [NSMutableArray array];
                                                                             
                                                                             [dics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 StrengScoreTeam *team = [[StrengScoreTeam alloc] initWithDictionary:dic error:nil];
                                                                                 if (team) {
                                                                                     [strongSelf.teams addObject:team];
                                                                                     [cacheStrengScoreTeams addObject:team];
                                                                                 }
                                                                             }];
                                                                             
                                                                             
                                                                             strongSelf.teamsListOffset += dics.count;
                                                                             
                                                                             if (dics.count < strongSelf.limitForRequest) {
                                                                                 [strongSelf.teamsTableView.mj_footer endRefreshingWithNoMoreData];
                                                                             }
                                                                             
                                                                             [strongSelf.teamsTableView reloadData];
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheStrengScoreTeams
                                                                                                       forKey:strengthScoreTeamsListCacheKey
                                                                                                        block:NULL];
                                                                             
                                                                         }
                                                                     }
                                                                     
                                                                     [strongSelf.teamsTableView.mj_header endRefreshing];
                                                                 }];
    
}

- (void)loadMoreTeamsData
{
    __weak typeof(self) weakSelf = self;
    
    [[HttpSessionManager sharedInstance] requestStrengthScoreTeamsListWithOffset:self.teamsListOffset
                                                         numbersOfPage:self.limitForRequest
                                                                 block:^(NSArray<NSDictionary *> *dics, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     BOOL hasMoreData = YES;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (dics.count > 0) {
                                                                             NSMutableArray<StrengScoreTeam *> *cacheStrengScoreTeams = [NSMutableArray array];
                                                                             
                                                                             
                                                                             [strongSelf.teamsTableView beginUpdates];
                                                                             
                                                                             [dics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 StrengScoreTeam *team = [[StrengScoreTeam alloc] initWithDictionary:dic error:nil];
                                                                                 if (team) {
                                                                                     
                                                                                     [strongSelf.teams addObject:team];
                                                                                     [cacheStrengScoreTeams addObject:team];
                                                                                     [strongSelf.teamsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:strongSelf.teams.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
                                                                                     
                                                                                 }
                                                                                 
                                                                             }];
                                                                             
                                                                             [strongSelf.teamsTableView endUpdates];
                                                                             
                                                                             
                                                                             strongSelf.teamsListOffset += dics.count;
                                                                             if (dics.count < strongSelf.limitForRequest) {
                                                                                 [strongSelf.teamsTableView.mj_footer endRefreshingWithNoMoreData];
                                                                                 hasMoreData = NO;
                                                                             }
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheStrengScoreTeams
                                                                                                       forKey:strengthScoreTeamsListCacheKey
                                                                                                        block:NULL];
                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                     if (hasMoreData) {
                                                                         [strongSelf.teamsTableView.mj_header endRefreshing];
                                                                     }
                                                                     
                                                                 }];
}

- (void)reloadPlayerData
{
    self.playersListOffset = 0;
    __weak typeof(self) weakSelf = self;
    [self.playersTableView.mj_footer resetNoMoreData];
    [[HttpSessionManager sharedInstance] requestStrengthScorePlayersListWithOffset:self.playersListOffset
                                                        numbersOfPage:self.limitForRequest
                                                                block:^(NSArray<NSDictionary *> *dics, NSError *error) {
                                                                    
                                                                    __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                    
                                                                    if (!error) {
                                                                        if (dics.count > 0) {
                                                                            
                                                                            [strongSelf.players removeAllObjects];
                                                                            
                                                                            NSMutableArray<StrengScorePlayer *> *cacheStrengScorePlayers = [NSMutableArray array];
                                                                            
                                                                            [dics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                StrengScorePlayer *player = [[StrengScorePlayer alloc] initWithDictionary:dic error:nil];
                                                                                if (player) {
                                                                                    [strongSelf.players addObject:player];
                                                                                    [cacheStrengScorePlayers addObject:player];
                                                                                }
                                                                            }];
                                                                            
                                                                            
                                                                            strongSelf.playersListOffset += dics.count;
                                                                            
                                                                            if (dics.count < strongSelf.limitForRequest) {
                                                                                [strongSelf.playersTableView.mj_footer endRefreshingWithNoMoreData];
                                                                            }
                                                                            
                                                                            [strongSelf.playersTableView reloadData];
                                                                            
                                                                            [[TMCache sharedCache] setObject:cacheStrengScorePlayers
                                                                                                      forKey:strengthScorePlayersListCacheKey
                                                                                                       block:NULL];
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                    [strongSelf.playersTableView.mj_header endRefreshing];
                                                                }];
}

- (void)loadMorePlayerData
{
    __weak typeof(self) weakSelf = self;
    
    [[HttpSessionManager sharedInstance] requestStrengthScorePlayersListWithOffset:self.playersListOffset
                                                                     numbersOfPage:self.limitForRequest
                                                                            roleId:(NSString *)roleId
                                                                block:^(NSArray<NSDictionary *> *dics, NSError *error) {
                                                                    __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                    
                                                                    BOOL hasMoreData = YES;
                                                                    
                                                                    if (!error) {
                                                                        
                                                                        if (dics.count > 0) {
                                                                            NSMutableArray<StrengScorePlayer *> *cacheStrengScorePlayers = [NSMutableArray array];
        
                                                                            
                                                                            [strongSelf.playersTableView beginUpdates];
                                                                            
                                                                            [dics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                StrengScorePlayer *player = [[StrengScorePlayer alloc] initWithDictionary:dic error:nil];
                                                                                if (player) {
                                                                                    
                                                                                    [strongSelf.players addObject:player];
                                                                                    [cacheStrengScorePlayers addObject:player];
                                                                                    [strongSelf.teamsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:strongSelf.players.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
                                                                                }
                                                                                
                                                                            }];
                                                                            
                                                                            [strongSelf.playersTableView endUpdates];
                                                                            
                                                                            strongSelf.playersListOffset += dics.count;
                                                                            if (dics.count < strongSelf.limitForRequest) {
                                                                                [strongSelf.playersTableView.mj_footer endRefreshingWithNoMoreData];
                                                                                hasMoreData = NO;
                                                                            }
                                                                            
                                                                            [[TMCache sharedCache] setObject:cacheStrengScorePlayers
                                                                                                      forKey:strengthScorePlayersListCacheKey
                                                                                                       block:NULL];
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                    if (hasMoreData) {
                                                                        [strongSelf.playersTableView.mj_header endRefreshing];
                                                                    }
                                                                }];
}


#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.teamsTableView]){
        return [StrengScoreTeamCell cellHeight];
    }else if ([tableView isEqual:self.playersTableView]){
        return [StrengScorePlayerCell cellHeight];
    }
    return 44.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([tableView isEqual:self.teamsTableView]) {
        
        StrengScoreTeam *team = self.teams[indexPath.row];
        StrengthRankingTeamController *teamController = [[StrengthRankingTeamController alloc] initWithTeamId:team.teamId];
        [self.navigationController pushViewController:teamController animated:YES];
        
    }else if ([tableView isEqual:self.playersTableView]) {

        StrengScorePlayer *player = self.players[indexPath.row];
        StrengthRankingPlayerController *playerController = [[StrengthRankingPlayerController alloc] initWithPlayerId:player.playerId
                                                                                                                 role:player.playerRoleId];
        [self.navigationController pushViewController:playerController animated:YES];
    }
}
#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.teamsTableView]) {
        return self.teams.count;
    }else if ([tableView isEqual:self.playersTableView]) {
        return self.players.count;
    }
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.teamsTableView]) {
        
        StrengScoreTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScoreTeamCell cellIdentifier]
                                                                 forIndexPath:indexPath];
        cell.team = self.teams[indexPath.row];
        
        return cell;
        
    }else if ([tableView isEqual:self.playersTableView]) {
        StrengScorePlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScorePlayerCell cellIdentifier]
                                                                forIndexPath:indexPath];
        cell.player = self.players[indexPath.row];
        return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark - tool methods
- (void)adjustWidthWidthConstraint:(NSLayoutConstraint *)widthConstraint value:(CGFloat)value forView:(UIView *)view
{
    widthConstraint.constant = value;
    [view setNeedsUpdateConstraints];
}

@end
