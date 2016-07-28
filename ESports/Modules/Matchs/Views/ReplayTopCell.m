//
//  ReplayTopCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/26.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "ReplayTopCell.h"
#import "UIImageView+WebCache.h"

@interface ReplayTopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *aTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *aTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *bTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *centerLineImageView;
@property (weak, nonatomic) IBOutlet UILabel *aScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *aTeamColorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bTeamColorImageView;


@end

@implementation ReplayTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.aTeamNameLabel.textColor = HexColor(0xffffff);
    self.bTeamNameLabel.textColor = HexColor(0xffffff);
    self.centerLineImageView.backgroundColor = HexColor(0x47515d);
    self.aScoreLabel.textColor = HexColor(0xffffff);
    self.bScoreLabel.textColor = HexColor(0xfbfbfb);
    self.aTeamColorImageView.backgroundColor = HexColor(0x245fa9);
    self.bTeamColorImageView.backgroundColor = HexColor(0xca2838);
    
    self.aTeamImageView.clipsToBounds = YES;
    self.aTeamImageView.layer.cornerRadius = 20.0f;
    self.aTeamImageView.layer.borderWidth = 2.0f;
    self.aTeamImageView.layer.borderColor = HexColor(0x245fa9).CGColor;
    
    self.bTeamImageView.clipsToBounds = YES;
    self.bTeamImageView.layer.cornerRadius = 20.0f;
    self.bTeamImageView.layer.borderWidth = 2.0f;
    self.bTeamImageView.layer.borderColor = HexColor(0xdd222b).CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setResultMatch:(ResultMatch *)resultMatch
{
    _resultMatch = resultMatch;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.aTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.resultMatch.aTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    [self.bTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.resultMatch.bTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    
    self.aTeamNameLabel.text = self.resultMatch.aTeamName;
    self.bTeamNameLabel.text = self.resultMatch.bTeamName;
    
    self.aScoreLabel.text = self.resultMatch.aScore;
    self.bScoreLabel.text = self.resultMatch.bScore;
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([ReplayTopCell class])
                          bundle:[NSBundle bundleForClass:[ReplayTopCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([ReplayTopCell class]);
}

+ (CGFloat)cellHeight
{
    return 105;
}


@end
