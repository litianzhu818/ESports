//
//  EmailRegisterSuccessController.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "EmailRegisterSuccessController.h"

@interface EmailRegisterSuccessController ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation EmailRegisterSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.backImageView.clipsToBounds = YES;
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"view_controller_title":@"Register",
                                           @"top_tile":@"Congratulations, your account registration is successful!",
                                           @"bottom_tile":@"My dear, welcome to join the LOL Martrix",
                                           @"login_button_title":@"Login immediately"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"注册",
                                           @"top_tile":@"恭喜您，账户注册成功啦！",
                                           @"bottom_tile":@"亲爱的玩家，欢迎加入电竞魔方",
                                           @"login_button_title":@"立即登录"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"註冊",
                                           @"top_tile":@"恭喜您，賬戶註冊成功啦！",
                                           @"bottom_tile":@"親愛的玩家，歡迎加入電競魔方",
                                           @"login_button_title":@"立即登錄"
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
