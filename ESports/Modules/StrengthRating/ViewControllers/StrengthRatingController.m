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
#import "MatchZoneManager.h"
#import "NSObject+Custom.h"
#import "PlayerRole.h"
#import "ActionSheetStringPicker.h"

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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBackViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UITableView *teamsTableView;
@property (weak, nonatomic) IBOutlet UITableView *playersTableView;

@property (weak, nonatomic) IBOutlet UIView *playerRoleView;
@property (weak, nonatomic) IBOutlet UILabel *playerRoleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerRoleImageView;

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
@property (strong, nonatomic) NSMutableArray<PlayerRole *> *playerRoles;
@property (strong, nonatomic) NSString *currentRoleId;

@property (strong, nonatomic) ActionSheetStringPicker *actionSheetStringPicker;

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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MatchZoneValueDidChangedKey object:nil];
}

- (void)loadViews
{
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"title":@"Rating",
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
                                           @"ranking_label_title":@"Rank",
                                           @"team_name_label_title":@"Team",
                                           @"player_name_label_title":@"Player",
                                           @"region_label_title":@"Region",
                                           @"score_label_title":@"Rating",
                                           @"role_list_all_title":@"Role",
                                           @"picker_title":@"Roles",
                                           @"picker_cancel_title":@"Cancel",
                                           @"picker_select_title":@"Done"
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
                                           @"score_label_title":@"实力评分",
                                           @"role_list_all_title":@"位置",
                                           @"picker_title":@"角色",
                                           @"picker_cancel_title":@"取消",
                                           @"picker_select_title":@"确定"
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
                                           @"score_label_title":@"實力評分",
                                           @"role_list_all_title":@"位置",
                                           @"picker_title":@"角色",
                                           @"picker_cancel_title":@"取消",
                                           @"picker_select_title":@"確定"
                                           }
                                   };
    self.title = LTZLocalizedString(@"title", nil);
    
    self.topBackViewHeightConstraint.constant = 90.0f;
    [self.topBackgroundView setNeedsUpdateConstraints];
    self.playerRoleView.hidden = YES;
    
    self.playerRoleView.layer.borderWidth = 1.0f;
    self.playerRoleView.layer.borderColor = HexColor(0xe9912f).CGColor;
    [self.playerRoleView setBackgroundColor:HexColor(0x173b51)];
    self.playerRoleLabel.text = LTZLocalizedString(@"role_list_all_title", nil);
    [self.playerRoleImageView setImage:[IonIcons imageWithIcon:icon_arrow_down_b size:12.0f color:[UIColor whiteColor]]];

    
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
    
    NSString *buttonTitle = nil;
    switch ([self currentIndexWithMatchZoneId:[[MatchZoneManager sharedInstance] matchZoneId]]) {
        case 0:
            buttonTitle = LTZLocalizedString(@"local_item_global", nil);
            break;
        case 1:
            buttonTitle = LTZLocalizedString(@"local_item_lck", nil);
            break;
        case 2:
            buttonTitle = LTZLocalizedString(@"local_item_eulcs", nil);
            break;
        case 3:
            buttonTitle = LTZLocalizedString(@"local_item_lpl", nil);
            break;
        case 4:
            buttonTitle = LTZLocalizedString(@"local_item_nalcs", nil);
            break;
        case 5:
            buttonTitle = LTZLocalizedString(@"local_item_lms", nil);
            break;
        default:
            buttonTitle = LTZLocalizedString(@"local_item_global", nil);
            break;
    }
    
    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
    [self.button setTitle:buttonTitle forState:UIControlStateHighlighted];
    [self.button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    
    [IonIcons label:self.button.titleLabel setIcon:icon_chevron_down size:14.0f color:[UIColor whiteColor] sizeToFit:NO];
    [self.button setImage:[IonIcons imageWithIcon:icon_chevron_down size:12.0f color:[[UIColor whiteColor] colorWithAlphaComponent:0.7]] forState:UIControlStateNormal];
    [self.button setImage:[IonIcons imageWithIcon:icon_chevron_down size:12.0f color:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    
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
                                       NSFontAttributeName:[UIFont systemFontOfSize:14.0f]
                                       };
    NSDictionary *selectedAttributes = @{
                                         NSForegroundColorAttributeName:[UIColor whiteColor],
                                         NSFontAttributeName:[UIFont systemFontOfSize:14.0f]
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
    self.playerRoles = [NSMutableArray array];
    
    
    // 取缓存中的轮换图片
    __weak typeof(self) weakSelf = self;
    
    [[TMCache sharedCache] objectForKey:strengthScorePlayerRoleListCacheKey
                                  block:^(TMCache *cache, NSString *key, NSArray<PlayerRole *> *cacheStrengScorePlayerRoles) {
                                      
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      [strongSelf.playerRoles addObjectsFromArray:cacheStrengScorePlayerRoles];
                                      self.currentRoleId = strongSelf.playerRoles[0].roleId;
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
    [[HttpSessionManager sharedInstance] requestStrengthScorePlayerRolesWithBlock:^(NSArray<NSDictionary *> *dics, NSError *error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!error) {
            
            if (dics.count > 0) {
                
                [strongSelf.playerRoles removeAllObjects];
                
                NSMutableArray<PlayerRole *> *cachePlayerRoleList = [NSMutableArray array];
                
                [dics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull roleDic, NSUInteger idx, BOOL * _Nonnull stop) {
                    PlayerRole *role = [[PlayerRole alloc] initWithDictionary:roleDic error:nil];
                    if (role) {
                        [strongSelf.playerRoles addObject:role];
                        [cachePlayerRoleList addObject:role];
                    }
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
            
            self.topBackViewHeightConstraint.constant = 90.0f;
            [self.topBackgroundView setNeedsUpdateConstraints];
            self.playerRoleView.hidden = YES;
        }
            break;
        case StrengthScoreTypePlayers:
        {
            self.teamsTableView.hidden = YES;
            self.playersTableView.hidden = NO;
            self.nameTitleLabel.text = LTZLocalizedString(@"player_name_label_title", nil);
            
            self.topBackViewHeightConstraint.constant = 120.0f;
            [self.topBackgroundView setNeedsUpdateConstraints];
            self.playerRoleView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

- (ActionSheetStringPicker *)actionSheetStringPicker
{
    if (!_actionSheetStringPicker) {
        
        __block NSInteger index = 0;
        
        [self.playerRoles enumerateObjectsUsingBlock:^(PlayerRole * _Nonnull role, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([role.roleId isEqualToString:self.currentRoleId]) {
                index = idx + 1;
            }
        }];
        
        NSMutableArray *titles = [NSMutableArray arrayWithObject:LTZLocalizedString(@"role_list_all_title", nil)];
        
        if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
            [titles addObjectsFromArray:[self.playerRoles valueForKeyPath:@"roleNameEn"]];
        }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
            [titles addObjectsFromArray:[self.playerRoles valueForKeyPath:@"roleNameCn"]];
        }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
            [titles addObjectsFromArray:[self.playerRoles valueForKeyPath:@"roleNameTw"]];
        }
        
        
        WEAK_SELF;
        _actionSheetStringPicker = [[ActionSheetStringPicker alloc] initWithTitle:LTZLocalizedString(@"picker_title", nil)
                                                                             rows:titles
                                                                 initialSelection:index
                                                                        doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                            
                                                                            STRONG_SELF;
                                                                            if (selectedIndex == 0) {
                                                                                strongSelf.currentRoleId = @"0";
                                                                            }else{
                                                                                strongSelf.currentRoleId = strongSelf.playerRoles[selectedIndex-1].roleId;
                                                                            }
                                                                            
                                                                            strongSelf.playerRoleLabel.text = [titles objectAtIndex:selectedIndex];
                                                                            
                                                                        } cancelBlock:^(ActionSheetStringPicker *picker) {
                                                                            
                                                                        } origin:self.view];
        _actionSheetStringPicker.pickerBackgroundColor = HexColor(0x0e161f);
        _actionSheetStringPicker.toolbarBackgroundColor = HexColor(0x121b27);
        _actionSheetStringPicker.toolbarButtonsColor = HexColor(0x8b8d95);
        _actionSheetStringPicker.titleTextAttributes = @{NSForegroundColorAttributeName:HexColor(0xa7a8ab)};
        
        UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] init];
        cancelBarButtonItem.title = LTZLocalizedString(@"picker_cancel_title", nil);
        UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] init];
        doneBarButtonItem.title = LTZLocalizedString(@"picker_select_title", nil);
        
        [_actionSheetStringPicker setCancelButton:cancelBarButtonItem];
        [_actionSheetStringPicker setDoneButton:doneBarButtonItem];
        
        [_actionSheetStringPicker setTextColor:HexColor(0x8b8d95)];
    }
    
    return _actionSheetStringPicker;
}


- (IBAction)tapOnChangePlayerRoleBtn:(id)sender
{
    [self.actionSheetStringPicker showActionSheetPicker];
}

- (void)setCurrentRoleId:(NSString *)currentRoleId
{
    if ([_currentRoleId isEqualToString:currentRoleId]) return;
    
    _currentRoleId = currentRoleId;
    
    [self reloadPlayerData];
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
    
    NSString *buttonTitle = nil;
    switch ([self currentIndexWithMatchZoneId:[[MatchZoneManager sharedInstance] matchZoneId]]) {
        case 0:
            buttonTitle = LTZLocalizedString(@"local_item_global", nil);
            break;
        case 1:
            buttonTitle = LTZLocalizedString(@"local_item_lck", nil);
            break;
        case 2:
            buttonTitle = LTZLocalizedString(@"local_item_eulcs", nil);
            break;
        case 3:
            buttonTitle = LTZLocalizedString(@"local_item_lpl", nil);
            break;
        case 4:
            buttonTitle = LTZLocalizedString(@"local_item_nalcs", nil);
            break;
        case 5:
            buttonTitle = LTZLocalizedString(@"local_item_lms", nil);
            break;
        default:
            buttonTitle = LTZLocalizedString(@"local_item_global", nil);
            break;
    }
    
    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
    [self.button setTitle:buttonTitle forState:UIControlStateHighlighted];
    [self.button sizeToFit];
    self.button.titleEdgeInsets = UIEdgeInsetsMake(0, -self.button.imageView.frame.size.width-10, 0, self.button.imageView.frame.size.width);
    self.button.imageEdgeInsets = UIEdgeInsetsMake(0, self.button.titleLabel.frame.size.width-5, 0, -self.button.titleLabel.frame.size.width);
    
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
    
    self.actionSheetStringPicker = nil;
    __block NSInteger index = 0;
    
    [self.playerRoles enumerateObjectsUsingBlock:^(PlayerRole * _Nonnull role, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([role.roleId isEqualToString:self.currentRoleId]) {
            index = idx + 1;
        }
    }];
    
    NSMutableArray *titles = [NSMutableArray arrayWithObject:LTZLocalizedString(@"role_list_all_title", nil)];
    
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        [titles addObjectsFromArray:[self.playerRoles valueForKeyPath:@"roleNameEn"]];
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
        [titles addObjectsFromArray:[self.playerRoles valueForKeyPath:@"roleNameCn"]];
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
        [titles addObjectsFromArray:[self.playerRoles valueForKeyPath:@"roleNameTw"]];
    }

    self.playerRoleLabel.text = titles[index];
    
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

#pragma mark - 切换赛区
- (void)matchZoneDidChanged:(NSNotification *)notification
{
    [self.dropdownMenu setSelectedIndex:[self currentIndexWithMatchZoneId:notification.object]];
    
    NSString *buttonTitle = nil;
    switch ([self currentIndexWithMatchZoneId:[[MatchZoneManager sharedInstance] matchZoneId]]) {
        case 0:
            buttonTitle = LTZLocalizedString(@"local_item_global", nil);
            break;
        case 1:
            buttonTitle = LTZLocalizedString(@"local_item_lck", nil);
            break;
        case 2:
            buttonTitle = LTZLocalizedString(@"local_item_eulcs", nil);
            break;
        case 3:
            buttonTitle = LTZLocalizedString(@"local_item_lpl", nil);
            break;
        case 4:
            buttonTitle = LTZLocalizedString(@"local_item_nalcs", nil);
            break;
        case 5:
            buttonTitle = LTZLocalizedString(@"local_item_lms", nil);
            break;
        default:
            buttonTitle = LTZLocalizedString(@"local_item_global", nil);
            break;
    }
    
    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
    [self.button setTitle:buttonTitle forState:UIControlStateHighlighted];
    [self.button sizeToFit];
    self.button.titleEdgeInsets = UIEdgeInsetsMake(0, -self.button.imageView.frame.size.width-10, 0, self.button.imageView.frame.size.width);
    self.button.imageEdgeInsets = UIEdgeInsetsMake(0, self.button.titleLabel.frame.size.width-5, 0, -self.button.titleLabel.frame.size.width);
    
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
                                                                         [strongSelf.teamsTableView.mj_footer endRefreshing];
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
                                                            roleId:self.currentRoleId
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
                                                                            roleId:self.currentRoleId
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
                                                                                    [strongSelf.playersTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:strongSelf.players.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
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
                                                                        [strongSelf.playersTableView.mj_footer endRefreshing];
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
