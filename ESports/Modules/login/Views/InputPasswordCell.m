//
//  InputPasswordCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "InputPasswordCell.h"

@interface InputPasswordCell ()

@property (weak, nonatomic) IBOutlet UITextField *pwd1TextField;
@property (weak, nonatomic) IBOutlet UIImageView *pwd1BottomImageView;

@property (weak, nonatomic) IBOutlet UITextField *pwd2TextField;
@property (weak, nonatomic) IBOutlet UIImageView *pwd2BottomImageView;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation InputPasswordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.pwd1BottomImageView.backgroundColor = HexColor(0x70767d);
    self.pwd2BottomImageView.backgroundColor = HexColor(0x70767d);
    [self.registerBtn setBackgroundColor:HexColor(0x286cb5)];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"next_btn_title":@"Register"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"next_btn_title":@"注册"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"next_btn_title":@"註冊"
                                           }
                                   };
    
    [self.registerBtn setTitle:LTZLocalizedString(@"next_btn_title", nil) forState:UIControlStateNormal];
    [self.registerBtn setTitle:LTZLocalizedString(@"next_btn_title", nil) forState:UIControlStateHighlighted];
    
    [self.pwd1TextField addTarget:self action:@selector(pwd1TextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd2TextField addTarget:self action:@selector(pwd2TextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [self.pwd1TextField removeTarget:self action:@selector(pwd1TextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd2TextField removeTarget:self action:@selector(pwd2TextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)pwd1TextFieldDidChange:(UITextField *)textField
{
    if (textField == self.pwd1TextField) {
        if (self.pwd1TextChangedBlock) {
            self.pwd1TextChangedBlock(self.pwd1TextField.text);
        }
    }
}

- (void)pwd2TextFieldDidChange:(UITextField *)textField
{
    if (textField == self.pwd2TextField) {
        if (self.pwd2TextChangedBlock) {
            self.pwd2TextChangedBlock(self.pwd2TextField.text);
        }
    }
}

- (IBAction)nextAction:(id)sender
{
    [self.pwd1TextField resignFirstResponder];
    [self.pwd2TextField resignFirstResponder];
    
    if (self.registerActionBlock) {
        self.registerActionBlock();
    }
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([InputPasswordCell class])
                          bundle:[NSBundle bundleForClass:[InputPasswordCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([InputPasswordCell class]);
}

+ (CGFloat)cellHeight
{
    CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    return screenHeight-64.0f;
}


@end
