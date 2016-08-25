//
//  MatchReplayController.m
//  ESports
//
//  Created by Peter Lee on 16/7/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchReplayController.h"
#import "ReplayTopCell.h"
#import "ReplayTypeCell.h"
#import "MBProgressHUD.h"
#import "HttpSessionManager.h"
#import "MatchTeamData.h"
#import "MatchPlayerData.h"
#import "MatchVideoData.h"
#import "ExtendTableViewHeaderView.h"
#import "MatchTeamDataTopCell.h"
#import "MatchTeamDataCenterCell.h"
#import "MatchTeamDataBottomCell.h"
#import "MatchPlayerDataCell.h"
#import "MatchVideoDataCell.h"
#import "RxWebViewController.h"

typedef NS_ENUM(NSUInteger, MatchReplayDisplayType) {
    MatchReplayDisplayTypeTeam = 0,
    MatchReplayDisplayTypePlayer,
    MatchReplayDisplayTypeVideo
};

@interface MatchReplayController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) MatchReplayDisplayType currentDisplayType;

@property (strong, nonatomic) MatchTeamData *matchTeamData;
@property (strong, nonatomic) MatchPlayerData *matchPlayerData;
@property (strong, nonatomic) NSMutableArray<MatchVideoData *> *matchVideoDatas;

@end

@implementation MatchReplayController

- (instancetype)initWithResultMatch:(ResultMatch *)resultMatch
{
    self = [super init];
    if (self) {
        self.resultMatch = resultMatch;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.rdv_tabBarController setTabBarHidden:YES];
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
                                           @"view_controller_title":@"Results"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"比赛结果"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"比賽結果"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.tableView registerNib:[ReplayTopCell nib] forCellReuseIdentifier:[ReplayTopCell cellIdentifier]];
    [self.tableView registerNib:[ReplayTypeCell nib] forCellReuseIdentifier:[ReplayTypeCell cellIdentifier]];
    [self.tableView registerNib:[MatchTeamDataTopCell nib] forCellReuseIdentifier:[MatchTeamDataTopCell cellIdentifier]];
    [self.tableView registerNib:[MatchTeamDataCenterCell nib] forCellReuseIdentifier:[MatchTeamDataCenterCell cellIdentifier]];
    [self.tableView registerNib:[MatchTeamDataBottomCell nib] forCellReuseIdentifier:[MatchTeamDataBottomCell cellIdentifier]];
    [self.tableView registerNib:[MatchPlayerDataCell nib] forCellReuseIdentifier:[MatchPlayerDataCell cellIdentifier]];
    [self.tableView registerNib:[MatchVideoDataCell nib] forCellReuseIdentifier:[MatchVideoDataCell cellIdentifier]];

    [self.tableView registerClass:[ExtendTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:[ExtendTableViewHeaderView sectionHeaderViewIdentifier]];
}

- (void)loadData
{
    self.currentDisplayType = MatchReplayDisplayTypeTeam;
    
    self.matchVideoDatas = [NSMutableArray array];
    
    WEAK_SELF;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpSessionManager sharedInstance] requestMatchTeamDataWithMatchId:self.resultMatch.resultMatchId
                                                                   block:^(NSDictionary *matchTeamDataDic, NSError *error) {
                                                                       
                                                                       STRONG_SELF;
                                                                       
                                                                       if (!error) {
                                                                           
                                                                           strongSelf.matchTeamData = [[MatchTeamData alloc] initWithDictionary:matchTeamDataDic error:nil];
                                                                           
                                                                           if (strongSelf.currentDisplayType == MatchReplayDisplayTypeTeam) {
                                                                               [strongSelf.tableView reloadData];
                                                                           }
                                                                       }
                                                                       
                                                                       [hud hideAnimated:YES];
                                                                   }];
}

- (void)setCurrentDisplayType:(MatchReplayDisplayType)currentDisplayType
{
    
    if (_currentDisplayType == currentDisplayType) return;
    
    _currentDisplayType = currentDisplayType;
    
    if (_currentDisplayType == MatchReplayDisplayTypeTeam) {
        [self.tableView reloadData];
    }else if (_currentDisplayType == MatchReplayDisplayTypePlayer && !self.matchPlayerData) {
        [self  firstLoadMatchPlayerData];
    }else if (_currentDisplayType == MatchReplayDisplayTypeVideo && self.matchVideoDatas.count < 1) {
        [self  firstLoadMatchVideoData];
    }else{
        [self.tableView reloadData];
    }
}

- (void)firstLoadMatchPlayerData
{
    WEAK_SELF;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpSessionManager sharedInstance] requestMatchPlayerDataWithMatchId:self.resultMatch.resultMatchId
                                                                   block:^(NSDictionary *matchPlayerDataDic, NSError *error) {
                                                                       
                                                                       STRONG_SELF;
                                                                       
                                                                       if (!error) {
                                                                        
                                                                           strongSelf.matchPlayerData = [[MatchPlayerData alloc] initWithDictionary:matchPlayerDataDic error:nil];
                                                                           
                                                                           if (strongSelf.currentDisplayType == MatchReplayDisplayTypePlayer) {
                                                                               [strongSelf.tableView reloadData];
                                                                           }
                                                                       }
                                                                       
                                                                       [hud hideAnimated:YES];
                                                                   }];
}

- (void)firstLoadMatchVideoData
{
    WEAK_SELF;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpSessionManager sharedInstance] requestMatchReplayVideoWithMatchId:self.resultMatch.resultMatchId
                                                                     block:^(NSArray<NSDictionary *> *matchVideoDataDics, NSError *error) {
                                                                         
                                                                         STRONG_SELF;
                                                                         
                                                                         if (!error) {
                                                                             
                                                                             [strongSelf.matchVideoDatas removeAllObjects];
                                                                             
                                                                             [matchVideoDataDics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 MatchVideoData *videoData = [[MatchVideoData alloc] initWithDictionary:dic error:nil];
                                                                                 if (videoData) {
                                                                                     [strongSelf.matchVideoDatas addObject:videoData];
                                                                                 }
                                                                             }];
                                                                             
                                                                             if (strongSelf.currentDisplayType == MatchReplayDisplayTypeVideo) {
                                                                                 [strongSelf.tableView reloadData];
                                                                             }
                                                                         }
                                                                         
                                                                         [hud hideAnimated:YES];
                                                                     }];
}

#pragma mark - 切换语言响应方法
- (void)languageDidChanged
{
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    [self loadData];
}

#pragma mark - UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 2;
    if (self.currentDisplayType == MatchReplayDisplayTypeTeam) {
        count += self.matchTeamData.gameOrders.count;
    }else if (self.currentDisplayType == MatchReplayDisplayTypePlayer) {
        count += self.matchPlayerData.gameOrders.count;
    }else if (self.currentDisplayType == MatchReplayDisplayTypeVideo) {
        ++count;
    }
    return count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return [ReplayTopCell cellHeight];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        return [ReplayTypeCell cellHeight];
    }else if (indexPath.section > 1 && self.currentDisplayType == MatchReplayDisplayTypeTeam){
        if (indexPath.row == 0) {
            return [MatchTeamDataBottomCell cellHeight];
        }else if (indexPath.row == 1){
            return [MatchTeamDataTopCell cellHeight];
        }else if (indexPath.row == 2){
            return [MatchTeamDataCenterCell cellHeight];
        }
    }else if (indexPath.section > 1 && self.currentDisplayType == MatchReplayDisplayTypePlayer){
        return [MatchPlayerDataCell cellHeight];
    }else if (indexPath.section > 1 && self.currentDisplayType == MatchReplayDisplayTypeVideo){
        return [MatchVideoDataCell cellHeight];
    }
    
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 10.0f;
    if (section > 1 && self.currentDisplayType == MatchReplayDisplayTypeTeam) {
        height = [ExtendTableViewHeaderView sectionHeaderViewHeight];
    }else if (section > 1 && self.currentDisplayType == MatchReplayDisplayTypePlayer) {
        height = [ExtendTableViewHeaderView sectionHeaderViewHeight];
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.000001f;
    if (section >= 1 && self.currentDisplayType == MatchReplayDisplayTypeTeam) {
        height = 10.0f;
    }else if (section >= 1 && self.currentDisplayType == MatchReplayDisplayTypePlayer) {
        height = 10.0f;
    }
    return height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 1 &&  self.currentDisplayType == MatchReplayDisplayTypeTeam) {
        ExtendTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[ExtendTableViewHeaderView sectionHeaderViewIdentifier]];
        MatchTeamGameOrder *gameOrder = self.matchTeamData.gameOrders[section-2];
        headerView.title = gameOrder.gameOrder;
        
        NSString *winTeamName = nil;
        
        if (gameOrder.teamAGameResult.win) {
            winTeamName = self.matchTeamData.teamAInfo.teamName;
        }else{
            winTeamName = self.matchTeamData.teamBInfo.teamName;
        }
        
        headerView.subTitle = winTeamName;
        headerView.isExtend = gameOrder.isExtend;
        
        WEAK_SELF;
        [headerView setSectionIndex:section tapBlock:^(NSInteger sectionIndex, BOOL isExtend) {
            STRONG_SELF;
            MatchTeamGameOrder *gameOrder = strongSelf.matchTeamData.gameOrders[sectionIndex-2];
            gameOrder.isExtend = isExtend;
            [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
        }];
        return headerView;
    }else if (section > 1 && self.currentDisplayType == MatchReplayDisplayTypePlayer) {
        ExtendTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[ExtendTableViewHeaderView sectionHeaderViewIdentifier]];
        MatchPlayerGameOrder *gameOrder = self.matchPlayerData.gameOrders[section-2];
        headerView.title = gameOrder.gameOrder;
        
        NSString *winTeamName = nil;
        if (gameOrder.isTeamAWin) {
             winTeamName = self.matchTeamData.teamAInfo.teamName;
        }else{
            winTeamName = self.matchTeamData.teamBInfo.teamName;
        }
        headerView.subTitle = winTeamName;
        headerView.isExtend = gameOrder.isExtend;
        
        WEAK_SELF;
        [headerView setSectionIndex:section tapBlock:^(NSInteger sectionIndex, BOOL isExtend) {
            STRONG_SELF;
            MatchPlayerGameOrder *gameOrder = strongSelf.matchPlayerData.gameOrders[sectionIndex-2];
            gameOrder.isExtend = isExtend;
            [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
        }];
        return headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentDisplayType == MatchReplayDisplayTypeVideo) {
        MatchVideoData *videoData = self.matchVideoDatas[indexPath.row];
        if (videoData.videoUrlApp.length > 0) {
            NSString *liveVideoApp = [videoData.videoUrlApp stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            RxWebViewController *webViewController = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:liveVideoApp]];
            [self.navigationController pushViewController:webViewController animated:YES];
        }
        
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == 0) {
        count = 1;
    }else if (section == 1){
        count = 1;
    }else if (section > 1 && self.currentDisplayType == MatchReplayDisplayTypeTeam){
        MatchTeamGameOrder *gameOrder = self.matchTeamData.gameOrders[section-2];
        if (gameOrder.isExtend) {
            count = 3;
        }else{
            count = 0;
        }
        
    }else if (section > 1 && self.currentDisplayType == MatchReplayDisplayTypePlayer) {
        MatchPlayerGameOrder *gameOrder = self.matchPlayerData.gameOrders[section-2];
        if (gameOrder.isExtend) {
            count = gameOrder.teamAPlayerDetailDatas.count + gameOrder.teamBPlayerDetailDatas.count;
        }else{
            count = 0;
        }
    }else if (section > 1 && self.currentDisplayType == MatchReplayDisplayTypeVideo){
        count = self.matchVideoDatas.count;
    }
    
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ReplayTopCell *cell = [tableView dequeueReusableCellWithIdentifier:[ReplayTopCell cellIdentifier]
                                                              forIndexPath:indexPath];
        cell.resultMatch = self.resultMatch;
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        ReplayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:[ReplayTypeCell cellIdentifier]
                                                              forIndexPath:indexPath];
        WEAK_SELF;
        [cell setSelectedIndexBlock:^(NSInteger index) {
            STRONG_SELF;
            
            strongSelf.currentDisplayType = index;
        }];
        return cell;
    }else if (indexPath.section > 1 && self.currentDisplayType == MatchReplayDisplayTypeTeam) {
        if (indexPath.row == 0) {
            
            MatchTeamDataBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchTeamDataBottomCell cellIdentifier]
                                                                            forIndexPath:indexPath];
            cell.index = indexPath.section - 2;
            cell.matchTeamData = self.matchTeamData;
            return cell;
            
        }else if (indexPath.row == 1) {
            MatchTeamGameOrder *gameOrder = self.matchTeamData.gameOrders[indexPath.section - 2];
            MatchTeamDataTopCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchTeamDataTopCell cellIdentifier]
                                                                         forIndexPath:indexPath];
            
            cell.teamAImageUrl = self.matchTeamData.teamAInfo.teamImageUrl;
            cell.teamBImageUrl = self.matchTeamData.teamBInfo.teamImageUrl;
            cell.isARedSide = gameOrder.isATeamRedSide;
            cell.gameResult = gameOrder.teamAGameResult;
            
            return cell;
        }else if (indexPath.row == 2) {
            
            MatchTeamDataCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchTeamDataCenterCell cellIdentifier]
                                                                            forIndexPath:indexPath];
            
            MatchTeamGameOrder *gameOrder = self.matchTeamData.gameOrders[indexPath.section - 2];
            
            cell.blueTeamName = self.matchTeamData.teamBInfo.teamName;
            cell.redTeamName = self.matchTeamData.teamAInfo.teamName;
            
            cell.gameOrder = gameOrder;
            
            return cell;
        }
    }else if (indexPath.section > 1 && self.currentDisplayType == MatchReplayDisplayTypePlayer) {
        MatchPlayerDataCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchPlayerDataCell cellIdentifier]
                                                                        forIndexPath:indexPath];
        MatchPlayerGameOrder *gameOrder = self.matchPlayerData.gameOrders[indexPath.section-2];
        MatchPlayerDetailData *playerDetailData = gameOrder.teamAllPlayerDetailDatas[indexPath.row];
        
        BOOL isBlueTeamPlayer = gameOrder.isTeamARedSide ? [gameOrder.teamBPlayerDetailDatas containsObject:playerDetailData]:[gameOrder.teamAPlayerDetailDatas containsObject:playerDetailData];
        
        cell.isBlueTeam = isBlueTeamPlayer;
        cell.teamName = playerDetailData.playerTeamName;
        cell.matchPlayerDetailData = playerDetailData;
        return cell;
    }else if (indexPath.section > 1 && self.currentDisplayType == MatchReplayDisplayTypeVideo) {
        
        MatchVideoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchVideoDataCell cellIdentifier]
                                                                    forIndexPath:indexPath];
        cell.matchVideoData = self.matchVideoDatas[indexPath.row];
        return cell;
        
    }
    
    return nil;
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
