//
//  LoginCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "LoginCell.h"

@interface LoginCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nameBottomImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *pwdImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pwdBottomImageView;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *findPwdBtn;
@property (weak, nonatomic) IBOutlet UIImageView *findPwdImageView;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *otherLoginWayTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomBackView;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *faceBookBtn;

@end

@implementation LoginCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.nameBottomImageView.backgroundColor = HexColor(0x70767d);
    self.pwdBottomImageView.backgroundColor = HexColor(0x70767d);
    self.backgroundView.backgroundColor = HexColor(0x0f1421);
    
    [self.findPwdBtn setTitleColor:HexColor(0xbabbbd) forState:UIControlStateNormal];
    [self.findPwdBtn setTitleColor:HexColor(0xbabbbd) forState:UIControlStateHighlighted];
    self.findPwdBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    self.findPwdImageView.backgroundColor = HexColor(0xbabbbd);
    
    [self.registerBtn setTitleColor:HexColor(0xbabbbd) forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:HexColor(0xbabbbd) forState:UIControlStateHighlighted];
    
    [self.loginButton setBackgroundColor:HexColor(0x286cb5)];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"login_title":@"Login",
                                           @"find_back_pwd_title":@"Find Password",
                                           @"register_title":@"Register",
                                           @"other_way_login_title":@"Using Social Account"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"login_title":@"登录",
                                           @"find_back_pwd_title":@"找回密码",
                                           @"register_title":@"注册",
                                           @"other_way_login_title":@"使用社交账号登录"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"login_title":@"登錄",
                                           @"find_back_pwd_title":@"找回密碼",
                                           @"register_title":@"註冊",
                                           @"other_way_login_title":@"使用社交賬號登錄"
                                           }
                                   };
    
    [self.loginButton setTitle:LTZLocalizedString(@"login_title", nil) forState:UIControlStateNormal];
    [self.loginButton setTitle:LTZLocalizedString(@"login_title", nil) forState:UIControlStateHighlighted];
    
    [self.findPwdBtn setTitle:LTZLocalizedString(@"find_back_pwd_title", nil) forState:UIControlStateNormal];
    [self.findPwdBtn setTitle:LTZLocalizedString(@"find_back_pwd_title", nil) forState:UIControlStateHighlighted];
    
    [self.registerBtn setTitle:LTZLocalizedString(@"register_title", nil) forState:UIControlStateNormal];
    [self.registerBtn setTitle:LTZLocalizedString(@"register_title", nil) forState:UIControlStateHighlighted];
    
    self.otherLoginWayTitleLabel.text = LTZLocalizedString(@"other_way_login_title", nil);
    
    
    [self.nameTextField addTarget:self action:@selector(nameTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextField addTarget:self action:@selector(pwdTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [self.nameTextField removeTarget:self action:@selector(nameTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextField removeTarget:self action:@selector(pwdTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)nameTextFieldDidChange:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        if (self.loginNameTextChangedBlock) {
            self.loginNameTextChangedBlock(self.nameTextField.text);
        }
    }
}

- (void)pwdTextFieldDidChange:(UITextField *)textField
{
    if (textField == self.pwdTextField) {
        if (self.loginPwdTextChangedBlock) {
            self.loginPwdTextChangedBlock(self.pwdTextField.text);
        }
    }
}

- (IBAction)loginAction:(id)sender
{
    if (self.loginActionBlock) {
        self.loginActionBlock();
    }
}

- (IBAction)findPwdAction:(id)sender
{
    if (self.findPwdActionBlock) {
        self.findPwdActionBlock();
    }
}

- (IBAction)registerAction:(id)sender
{
    if (self.registerActionBlock) {
        self.registerActionBlock();
    }
}

- (IBAction)qqLoginAction:(id)sender
{
    if (self.selectedOtherWayLoginBlock) {
        self.selectedOtherWayLoginBlock(0);
    }
}

- (IBAction)weiboLoginAction:(id)sender
{
    if (self.selectedOtherWayLoginBlock) {
        self.selectedOtherWayLoginBlock(1);
    }
}

- (IBAction)werChatLoginAction:(id)sender
{
    if (self.selectedOtherWayLoginBlock) {
        self.selectedOtherWayLoginBlock(2);
    }
}

- (IBAction)facebookLoginAction:(id)sender
{
    if (self.selectedOtherWayLoginBlock) {
        self.selectedOtherWayLoginBlock(3);
    }
}

- (void)setLoginName:(NSString *)loginName
{
    _loginName = loginName;
    
    self.nameTextField.text = loginName;
}

#pragma mark - 语言切换
- (void)languageDidChanged
{
    [self.loginButton setTitle:LTZLocalizedString(@"login_title", nil) forState:UIControlStateNormal];
    [self.loginButton setTitle:LTZLocalizedString(@"login_title", nil) forState:UIControlStateHighlighted];
    
    [self.findPwdBtn setTitle:LTZLocalizedString(@"find_back_pwd_title", nil) forState:UIControlStateNormal];
    [self.findPwdBtn setTitle:LTZLocalizedString(@"find_back_pwd_title", nil) forState:UIControlStateHighlighted];
    
    [self.registerBtn setTitle:LTZLocalizedString(@"register_title", nil) forState:UIControlStateNormal];
    [self.registerBtn setTitle:LTZLocalizedString(@"register_title", nil) forState:UIControlStateHighlighted];
    
    self.otherLoginWayTitleLabel.text = LTZLocalizedString(@"other_way_login_title", nil);
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([LoginCell class])
                          bundle:[NSBundle bundleForClass:[LoginCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([LoginCell class]);
}

+ (CGFloat)cellHeight
{
    CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    return screenHeight-64.0f;
}


@end
