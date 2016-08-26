//
//  EmailRegisterSuccessController.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "EmailRegisterSuccessController.h"
#import "AppDelegate.h"
#import "UserConfig.h"
#import "NSObject+Custom.h"
#import "HttpSessionManager.h"
#import "MBProgressHUD.h"
#import "NSString+Common.h"

@interface EmailRegisterSuccessController ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation EmailRegisterSuccessController

- (instancetype)initWithEmail:(NSString *)email pwd:(NSString *)pwd
{
    self = [super init];
    if (self) {
        self.email = email;
        self.pwd = pwd;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.backImageView.clipsToBounds = YES;
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"view_controller_title":@"Register",
                                           @"top_tile":@"Congratulations, your account registration is successful!",
                                           @"bottom_tile":@"My dear, welcome to join the LOL Martrix",
                                           @"login_button_title":@"Login immediately",
                                           @"name_error_title":@"Account does not exist",
                                           @"pwd_error_title":@"Password error",
                                           @"email_not_confirmed_title":@"You do not verify your email address, please go to verify in time",
                                           @"user_not_active_title":@"Your account is not actived"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"注册",
                                           @"top_tile":@"恭喜您，账户注册成功啦！",
                                           @"bottom_tile":@"亲爱的玩家，欢迎加入电竞魔方",
                                           @"login_button_title":@"立即登录",
                                           @"name_error_title":@"账户不存在",
                                           @"pwd_error_title":@"密码错误",
                                           @"email_not_confirmed_title":@"您的邮箱还没有验证，请及时验证",
                                           @"user_not_active_title":@"用户处于失活状态"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"註冊",
                                           @"top_tile":@"恭喜您，賬戶註冊成功啦！",
                                           @"bottom_tile":@"親愛的玩家，歡迎加入電競魔方",
                                           @"login_button_title":@"立即登錄",
                                           @"name_error_title":@"賬戶不存在",
                                           @"pwd_error_title":@"密碼錯誤",
                                           @"email_not_confirmed_title":@"您的郵箱還沒有驗證，請及時驗證",
                                           @"user_not_active_title":@"用戶處於失活狀態"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    self.label1.text = LTZLocalizedString(@"top_tile", nil);
    self.label2.text = LTZLocalizedString(@"bottom_tile", nil);
    [self.loginButton setTitle:LTZLocalizedString(@"login_button_title", nil) forState:UIControlStateNormal];
    [self.loginButton setTitle:LTZLocalizedString(@"login_button_title", nil) forState:UIControlStateHighlighted];
    
    [self.loginButton setBackgroundColor:HexColor(0x286cb5)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)languageDidChanged
{
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    self.label1.text = LTZLocalizedString(@"top_tile", nil);
    self.label2.text = LTZLocalizedString(@"bottom_tile", nil);
    [self.loginButton setTitle:LTZLocalizedString(@"login_button_title", nil) forState:UIControlStateNormal];
    [self.loginButton setTitle:LTZLocalizedString(@"login_button_title", nil) forState:UIControlStateHighlighted];

}

- (IBAction)loginAction:(id)sender
{
    [self loginActionMthod];
}

- (void)loginActionMthod
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WEAK_SELF;
    [[HttpSessionManager sharedInstance] loginWithName:self.email
                                              password:self.pwd
                                                 block:^(id data, NSError *error) {
                                                     
                                                     STRONG_SELF;
                                                     
                                                     if (!error) {
                                                         
                                                         [[UserConfig sharedInstance] SetUserName:strongSelf.email];
                                                         [[UserConfig sharedInstance] SetHasLogin:YES];
                                                         [strongSelf closeAction:nil];
                                                         
                                                     }else{
                                                         if (error.localizedDescription) {
                                                             
                                                             if ([error.localizedDescription isEqualToString:@"UserNotExist"]) {
                                                                 [strongSelf showHudMessage:LTZLocalizedString(@"name_error_title", nil)];
                                                             }else if ([error.localizedDescription isEqualToString:@"PasswordInvalid"]) {
                                                                 [strongSelf showHudMessage:LTZLocalizedString(@"pwd_error_title", nil)];
                                                             }else if ([error.localizedDescription isEqualToString:@"EmailNotConfirmed"]) {
                                                                 
                                                                 [[UserConfig sharedInstance] SetUserName:strongSelf.email];
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


- (void)closeAction:(id)sender
{
    [myAppDelegate switchToTabbarViewController];
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
