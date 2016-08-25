//
//  LoginController.m
//  ESports
//
//  Created by Peter Lee on 16/8/22.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "LoginController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "AppDelegate.h"
#import "LoginCell.h"
#import "UserConfig.h"
#import "NSObject+Custom.h"
#import "HttpSessionManager.h"
#import "RegosterController.h"
#import "MBProgressHUD.h"
#import "NSString+Common.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@property (strong, nonatomic) UIButton *closeButton;

@property (strong, nonatomic) NSString *loginName;
@property (strong, nonatomic) NSString *loginPwd;

@end

@implementation LoginController

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
                                           @"view_controller_title":@"Login",
                                           @"login_no_name_title":@"There is no email,you should input one",
                                           @"login_no_pwd_title":@"There is no password,you should input one",
                                           @"login_error_name_title":@"The email you inputed is bad format",
                                           @"name_or_pwd_error_title":@"Account does not exist or password error"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"登录",
                                           @"login_no_name_title":@"请输入邮箱",
                                           @"login_no_pwd_title":@"请输入密码",
                                           @"login_error_name_title":@"邮箱格式不正确",
                                           @"name_or_pwd_error_title":@"账户不存在或者密码错误"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"登入",
                                           @"login_no_name_title":@"請輸入郵箱",
                                           @"login_no_pwd_title":@"請輸入密碼",
                                           @"login_error_name_title":@"郵箱格式不正確",
                                           @"name_or_pwd_error_title":@"賬戶不存在或者密碼錯誤"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login_close_btn"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(closeAction:)];
    self.backImageView.clipsToBounds = YES;
    [self.tableView registerNib:[LoginCell nib] forCellReuseIdentifier:[LoginCell cellIdentifier]];
    
}

- (void)loadData
{
    self.loginName = [[UserConfig sharedInstance] GetUserName];
}

- (void)closeAction:(id)sender
{
    [myAppDelegate switchToTabbarViewController];
}

- (void)loginAction
{
    if (!(self.loginName.length > 1)) {
        [self showHudMessage:LTZLocalizedString(@"login_no_name_title", nil)];
        return;
    }
    
    if (!(self.loginPwd.length > 1)) {
        [self showHudMessage:LTZLocalizedString(@"login_no_pwd_title", nil)];
        return;
    }
    // 以后可能是手机登录
    /*
    if (![self.loginName emailAddressString]) {
        [self showHudMessage:LTZLocalizedString(@"login_error_name_title", nil)];
        return;
    }*/
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WEAK_SELF;
    [[HttpSessionManager sharedInstance] loginWithName:self.loginName
                                              password:self.loginPwd
                                                 block:^(id data, NSError *error) {
                                                     
                                                     STRONG_SELF;
                                                     
                                                     if (!error) {
                                                         
                                                         [[UserConfig sharedInstance] SetUserName:strongSelf.loginName];
                                                         //[[UserConfig sharedInstance] SetHasLogin:YES];
                                                         [strongSelf closeAction:nil];
                                                         
                                                     }else{
                                                         if (error.localizedDescription) {
                                                             [strongSelf showHudMessage:error.localizedDescription];
                                                         }else{
                                                             [strongSelf showHudMessage:LTZLocalizedString(@"name_or_pwd_error_title", nil)];
                                                         }
                                                     }
                                                     
                                                     [hud hideAnimated:YES];
                                                     
                                                 }];
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LoginCell cellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
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
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:[LoginCell cellIdentifier]
                                                      forIndexPath:indexPath];
    cell.loginName = self.loginName;
    WEAK_SELF;
    [cell setLoginNameTextChangedBlock:^(NSString *name) {
        weakSelf.loginName = name;
    }];
    
    [cell setLoginPwdTextChangedBlock:^(NSString *pwd) {
        weakSelf.loginPwd = pwd;
    }];
    
    [cell setLoginActionBlock:^{
        [weakSelf loginAction];
    }];
    
    [cell setFindPwdActionBlock:^{
        [weakSelf showHudMessage:@"It's coming soon..."];
    }];
    
    [cell setRegisterActionBlock:^{
        [weakSelf.navigationController pushViewController:[RegosterController new] animated:YES];
    }];
    
    [cell setSelectedOtherWayLoginBlock:^(NSInteger loginWay) {
        [weakSelf showHudMessage:@"It's coming soon..."];
    }];
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
