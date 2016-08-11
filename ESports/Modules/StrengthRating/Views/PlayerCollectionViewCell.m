//
//  CollectionViewCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/11.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "PlayerCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface PlayerCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerImageViewHeightConstraint;

@end

@implementation PlayerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = HexColor(0x0e1720);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds])/5;
    
    self.playerImageViewWidthConstraint.constant = width-2*8;
    self.playerImageViewHeightConstraint.constant = width-2*8;
    [self.playerImageView setNeedsUpdateConstraints];
}

- (void)setPlayer:(StrengScoreTeamPlayer *)player
{
    _player = player;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.playerImageView sd_setImageWithURL:[NSURL URLWithString:self.player.playerImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.playerNameLabel.text = self.player.playerName;
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([PlayerCollectionViewCell class])
                          bundle:[NSBundle bundleForClass:[PlayerCollectionViewCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([PlayerCollectionViewCell class]);
}

+ (CGSize)cellSize
{
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds])/5;
    
    return CGSizeMake(width, width+21.0f+8.0f);
}


@end
