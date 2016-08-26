//
//  EmailRegisterController.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "EmailRegisterController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "NSObject+Custom.h"
#import "HttpSessionManager.h"
#import "RegosterController.h"
#import "MBProgressHUD.h"
#import "NSString+Common.h"
#import "InputPasswordCell.h"
#import "EmailRegisterSuccessController.h"

@interface EmailRegisterController ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@property (strong, nonatomic) NSString *pwd1;
@property (strong, nonatomic) NSString *pwd2;

@end

@implementation EmailRegisterController

- (instancetype)initWithEmail:(NSString *)email
{
    self = [super init];
    if (self) {
        self.email = email;
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
                                           @"no_pwd1_tile":@"Please input your password",
                                           @"no_pwd2_tile":@"Please input your password again",
                                           @"pwd_no_equl_pwd2_title":@"The two passwords you input are not the same!"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"注册",
                                           @"no_pwd1_tile":@"请输入密码",
                                           @"no_pwd2_tile":@"请再次输入密码",
                                           @"pwd_no_equl_pwd2_title":@"您输入的两个密码不一致，请检查后重新输入"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"註冊",
                                           @"no_pwd1_tile":@"請輸入密碼",
                                           @"no_pwd2_tile":@"請再次輸入密碼",
                                           @"pwd_no_equl_pwd2_title":@"您輸入的兩個密碼不一致，請檢查後重新輸入"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    self.backImageView.clipsToBounds = YES;
    [self.tableView registerNib:[InputPasswordCell nib] forCellReuseIdentifier:[InputPasswordCell cellIdentifier]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerAction
{
    if (!(self.pwd1.length > 1)) {
        [self showHudMessage:LTZLocalizedString(@"no_email_tile", nil)];
        return;
    }
    
    if (!(self.pwd2.length > 1)) {
        [self showHudMessage:LTZLocalizedString(@"no_email_tile", nil)];
        return;
    }
    
    // 以后可能是手机登录
    
    if (![self.pwd1 isEqualToString:self.pwd2]) {
        [self showHudMessage:LTZLocalizedString(@"pwd_no_equl_pwd2_title", nil)];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WEAK_SELF;
    [[HttpSessionManager sharedInstance] registerWithEmail:self.email
                                                  password:self.pwd1
                                           confirmPassword:self.pwd2
                                                     block:^(id data, NSError *error) {
                                                         STRONG_SELF;
                                                         
                                                         if (!error) {
                                                             
                                                             EmailRegisterSuccessController *emailRegisterSuccessController = [[EmailRegisterSuccessController alloc] initWithEmail:strongSelf.email pwd:strongSelf.pwd1];
                                                             [strongSelf.navigationController pushViewController:emailRegisterSuccessController animated:YES];
                                                         }else{
                                                             if (error.localizedDescription) {
                                                                 [strongSelf showHudMessage:error.localizedDescription];
                                                             }else{
                                                                 [strongSelf showHudMessage:LTZLocalizedString(@"email_no_use_title", nil)];
                                                             }
                                                         }
                                                         
                                                         [hud hideAnimated:YES];
                                                     }];
}

- (void)languageDidChanged
{
    self.title = LTZLocalizedString(@"view_controller_title", nil);
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [InputPasswordCell cellHeight];
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
    InputPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:[InputPasswordCell cellIdentifier]
                                                              forIndexPath:indexPath];
    
    WEAK_SELF;
    [cell setPwd1TextChangedBlock:^(NSString *pwd1) {
        weakSelf.pwd1 = pwd1;
    }];
    [cell setPwd2TextChangedBlock:^(NSString *pwd2) {
        weakSelf.pwd2 = pwd2;
    }];
    
    [cell setRegisterActionBlock:^{
        [weakSelf registerAction];
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
