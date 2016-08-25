//
//  VerificationEmailController.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "VerificationEmailController.h"
#import "EmailRegisterCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "NSObject+Custom.h"
#import "HttpSessionManager.h"
#import "RegosterController.h"
#import "MBProgressHUD.h"
#import "NSString+Common.h"
#import "EmailRegisterController.h"

@interface VerificationEmailController ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;
@property (strong, nonatomic) NSString *email;

@end

@implementation VerificationEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.backImageView.clipsToBounds = YES;
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"view_controller_title":@"Register",
                                           @"no_email_tile":@"Please input your email",
                                           @"email_formart_error_title":@"Email format error",
                                           @"email_no_use_title":@"This email has been registered！"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"注册",
                                           @"no_email_tile":@"请填写邮箱",
                                           @"email_formart_error_title":@"邮箱格式错误",
                                           @"email_no_use_title":@"该邮箱已经被注册！"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"註冊",
                                           @"no_email_tile":@"請填寫郵箱",
                                           @"email_formart_error_title":@"郵箱格式錯誤",
                                           @"email_no_use_title":@"該郵箱已經被註冊！"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    self.backImageView.clipsToBounds = YES;
    [self.tableView registerNib:[EmailRegisterCell nib] forCellReuseIdentifier:[EmailRegisterCell cellIdentifier]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)loginAction
{
    if (!(self.email.length > 1)) {
        [self showHudMessage:LTZLocalizedString(@"no_email_tile", nil)];
        return;
    }
    
    // 以后可能是手机登录
    
    if (![self.email emailAddressString]) {
        [self showHudMessage:LTZLocalizedString(@"email_formart_error_title", nil)];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WEAK_SELF;
    [[HttpSessionManager sharedInstance] checkEmailWithEmail:self.email
                                                       block:^(id data, NSError *error) {
                                                           STRONG_SELF;
                                                           
                                                           if (!error) {
                                                               EmailRegisterController *emailRegisterController = [[EmailRegisterController alloc] initWithEmail:strongSelf.email];
                                                               [strongSelf.navigationController pushViewController:emailRegisterController animated:YES];
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
    return [EmailRegisterCell cellHeight];
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
    EmailRegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:[EmailRegisterCell cellIdentifier]
                                                              forIndexPath:indexPath];

    WEAK_SELF;
    [cell setEmailTextChangedBlock:^(NSString *email) {
        weakSelf.email = email;
    }];
    
    [cell setEmailRegisterAction:^{
        [weakSelf loginAction];
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
