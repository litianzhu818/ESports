//
//  EmailRegisterCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "EmailRegisterCell.h"

@interface EmailRegisterCell ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIImageView *emailBottomImageView;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation EmailRegisterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.emailBottomImageView.backgroundColor = HexColor(0x70767d);
    [self.nextBtn setBackgroundColor:HexColor(0x286cb5)];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"next_btn_title":@"Next"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"next_btn_title":@"下一步"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"next_btn_title":@"下一步"
                                           }
                                   };
    
    [self.nextBtn setTitle:LTZLocalizedString(@"next_btn_title", nil) forState:UIControlStateNormal];
    [self.nextBtn setTitle:LTZLocalizedString(@"next_btn_title", nil) forState:UIControlStateHighlighted];
    [self.emailTextField addTarget:self action:@selector(emailTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [self.emailTextField removeTarget:self action:@selector(emailTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)emailTextFieldDidChange:(UITextField *)textField
{
    if (textField == self.emailTextField) {
        if (self.emailTextChangedBlock) {
            self.emailTextChangedBlock(self.emailTextField.text);
        }
    }
}

- (IBAction)nextAction:(id)sender
{
    [self.emailTextField resignFirstResponder];
    
    if (self.emailRegisterAction) {
        self.emailRegisterAction();
    }
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([EmailRegisterCell class])
                          bundle:[NSBundle bundleForClass:[EmailRegisterCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([EmailRegisterCell class]);
}

+ (CGFloat)cellHeight
{
    CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    return screenHeight-64.0f;
}

@end
