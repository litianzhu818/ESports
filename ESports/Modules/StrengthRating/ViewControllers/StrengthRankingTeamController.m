//
//  StrengthRankingTeamController.m
//  ESports
//
//  Created by Peter Lee on 16/8/10.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengthRankingTeamController.h"
#import "HttpSessionManager.h"
#import "MBProgressHUD.h"
#import "StrengScoreTeamDetail.h"
#import "StrengScoreTeamTopCell.h"
#import "StrengScoreTeamSecondCell.h"
#import "StrengScoreTeamThirdCell.h"
#import "StrengScoreTeamFourthCell.h"
#import "StrengScoreTeamFifthCell.h"

@interface StrengthRankingTeamController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) StrengScoreTeamDetail *teamDetail;

@end

@implementation StrengthRankingTeamController

- (instancetype)initWithTeamId:(NSString *)teamId
{
    self = [super init];
    if (self) {
        self.teamId = teamId;
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
                                           @"view_controller_title":@"Detail"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"详情"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"詳情"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    [self.tableView registerNib:[StrengScoreTeamTopCell nib] forCellReuseIdentifier:[StrengScoreTeamTopCell cellIdentifier]];
    [self.tableView registerNib:[StrengScoreTeamSecondCell nib] forCellReuseIdentifier:[StrengScoreTeamSecondCell cellIdentifier]];
    [self.tableView registerNib:[StrengScoreTeamThirdCell nib] forCellReuseIdentifier:[StrengScoreTeamThirdCell cellIdentifier]];
    [self.tableView registerNib:[StrengScoreTeamFourthCell nib] forCellReuseIdentifier:[StrengScoreTeamFourthCell cellIdentifier]];
    [self.tableView registerNib:[StrengScoreTeamFifthCell nib] forCellReuseIdentifier:[StrengScoreTeamFifthCell cellIdentifier]];
    
    UIView *tableViewFooterView = [[UIView alloc] init];
    tableViewFooterView.backgroundColor = self.view.backgroundColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    
}

- (void)loadData
{
    if (!self.teamId) return;
    
    WEAK_SELF;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpSessionManager sharedInstance] requestStrengthScoreTeamDetailWithTeamId:self.teamId
                                                           block:^(NSDictionary *dic, NSError *error) {
                                                               
                                                               STRONG_SELF;
                                                               
                                                               if (!error) {
                                                                   
                                                                   strongSelf.teamDetail = [[StrengScoreTeamDetail alloc] initWithDictionary:dic error:nil];
                                                                   
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
        return [StrengScoreTeamTopCell cellHeight];
    }else if (indexPath.row == 1) {
        return [StrengScoreTeamSecondCell cellHeight];
    }else if (indexPath.row == 2) {
        return [StrengScoreTeamThirdCell cellHeight];
    }else if (indexPath.row == 3) {
        return [StrengScoreTeamFourthCell cellHeight];
    }else if (indexPath.row == 4) {
        return [StrengScoreTeamFifthCell cellHeight];
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
        StrengScoreTeamTopCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScoreTeamTopCell cellIdentifier]
                                                                  forIndexPath:indexPath];
        cell.teamDetail = self.teamDetail;
        return cell;
    }else if (indexPath.row == 1) {
        StrengScoreTeamSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScoreTeamSecondCell cellIdentifier]
                                                                     forIndexPath:indexPath];
        cell.teamDetail = self.teamDetail;
        return cell;
    }else if (indexPath.row == 2) {
        StrengScoreTeamThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScoreTeamThirdCell cellIdentifier]
                                                                          forIndexPath:indexPath];
        cell.players = self.teamDetail.teamPlayers;
        return cell;
    }else if (indexPath.row == 3) {
        StrengScoreTeamFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScoreTeamFourthCell cellIdentifier]
                                                                         forIndexPath:indexPath];
        cell.teamDetail = self.teamDetail;
        return cell;
    }else if (indexPath.row == 4) {
        StrengScoreTeamFifthCell *cell = [tableView dequeueReusableCellWithIdentifier:[StrengScoreTeamFifthCell cellIdentifier]
                                                                          forIndexPath:indexPath];
        cell.teamDetail = self.teamDetail;
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
