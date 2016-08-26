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
#import "FindPwdSelectController.h"

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
                                           @"name_error_title":@"Account does not exist",
                                           @"pwd_error_title":@"Password error",
                                           @"email_not_confirmed_title":@"You do not verify your email address, please go to verify in time",
                                           @"user_not_active_title":@"Your account is not actived",
                                           @"not_login_btn_title":@"Later do"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"登录",
                                           @"login_no_name_title":@"请输入邮箱",
                                           @"login_no_pwd_title":@"请输入密码",
                                           @"login_error_name_title":@"邮箱格式不正确",
                                           @"name_error_title":@"账户不存在",
                                           @"pwd_error_title":@"密码错误",
                                           @"email_not_confirmed_title":@"您的邮箱还没有验证，请及时验证",
                                           @"user_not_active_title":@"用户处于失活状态",
                                           @"not_login_btn_title":@"暂不登录"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"登入",
                                           @"login_no_name_title":@"請輸入郵箱",
                                           @"login_no_pwd_title":@"請輸入密碼",
                                           @"login_error_name_title":@"郵箱格式不正確",
                                           @"name_error_title":@"賬戶不存在",
                                           @"pwd_error_title":@"密碼錯誤",
                                           @"email_not_confirmed_title":@"您的郵箱還沒有驗證，請及時驗證",
                                           @"user_not_active_title":@"用戶處於失活狀態",
                                           @"not_login_btn_title":@"暫不登錄"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setBounds:CGRectMake(0, 0, 60, 30)];
    [self.closeButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.closeButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [self.closeButton setTitle:LTZLocalizedString(@"not_login_btn_title", nil) forState:UIControlStateNormal];
    [self.closeButton setTitle:LTZLocalizedString(@"not_login_btn_title", nil) forState:UIControlStateHighlighted];
    
    [self.closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
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

- (void)languageDidChanged
{
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    [self.closeButton setTitle:LTZLocalizedString(@"not_login_btn_title", nil) forState:UIControlStateNormal];
    [self.closeButton setTitle:LTZLocalizedString(@"not_login_btn_title", nil) forState:UIControlStateHighlighted];
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
                                                         [[UserConfig sharedInstance] SetHasLogin:YES];
                                                         [strongSelf closeAction:nil];
                                                         
                                                     }else{
                                                         if (error.localizedDescription) {
                                                             
                                                             if ([error.localizedDescription isEqualToString:@"UserNotExist"]) {
                                                                 [strongSelf showHudMessage:LTZLocalizedString(@"name_error_title", nil)];
                                                             }else if ([error.localizedDescription isEqualToString:@"PasswordInvalid"]) {
                                                                 [strongSelf showHudMessage:LTZLocalizedString(@"pwd_error_title", nil)];
                                                             }else if ([error.localizedDescription isEqualToString:@"EmailNotConfirmed"]) {
                                                                 
                                                                 [[UserConfig sharedInstance] SetUserName:strongSelf.loginName];
                                                                 [[UserConfig sharedInstance] SetHasLogin:YES];
                                                                 [strongSelf closeAction:nil];
                                                                 [strongSelf showHudMessage:LTZLocalizedString(@"email_not_confirmed_title", nil)];
                                                                 
                                                             }else if ([error.localizedDescription isEqualToString:@"UserNotActived"]) {
                                                                 [strongSelf showHudMessage:LTZLocalizedString(@"user_not_active_title", nil)];
                                                             }
                                                         }else{
                                                             [strongSelf showHudMessage:LTZLocalizedString(@"pwd_error_title", nil)];
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
        [weakSelf.navigationController pushViewController:[FindPwdSelectController new] animated:YES];
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
