//
//  StrengScoreTeamTopCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/11.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScoreTeamTopCell.h"
#import "UIImageView+WebCache.h"

@interface StrengScoreTeamTopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *teamBackImageView;
@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end

@implementation StrengScoreTeamTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.teamBackImageView.clipsToBounds = YES;
    self.teamBackImageView.image = [UIImage imageNamed:@"streng_ranking_detail_bg.png"];
    
    self.teamLogoImageView.clipsToBounds = YES;
    self.teamLogoImageView.layer.cornerRadius = 30.0f;
    self.teamLogoImageView.layer.borderWidth = 2.0;
    self.teamLogoImageView.layer.borderColor = HexColor(0x245fa9).CGColor;
    
    self.teamNameLabel.textColor = HexColor(0xffffff);
    
    self.followButton.clipsToBounds = YES;
    self.followButton.layer.cornerRadius = 4.0f;
    [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.followButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [self.followButton setBackgroundColor:HexColor(0x245fa9)];
    self.followButton.hidden = YES;
    
    /*
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"follow_btn_title":@"follow"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"follow_btn_title":@"关注"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"follow_btn_title":@"關注"
                                           }
                                   };
    [self.followButton setTitle:LTZLocalizedString(@"follow_btn_title", nil) forState:UIControlStateNormal];
    [self.followButton setTitle:LTZLocalizedString(@"follow_btn_title", nil) forState:UIControlStateHighlighted];
     */
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTeamDetail:(StrengScoreTeamDetail *)teamDetail
{
    _teamDetail = teamDetail;
    
    [self setNeedsLayout];
}

- (void)setIsFollowed:(BOOL)isFollowed
{
    _isFollowed = isFollowed;
    
    if (_isFollowed) {
        [self.followButton setBackgroundColor:[UIColor lightGrayColor]];
        self.followButton.enabled = NO;
    }else{
        [self.followButton setBackgroundColor:HexColor(0x245fa9)];
        self.followButton.enabled = YES;
    }
}

- (IBAction)folowAction:(id)sender
{
    if (self.followActionBlock) {
        self.isFollowed = YES;
        self.followActionBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.teamLogoImageView sd_setImageWithURL:[NSURL URLWithString:self.teamDetail.teamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.teamNameLabel.text = self.teamDetail.teamName;
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScoreTeamTopCell class])
                          bundle:[NSBundle bundleForClass:[StrengScoreTeamTopCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScoreTeamTopCell class]);
}

+ (CGFloat)cellHeight
{
    return 120.0f;
}

#pragma mark - language change action
- (void)languageDidChanged
{
    [self.followButton setTitle:LTZLocalizedString(@"follow_btn_title", nil) forState:UIControlStateNormal];
    [self.followButton setTitle:LTZLocalizedString(@"follow_btn_title", nil) forState:UIControlStateHighlighted];
}


@end
