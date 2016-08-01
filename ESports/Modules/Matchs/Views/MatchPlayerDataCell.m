//
//  MatchPlayerDataCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchPlayerDataCell.h"
#import "UIImageView+WebCache.h"

@interface MatchPlayerDataCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconiImageView;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *kdaLabel;
@property (weak, nonatomic) IBOutlet UILabel *killCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *carryLabel;
@property (weak, nonatomic) IBOutlet UILabel *trollLabel;
@property (weak, nonatomic) IBOutlet UILabel *kdaValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *killCountVauleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *carryImageView;
@property (weak, nonatomic) IBOutlet UIImageView *trollImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kdaLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *killCountLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carryLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trollLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kdaValueLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *killCountvalueLabelWidthConstraint;
@end

@implementation MatchPlayerDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.roleLabel.textColor = HexColor(0xffffff);
    self.teamNameLabel.textColor = HexColor(0xffffff);
    
    CGFloat backViewWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 74.0f;
    CGFloat labelWidth = (backViewWidth- 8.0f)/4;
    
    [self justLabelWidthConstraint:self.kdaLabelWidthConstraint label:self.kdaLabel width:labelWidth];
    [self justLabelWidthConstraint:self.killCountLabelWidthConstraint label:self.killCountLabel width:labelWidth];
    [self justLabelWidthConstraint:self.carryLabelWidthConstraint label:self.carryLabel width:labelWidth];
    [self justLabelWidthConstraint:self.trollLabelWidthConstraint label:self.trollLabel width:labelWidth];
    [self justLabelWidthConstraint:self.kdaValueLabelWidthConstraint label:self.kdaValueLabel width:labelWidth];
    [self justLabelWidthConstraint:self.killCountvalueLabelWidthConstraint label:self.killCountVauleLabel width:labelWidth];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"kda_title":@"KDA",
                                           @"kill_count_title":@"Bans",
                                           @"carry_title":@"Carry",
                                           @"troll_title":@"Troll"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"kda_title":@"KDA",
                                           @"kill_count_title":@"Fifteen minute fill knife",
                                           @"carry_title":@"Carry",
                                           @"troll_title":@"Troll"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"kda_title":@"KDA",
                                           @"kill_count_title":@"十五分鐘補刀",
                                           @"carry_title":@"Carry",
                                           @"troll_title":@"Troll"
                                           }
                                   };
    
    self.kdaLabel.text = LTZLocalizedString(@"kda_title", nil);
    self.killCountLabel.text = LTZLocalizedString(@"kill_count_title", nil);
    self.carryLabel.text = LTZLocalizedString(@"carry_title", nil);
    self.trollLabel.text = LTZLocalizedString(@"troll_title", nil);
    
    self.carryImageView.image = [UIImage imageNamed:@""];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIsBlueTeam:(BOOL)isBlueTeam
{
    _isBlueTeam = isBlueTeam;
    
    UIColor *blueTeamColor = HexColor(0x367bd2);
    UIColor *redTeamColor = HexColor(0xdd222b);
    
    UIColor *currentColor = _isBlueTeam ? blueTeamColor:redTeamColor;

    self.playerNameLabel.textColor = currentColor;
    self.kdaLabel.textColor = currentColor;
    self.kdaValueLabel.textColor = currentColor;
    self.killCountLabel.textColor = currentColor;
    self.killCountVauleLabel.textColor = currentColor;
    self.carryLabel.textColor = currentColor;
    self.trollLabel.textColor = currentColor;
    
}

- (void)setTeamName:(NSString *)teamName
{
    _teamName = teamName;
    
    self.teamNameLabel.text = _teamName;
}

- (void)setMatchPlayerDetailData:(MatchPlayerDetailData *)matchPlayerDetailData
{
    _matchPlayerDetailData = matchPlayerDetailData;
    
    [self setNeedsLayout];
}

- (void)justLabelWidthConstraint:(NSLayoutConstraint *)labelWidthConstraint label:(UILabel *)label width:(CGFloat)width
{
    labelWidthConstraint.constant = width;
    [label setNeedsUpdateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconiImageView sd_setImageWithURL:[NSURL URLWithString:self.matchPlayerDetailData.playerImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.roleLabel.text = self.matchPlayerDetailData.playerRole;
    self.playerNameLabel.text = self.matchPlayerDetailData.playerName;
    self.kdaValueLabel.text = self.matchPlayerDetailData.kda;
    self.killCountVauleLabel.text = self.matchPlayerDetailData.cs15Min;
    
    self.
    
}

- (void)languageDidChanged
{
    self.kdaLabel.text = LTZLocalizedString(@"kda_title", nil);
    self.killCountLabel.text = LTZLocalizedString(@"kill_count_title", nil);
    self.carryLabel.text = LTZLocalizedString(@"carry_title", nil);
    self.trollLabel.text = LTZLocalizedString(@"troll_title", nil);
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchPlayerDataCell class])
                          bundle:[NSBundle bundleForClass:[MatchPlayerDataCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchPlayerDataCell class]);
}

+ (CGFloat)cellHeight
{
    return 105;
}


@end
