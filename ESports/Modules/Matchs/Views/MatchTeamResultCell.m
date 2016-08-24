//
//  MatchTeamResultCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/28.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchTeamResultCell.h"
#import "UIImageView+WebCache.h"

@interface MatchTeamResultCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MatchTeamResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.borderWidth = 2.0f;
    self.imageView.layer.cornerRadius = 29.0f;
    
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)setIsBlueTeam:(BOOL)isBlueTeam
{
    _isBlueTeam = isBlueTeam;
    self.hasTeam = YES;
    if (_isBlueTeam) {
        self.imageView.layer.borderColor = HexColor(0x245fa9).CGColor;
    }else{
        self.imageView.layer.borderColor = HexColor(0x941f2a).CGColor;
    }
}

- (void)setHasTeam:(BOOL)hasTeam
{
    _hasTeam = hasTeam;
    
    if (!_hasTeam) {
        self.imageView.layer.borderColor = [UIColor clearColor].CGColor;
        self.imageView.image = [UIImage imageNamed:@"match_team_no_first_data.png"];
    }
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchTeamResultCell class])
                          bundle:[NSBundle bundleForClass:[MatchTeamResultCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchTeamResultCell class]);
}

+ (CGSize)cellSize
{
    return CGSizeMake(86, 114);
}


@end
