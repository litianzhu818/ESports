//
//  FindPwdSelectController.m
//  ESports
//
//  Created by Peter Lee on 16/8/26.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "FindPwdSelectController.h"
#import "NSObject+Custom.h"
#import "FindEmailPwdController.h"

@interface FindPwdSelectController ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *emailRegisterBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneRegisterBtn;

@end

@implementation FindPwdSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.emailRegisterBtn setBackgroundColor:HexColor(0x286cb5)];
    [self.phoneRegisterBtn setBackgroundColor:HexColor(0x286cb5)];
    
    self.backImageView.clipsToBounds = YES;
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"view_controller_title":@"Find Password",
                                           @"email_register_btn_title":@"Email Register Way",
                                           @"phone_register_btn_title":@"Phone Register Way"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"找回密码",
                                           @"email_register_btn_title":@"邮箱注册找回",
                                           @"phone_register_btn_title":@"手机注册找回"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"找回密碼",
                                           @"email_register_btn_title":@"郵箱註冊找回",
                                           @"phone_register_btn_title":@"手機註冊找回"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    
    [self.emailRegisterBtn setTitle:LTZLocalizedString(@"email_register_btn_title", nil) forState:UIControlStateNormal];
    [self.emailRegisterBtn setTitle:LTZLocalizedString(@"email_register_btn_title", nil) forState:UIControlStateHighlighted];
    
    [self.phoneRegisterBtn setTitle:LTZLocalizedString(@"phone_register_btn_title", nil) forState:UIControlStateNormal];
    [self.phoneRegisterBtn setTitle:LTZLocalizedString(@"phone_register_btn_title", nil) forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emailRegisterAction:(id)sender
{
    [self.navigationController pushViewController:[FindEmailPwdController new] animated:YES];
}
- (IBAction)phoneRegisterAction:(id)sender
{
    [self showHudMessage:@"It's coming soon..."];
}

#pragma mark - 切换语言
- (void)languageDidChanged
{
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    [self.emailRegisterBtn setTitle:LTZLocalizedString(@"email_register_btn_title", nil) forState:UIControlStateNormal];
    [self.emailRegisterBtn setTitle:LTZLocalizedString(@"email_register_btn_title", nil) forState:UIControlStateHighlighted];
    
    [self.phoneRegisterBtn setTitle:LTZLocalizedString(@"phone_register_btn_title", nil) forState:UIControlStateNormal];
    [self.phoneRegisterBtn setTitle:LTZLocalizedString(@"phone_register_btn_title", nil) forState:UIControlStateHighlighted];
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
