//
//  FindEmailPwdSuccesController.m
//  ESports
//
//  Created by Peter Lee on 16/8/26.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "FindEmailPwdSuccesController.h"

@interface FindEmailPwdSuccesController ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation FindEmailPwdSuccesController

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
    self.label1.textColor = HexColor(0x64dbff);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"view_controller_title":@"Find Password",
                                           @"top_tile":@"Send email success.",
                                           @"bottom_tile":@"Check your email inbox.",
                                           @"login_button_title":@"Back To Login"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"找回密码",
                                           @"top_tile":@"邮件发送成功！",
                                           @"bottom_tile":@"请到邮箱中查收重置密码邮件。",
                                           @"login_button_title":@"返回登录"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"找回密碼",
                                           @"top_tile":@"郵件發送成功！",
                                           @"bottom_tile":@"請到郵箱中查收重置密碼郵件。",
                                           @"login_button_title":@"返回登錄"
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
    [self.navigationController popToRootViewControllerAnimated:YES];
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
