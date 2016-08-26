//
//  RankingController.m
//  ESports
//
//  Created by Peter Lee on 16/6/30.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "RankingController.h"
#import "LTZLocalizationKit.h"
#import "HttpSessionManager.h"
#import "DropdownMenu.h"
#import "IonIcons.h"
#import "MJRefresh.h"
#import "TMCache.h"
#import "MBProgressHUD.h"
#import "PointsType.h"
#import "PointsTeam.h"
#import "PointsTypeSelectView.h"
#import "ActionSheetPicker.h"
#import "MatchStandingCell.h"
#import "NSObject+Custom.h"
#import "MatchZoneManager.h"

static NSString *const rankingListCacheKey = @"ranking_controller_ranking_list_cache_key";
static NSString *const CURRENT_MATCH_POINTS_TYPE = @"current_match_points_type_key";

@interface SystemConfig (rankingTeamName)

- (void)setCurrentMatchPointsType:(PointsType *)currentMatchPointsType;
- (PointsType *)currentMatchPointsType;

@end

@implementation SystemConfig (rankingTeamName)

- (void)setCurrentMatchPointsType:(PointsType *)currentMatchPointsType
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:currentMatchPointsType];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:CURRENT_MATCH_POINTS_TYPE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (PointsType *)currentMatchPointsType
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_MATCH_POINTS_TYPE];
    return (PointsType *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end

@interface RankingController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) PointsTypeSelectView *pointsTypeSelectView;

@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic) MJRefreshNormalHeader *tableViewHeader;

@property (strong, nonatomic) DropdownMenu *dropdownMenu;
@property (strong, nonatomic) UIButton *button;

@property (strong, nonatomic) ActionSheetStringPicker *actionSheetStringPicker;

@property (assign, nonatomic) PointsType *currentPointsType;

@property (strong, nonatomic) NSMutableArray<PointsType *> *pointsTypes;
@property (strong, nonatomic) NSMutableArray<PointsTeam *> *pointsTeams;

@end

@implementation RankingController

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
                                           @"view_controller_title":@"Standing",
                                           @"pointsType_wait_download":@"please wait...",
                                           @"pointsType_no_data":@"no data",
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
                                           @"picker_title":@"Match types",
                                           @"picker_cancel_title":@"Cancel",
                                           @"picker_select_title":@"Done"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"积分榜",
                                           @"pointsType_wait_download":@"正在获取...",
                                           @"pointsType_no_data":@"没有数据",
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
                                           @"picker_title":@"赛事类型",
                                           @"picker_cancel_title":@"取消",
                                           @"picker_select_title":@"选择"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"積分榜",
                                           @"pointsType_wait_download":@"正在獲取...",
                                           @"pointsType_no_data":@"沒有數據",
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
                                           @"picker_title":@"賽事類型",
                                           @"picker_cancel_title":@"取消",
                                           @"picker_select_title":@"選擇"
                                           
                                           }
                                   };
    self.title = LTZLocalizedString(@"title", nil);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    
    // 修改tableview的背景颜色
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    
    self.pointsTypeSelectView = [PointsTypeSelectView instanceFromNib];
    self.pointsTypeSelectView.translatesAutoresizingMaskIntoConstraints = NO;
    self.pointsTypeSelectView.teamName = LTZLocalizedString(@"pointsType_wait_download", nil);

    [self.pointsTypeSelectView setTapActionBlock:^{
        STRONG_SELF;
        [strongSelf.actionSheetStringPicker showActionSheetPicker];
    }];
    
    [self.view addSubview:self.pointsTypeSelectView];
    
    self.tableView = ({
    
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = self.view.backgroundColor;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *view = [UIView new];
        view.backgroundColor = self.view.backgroundColor;
        [tableView setTableFooterView:view];
        
        [tableView registerNib:[MatchStandingCell nib] forCellReuseIdentifier:[MatchStandingCell cellIdentifier]];
        
        [self.view addSubview:tableView];
        tableView;
    });
    
    [self.view bringSubviewToFront:self.dropdownMenu];
    
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0.0-[_pointsTypeSelectView]-0.0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_pointsTypeSelectView)]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0.0-[_tableView]-0.0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_tableView)]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0.0-[_pointsTypeSelectView(==100)]-0.0-[_tableView]-0.0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_pointsTypeSelectView, _tableView)]];
    [self.view addConstraints:constraints];
    
    
    // 为UITableView添加上下拉
    // 添加下拉刷新
    self.tableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTeamListData)];
    // 隐藏时间
    self.tableViewHeader.lastUpdatedTimeLabel.hidden = YES;
    [self.tableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.tableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.tableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = self.tableViewHeader;
}

- (ActionSheetStringPicker *)actionSheetStringPicker
{
    if (!_actionSheetStringPicker) {
        
        NSInteger index = [self.pointsTypes indexOfObject:self.currentPointsType];
        NSArray *titles = [self.pointsTypes valueForKeyPath:@"pointsTypeName"];
        WEAK_SELF;
        _actionSheetStringPicker = [[ActionSheetStringPicker alloc] initWithTitle:LTZLocalizedString(@"picker_title", nil)
                                                                             rows:titles
                                                                 initialSelection:index
                                                                        doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                            
                                                                            STRONG_SELF;
                                                                            strongSelf.currentPointsType = strongSelf.pointsTypes[selectedIndex];
                                                                            
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

- (void)loadData
{
    //self.currentPointsType = [[SystemConfig sharedInstance] currentMatchPointsType];
    self.pointsTypes = [NSMutableArray array];
    self.pointsTeams = [NSMutableArray array];
    
    [self loadPointsTypeData];
}

- (void)showMenu
{
    if (!self.dropdownMenu.isShowing) {
        [self.dropdownMenu showMenu];
    }else{
        [self.dropdownMenu hideMenu];
    }
}

- (void)setCurrentPointsType:(PointsType *)currentPointsType
{
    if (currentPointsType == _currentPointsType) return;
    
    
    _currentPointsType = currentPointsType;
    
    if (_currentPointsType) {
        [[SystemConfig sharedInstance] setCurrentMatchPointsType:_currentPointsType];
        WEAK_SELF;
        dispatch_async(dispatch_get_main_queue(), ^{
            STRONG_SELF;
            strongSelf.pointsTypeSelectView.teamName = _currentPointsType.pointsTypeName;
            [strongSelf.tableViewHeader beginRefreshing];
        });
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
    
    [self.tableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.tableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.tableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];

    
    [self loadPointsTypeData];
    //[self.tableView.mj_header beginRefreshing];
    
    if (self.pointsTypes.count == 0) {
        self.pointsTypeSelectView.teamName = LTZLocalizedString(@"pointsType_no_data", nil);
    }
    
    self.actionSheetStringPicker = nil;
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
    
    [self loadPointsTypeData];
    
    if (self.pointsTypes.count == 0) {
        self.pointsTypeSelectView.teamName = LTZLocalizedString(@"pointsType_no_data", nil);
    }
    
    self.actionSheetStringPicker = nil;
}

#pragma mark - 网络请求数据
- (void)loadPointsTypeData
{
    WEAK_SELF;
    
    self.currentPointsType = nil;
    [self.pointsTypes removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpSessionManager sharedInstance] requestMatchPointsTypeListWithBlock:^(NSArray<NSDictionary *> *dics, NSError *error) {
        
        STRONG_SELF;
        
        if (!error) {
            
            __block BOOL containsCurrentPointsType = NO;
            
            [dics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                PointsType *pointsType = [[PointsType alloc] initWithDictionary:dic error:nil];
                if (pointsType) {
                    [strongSelf.pointsTypes addObject:pointsType];
                    if (strongSelf.currentPointsType && [strongSelf.currentPointsType.pointsTypeId isEqualToString:pointsType.pointsTypeId]) {
                        containsCurrentPointsType = YES;
                    }
                }
            }];
            
            if (strongSelf.pointsTypes.count > 0 && !containsCurrentPointsType) {
                strongSelf.currentPointsType = strongSelf.pointsTypes[0];
                strongSelf.actionSheetStringPicker = nil;
            }else if (self.pointsTypes.count == 0){
                strongSelf.pointsTypeSelectView.teamName = LTZLocalizedString(@"pointsType_no_data", nil);
            }
        }else{
            strongSelf.pointsTypeSelectView.teamName = LTZLocalizedString(@"pointsType_no_data", nil);
        }
        [hud hideAnimated:YES];
    }];
}
- (void)loadTeamListData
{
    if (!self.currentPointsType) {
        [self.tableViewHeader endRefreshing];
        return;
    }
    
    WEAK_SELF;
    [[HttpSessionManager sharedInstance] requestTeamListWithPointsTypeId:self.currentPointsType.pointsTypeId
                                                                   block:^(NSArray<NSDictionary *> *dics, NSError *error) {
                                                                       STRONG_SELF;
                                                                       
                                                                       if (!error) {
                                                                           [strongSelf.pointsTeams removeAllObjects];
                                                                           [dics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                               PointsTeam *team = [[PointsTeam alloc] initWithDictionary:dic error:nil];
                                                                               if (team) {
                                                                                   [strongSelf.pointsTeams addObject:team];
                                                                               }
                                                                           }];
                                                                           
                                                                           [strongSelf.tableView reloadData];
                                                                       }
                                                                       
                                                                       [strongSelf.tableViewHeader endRefreshing];
                                                                   }];
    
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MatchStandingCell cellHeight];
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
}
#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pointsTeams.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MatchStandingCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchStandingCell cellIdentifier]
                                                             forIndexPath:indexPath];
    cell.pointsTeam = self.pointsTeams[indexPath.row];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
