//
//  MatchPickCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchPickCell.h"
#import "UIImageView+WebCache.h"

@interface MatchPickCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MatchPickCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.borderWidth = 2.0f;
    self.imageView.layer.cornerRadius = 25.0f;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
}
- (void)setIsBlueTeam:(BOOL)isBlueTeam
{
    _isBlueTeam = isBlueTeam;
    
    if (_isBlueTeam) {
        self.imageView.layer.borderColor = HexColor(0x245fa9).CGColor;
    }else{
        self.imageView.layer.borderColor = HexColor(0x941f2a).CGColor;
    }
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchPickCell class])
                          bundle:[NSBundle bundleForClass:[MatchPickCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchPickCell class]);
}

+ (CGSize)cellSize
{
    return CGSizeMake(50, 50);
}

@end
