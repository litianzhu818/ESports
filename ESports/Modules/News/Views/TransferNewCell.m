//
//  TransferNewCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/15.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "TransferNewCell.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@interface TransferNewCell ()

@property (weak, nonatomic) IBOutlet UIButton *userIconButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fromTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *fromTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *toTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *toTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;

@property (weak, nonatomic) IBOutlet UIImageView *centerLineImageView;

@end

@implementation TransferNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.fromLabel.layer.cornerRadius = 2.0f;
    self.fromLabel.clipsToBounds = YES;
    self.fromLabel.backgroundColor = HexColor(0x000000);
    
    self.toLabel.layer.cornerRadius = 2.0f;
    self.toLabel.clipsToBounds = YES;
    self.toLabel.backgroundColor = HexColor(0x000000);

    
    self.nameLabel.textColor = HexColor(0x69d5fb);
    
    self.fromTeamNameLabel.textColor = HexColor(0xc5c7c6);
    self.toTeamNameLabel.textColor = HexColor(0xc5c7c6);
    
    self.centerLineImageView.backgroundColor = HexColor(0x192d45);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"toTag":@"Join",
                                           @"fromTag":@"Leave",
                                           @"noTeamTitle":@"no team"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"toTag":@"转入",
                                           @"fromTag":@"离开",
                                           @"noTeamTitle":@"没有队伍"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"toTag":@"轉入",
                                           @"fromTag":@"離開",
                                           @"noTeamTitle":@"沒有隊伍"
                                           }
                                   };
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 4);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, HexColor(0x16212f).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height-2.0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-2.0);   //终点坐标
    CGContextStrokePath(context);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTransferNew:(TransferNew *)transferNew
{
    _transferNew = transferNew;
    
    [self setNeedsLayout];
}

- (void)languageDidChanged
{
    [self setNeedsLayout];
}

- (IBAction)tapOnPlayerIconAction:(id)sender
{
    if (self.tapOnPlayerIconBlock) {
        self.tapOnPlayerIconBlock(self.transferNew.playerId, self.transferNew.roleId);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.userIconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:self.transferNew.playerImageUrl]
                                             forState:UIControlStateNormal
                                     placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    
//    NSString *currentLanguage = [LTZLocalizationManager language];
//    NSString *displayName = nil;
//    if ([currentLanguage isEqualToString:SYS_LANGUAGE_ENGLISH]) {
//        displayName = self.transferNew.roleNameEn;
//    }else if ([currentLanguage isEqualToString:SYS_LANGUAGE_S_CHINESE]){
//        displayName = self.transferNew.roleNameCn;
//    }else if ([currentLanguage isEqualToString:SYS_LANGUAGE_S_CHINESE]){
//        displayName = self.transferNew.roleNameTw;
//    }else{
//        displayName = self.transferNew.roleName;
//    }
//    
//    self.positionLabel.text =  displayName;
    self.nameLabel.text = self.transferNew.playerName;
    
    if (self.transferNew.fromTeamName && self.transferNew.joinTeamName) {
        [self.toTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.transferNew.fromTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
        self.toTeamNameLabel.text = self.transferNew.fromTeamName;
        self.toLabel.text = LTZLocalizedString(@"fromTag", nil);
        self.toLabel.textColor = HexColor(0x9c0100);
        
        [self.fromTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.transferNew.joinTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
        self.fromTeamNameLabel.text = self.transferNew.joinTeamName;
        self.fromLabel.text = LTZLocalizedString(@"toTag", nil);
        self.fromLabel.textColor = HexColor(0x00ae00);
        
        self.centerLineImageView.hidden = NO;
        self.fromTeamImageView.hidden = NO;
        self.fromTeamNameLabel.hidden = NO;
        self.fromLabel.hidden = NO;
        
    }else if (self.transferNew.fromTeamName && !self.transferNew.joinTeamName) {
        [self.toTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.transferNew.fromTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
        self.toTeamNameLabel.text = self.transferNew.fromTeamName;
        self.toLabel.text = LTZLocalizedString(@"fromTag", nil);
        self.toLabel.textColor = HexColor(0x9c0100);
        
        self.centerLineImageView.hidden = YES;
        self.fromTeamImageView.hidden = YES;
        self.fromTeamNameLabel.hidden = YES;
        self.fromLabel.hidden = YES;
        
    }else if (!self.transferNew.fromTeamName && self.transferNew.joinTeamName) {
        [self.toTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.transferNew.joinTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
        self.toTeamNameLabel.text = self.transferNew.joinTeamName;
        self.toLabel.text = LTZLocalizedString(@"toTag", nil);
        self.toLabel.textColor = HexColor(0x00ae00);
        
        self.centerLineImageView.hidden = YES;
        self.fromTeamImageView.hidden = YES;
        self.fromTeamNameLabel.hidden = YES;
        self.fromLabel.hidden = YES;
    }
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([TransferNewCell class])
                          bundle:[NSBundle bundleForClass:[TransferNewCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([TransferNewCell class]);
}

+ (CGFloat)cellHeightWithTransferNew:(TransferNew *)transferNew
{
    if (transferNew.joinTeamName && transferNew.fromTeamName) {
        return 108;
    }
    return 73;
}

@end
