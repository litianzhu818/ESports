//
//  StrengthRankingPlayerController.m
//  ESports
//
//  Created by Peter Lee on 16/8/11.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengthRankingPlayerController.h"
#import "HttpSessionManager.h"
#import "MBProgressHUD.h"
#import "StrengScorePlayerDetail.h"
#import "StrengScorePlayerTopCell.h"
#import "StrengScorePlayerSecondCell.h"
#import "StrengScorePlayerThirdCell.h"
#import "StrengScorePlayerFourthCell.h"
#import "StrengScorePlayerFifthCell.h"

@interface StrengthRankingPlayerController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) StrengScorePlayerDetail *playerDetail;

@end

@implementation StrengthRankingPlayerController

- (instancetype)initWithPlayerId:(NSString *)playerId role:(NSString *)role
{
    self = [super init];
    if (self) {
        self.playerId = playerId;
        self.playerRole = role;
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
                                           @"view_controller_title":@"Player Detail"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"选手详情"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"選手詳情"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    [self.tableView registerNib:[StrengScorePlayerTopCell nib] forCellReuseIdentifier:[StrengScorePlayerTopCell cellIdentifier]];
    [self.tableView registerNib:[StrengScorePlayerSecondCell nib] forCellReuseIdentifier:[StrengScorePlayerSecondCell cellIdentifier]];
    [self.tableView registerNib:[StrengScorePlayerThirdCell nib] forCellReuseIdentifier:[StrengScorePlayerThirdCell cellIdentifier]];
    [self.tableView registerNib:[StrengScorePlayerFourthCell nib] forCellReuseIdentifier:[StrengScorePlayerFourthCell cellIdentifier]];
    [self.tableView registerNib:[StrengScorePlayerFifthCell nib] forCellReuseIdentifier:[StrengScorePlayerFifthCell cellIdentifier]];
    
    UIView *tableViewFooterView = [[UIView alloc] init];
    tableViewFooterView.backgroundColor = self.view.backgroundColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    
}

- (void)loadData
{
    if (!self.playerId || !self.playerRole) return;
    
    WEAK_SELF;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpSessionManager sharedInstance] requestStrengthScorePlayerDetailWithPlayerId:self.playerId
                                                                         playerRoleId:self.playerRole                                                                                block:^(id dic, NSError *error) {
                                                                                    STRONG_SELF;
                                                                                    
                                                                                    if (!error) {
                                                                                        
                                                                                        strongSelf.playerDetail = [[StrengScorePlayerDetail alloc] initWithDictionary:dic error:nil];
                                                                                        
                                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                                            [strongSelf.tableView reloadData];
                                                                                        });
                                                                                        
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [StrengScorePlayerTopCell cellHeight];
    }else if (indexPath.row == 1) {
        return [StrengScorePlayerSecondCell cellHeight];
    }else if (indexPath.row == 2) {
        return [StrengScorePlayerThirdCell cellHeightWithPlayerDetail:self.playerDetail];
    }else if (indexPath.row == 3) {
        return [StrengScorePlayerFourthCell cellHeight];
    }else if (indexPath.row == 4) {
        return [StrengScorePlayerFifthCell cellHeight];
    }
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = self.view.backgroundColor;
    return view;
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
    NSInteger count = 5;
    
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        StrengScorePlayerTopCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScorePlayerTopCell cellIdentifier]
                                                                       forIndexPath:indexPath];
        cell.playerDetail = self.playerDetail;
        return cell;
    }else if (indexPath.row == 1) {
        StrengScorePlayerSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScorePlayerSecondCell cellIdentifier]
                                                                          forIndexPath:indexPath];
        cell.playerDetail = self.playerDetail;
        return cell;
    }else if (indexPath.row == 2) {
        StrengScorePlayerThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScorePlayerThirdCell cellIdentifier]
                                                                         forIndexPath:indexPath];
        cell.playerDetail = self.playerDetail;
        return cell;
    }else if (indexPath.row == 3) {
        StrengScorePlayerFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScorePlayerFourthCell cellIdentifier]
                                                                          forIndexPath:indexPath];
        cell.playerDetail = self.playerDetail;
        return cell;
    }else if (indexPath.row == 4) {
        StrengScorePlayerFifthCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScorePlayerFifthCell cellIdentifier]
                                                                         forIndexPath:indexPath];
        cell.playerDetail = self.playerDetail;
        return cell;
    }
    return nil;
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
