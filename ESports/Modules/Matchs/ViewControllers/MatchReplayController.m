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
@property (strong, nonatomic) NSMutableArray<MatchPlayerData *> *matchPlayerDatas;
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
                                           @"view_controller_title":@"Replay"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"重播"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"重播"
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

    self.matchPlayerDatas = [NSMutableArray array];
    self.matchVideoDatas = [NSMutableArray array];
    
    WEAK_SELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpSessionManager sharedInstance] requestMatchTeamDataWithMatchId:self.resultMatch.resultMatchId
                                                                   block:^(NSDictionary *matchTeamDataDic, NSError *error) {
                                                                       
                                                                       STRONG_SELF;
                                                                       
                                                                       if (!error) {
                                                                           
                                                                           strongSelf.matchTeamData = [[MatchTeamData alloc] initWithDictionary:matchTeamDataDic error:nil];
                                                                           
                                                                           if (strongSelf.currentDisplayType == MatchReplayDisplayTypeTeam) {
                                                                               [strongSelf.tableView reloadData];
                                                                           }
                                                                       }
                                                                       
                                                                       [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
                                                                   }];
}

- (void)setCurrentDisplayType:(MatchReplayDisplayType)currentDisplayType
{
    
    if (_currentDisplayType == currentDisplayType) return;
    
    _currentDisplayType = currentDisplayType;
    
    if (_currentDisplayType == MatchReplayDisplayTypeTeam) {
        [self.tableView reloadData];
    }else if (_currentDisplayType == MatchReplayDisplayTypePlayer && self.matchPlayerDatas.count < 1) {
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpSessionManager sharedInstance] requestMatchPlayerDataWithMatchId:self.resultMatch.resultMatchId
                                                                   block:^(NSArray<NSDictionary *> *matchPlayerDataDics, NSError *error) {
                                                                       
                                                                       STRONG_SELF;
                                                                       
                                                                       if (!error) {
                                                                           
                                                                           [strongSelf.matchPlayerDatas removeAllObjects];
                                                                           
                                                                           [matchPlayerDataDics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                               MatchPlayerData *playerData = [[MatchPlayerData alloc] initWithDictionary:dic error:nil];
                                                                               if (playerData) {
                                                                                   [strongSelf.matchPlayerDatas addObject:playerData];
                                                                               }
                                                                           }];
                                                                           
                                                                           if (strongSelf.currentDisplayType == MatchReplayDisplayTypePlayer) {
                                                                               [strongSelf.tableView reloadData];
                                                                           }
                                                                       }
                                                                       
                                                                       [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
                                                                   }];
}

- (void)firstLoadMatchVideoData
{
    WEAK_SELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
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
                                                                         
                                                                         [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
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
        count = self.matchPlayerDatas.count;
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
            return [MatchTeamDataTopCell cellHeight];
        }else if (indexPath.row == 1){
            return [MatchTeamDataCenterCell cellHeight];
        }else if (indexPath.row == 2){
            MatchTeamData *teamData = self.matchTeamDatas[indexPath.section-2];
            return [MatchTeamDataBottomCell cellHeightWithMatchTeamData:teamData isPicks:YES];
        }else if (indexPath.row == 3){
            MatchTeamData *teamData = self.matchTeamDatas[indexPath.section-2];
            return [MatchTeamDataBottomCell cellHeightWithMatchTeamData:teamData isPicks:NO];
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
        headerView.title = self.matchTeamDatas[section-2].gameOrder;
        headerView.isExtend = self.matchTeamDatas[section-2].isExtend;
        
        WEAK_SELF;
        [headerView setSectionIndex:section tapBlock:^(NSInteger sectionIndex, BOOL isExtend) {
            STRONG_SELF;
            MatchTeamData *teamData = strongSelf.matchTeamDatas[sectionIndex-2];
            teamData.isExtend = isExtend;
            [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
        }];
        return headerView;
    }else if (section > 1 && self.currentDisplayType == MatchReplayDisplayTypePlayer) {
        ExtendTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[ExtendTableViewHeaderView sectionHeaderViewIdentifier]];
        headerView.title = self.matchPlayerDatas[section-2].gameOrder;
        headerView.isExtend = self.matchPlayerDatas[section-2].isExtend;
        
        WEAK_SELF;
        [headerView setSectionIndex:section tapBlock:^(NSInteger sectionIndex, BOOL isExtend) {
            STRONG_SELF;
            MatchPlayerData *playerData = strongSelf.matchPlayerDatas[sectionIndex-2];
            playerData.isExtend = isExtend;
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
            RxWebViewController *webViewController = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:videoData.videoUrlApp]];
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
        MatchTeamData *teamData = self.matchTeamDatas[section - 2];
        if (teamData.isExtend) {
            count = 4;
        }else{
            count = 0;
        }
        
    }else if (section > 1 && self.currentDisplayType == MatchReplayDisplayTypePlayer) {
        MatchPlayerData *playerData = self.matchPlayerDatas[section - 2];
        if (playerData.isExtend) {
            count = playerData.bluePlayersDetailData.count + playerData.redPlayersDetailData.count;
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
            MatchTeamData *teamData = self.matchTeamDatas[indexPath.section - 2];
            MatchTeamDataTopCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchTeamDataTopCell cellIdentifier]
                                                                         forIndexPath:indexPath];
            cell.blueTeamImageUrl = teamData.buleTeamImageUrl;
            cell.redTeamImageUrl = teamData.redTeamImageUrl;
            cell.gameResult = teamData.teamGameResult;
            
            return cell;
        }else if (indexPath.row == 1) {
            MatchTeamDataCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchTeamDataCenterCell cellIdentifier]
                                                                         forIndexPath:indexPath];
            cell.blueTeamName = self.resultMatch.aTeamName;
            cell.redTeamName = self.resultMatch.bTeamName;
            cell.matchTeamData = self.matchTeamDatas[indexPath.section - 2];
            
            return cell;
        }else if (indexPath.row == 2) {
            MatchTeamData *teamData = self.matchTeamDatas[indexPath.section - 2];
            MatchTeamDataBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchTeamDataBottomCell cellIdentifier]
                                                                            forIndexPath:indexPath];
            cell.isPicks = YES;
            cell.matchTeamData = teamData;
            return cell;
        }else if (indexPath.row == 3) {
            MatchTeamData *teamData = self.matchTeamDatas[indexPath.section - 2];
            MatchTeamDataBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchTeamDataBottomCell cellIdentifier]
                                                                            forIndexPath:indexPath];
            cell.isPicks = NO;
            cell.matchTeamData = teamData;
            return cell;
        }
    }else if (indexPath.section > 1 && self.currentDisplayType == MatchReplayDisplayTypePlayer) {
        MatchPlayerDataCell *cell = [tableView dequeueReusableCellWithIdentifier:[MatchPlayerDataCell cellIdentifier]
                                                                        forIndexPath:indexPath];
        MatchPlayerDetailData *playerDetailData = self.matchPlayerDatas[indexPath.section-2].playersDetailDatas[indexPath.row];
        
        BOOL isBlueTeamPlayer = [self.matchPlayerDatas[indexPath.section-2].bluePlayersDetailData containsObject:playerDetailData];
        cell.isBlueTeam = isBlueTeamPlayer;
        cell.teamName = isBlueTeamPlayer ? self.resultMatch.aTeamName:self.resultMatch.bTeamName;
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
