//
//  RegosterController.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "RegosterController.h"
#import "NSObject+Custom.h"
#import "VerificationEmailController.h"

@interface RegosterController ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *otherLoginWaysLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailRegisterBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneRegisterBtn;

@end

@implementation RegosterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.otherLoginWaysLabel.textColor = HexColor(0x8e8e93);
    [self.emailRegisterBtn setBackgroundColor:HexColor(0x286cb5)];
    [self.phoneRegisterBtn setBackgroundColor:HexColor(0x286cb5)];
    
    self.backImageView.clipsToBounds = YES;
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"view_controller_title":@"Register",
                                           @"other_way_login_title":@"Using Social Account",
                                           @"email_register_btn_title":@"Email Register",
                                           @"phone_register_btn_title":@"Phone Register"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"注册",
                                           @"other_way_login_title":@"使用社交账号登录",
                                           @"email_register_btn_title":@"邮箱注册",
                                           @"phone_register_btn_title":@"手机注册"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"註冊",
                                           @"other_way_login_title":@"使用社交賬號登錄",
                                           @"email_register_btn_title":@"郵箱註冊",
                                           @"phone_register_btn_title":@"手機註冊"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    self.otherLoginWaysLabel.text = LTZLocalizedString(@"other_way_login_title", nil);
    
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
    [self.navigationController pushViewController:[VerificationEmailController new] animated:YES];
}
- (IBAction)phoneRegisterAction:(id)sender
{
    [self showHudMessage:@"It's coming soon..."];
}

#pragma mark - 切换语言
- (void)languageDidChanged
{
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    self.otherLoginWaysLabel.text = LTZLocalizedString(@"other_way_login_title", nil);
    
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
