//
//  PickerCollectionViewCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/17.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "PickerCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface PickerCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *winRateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerImageViewHeightConstraint;

@end

@implementation PickerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = HexColor(0x0e1720);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.playerNameLabel.textColor = HexColor(0xb6babd);
    self.winRateLabel.textColor = HexColor(0x5fd4f7);
    //5fd4f7
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds])/5;
    
    self.playerImageViewWidthConstraint.constant = width-2*8;
    self.playerImageViewHeightConstraint.constant = width-2*8;
    [self.playerImageView setNeedsUpdateConstraints];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"win_rate_title":@"winrate:"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"win_rate_title":@"胜率:"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"win_rate_title":@"勝率:"
                                           }
                                   };
}

- (void)setPick:(StrengScorePlayerPickChampion *)pick
{
    _pick = pick;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.playerImageView sd_setImageWithURL:[NSURL URLWithString:self.pick.pickChampionImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.playerNameLabel.text = self.pick.pickChampionName;
    
    NSString *titleString = [NSString stringWithFormat:@"%@%.f%@",LTZLocalizedString(@"win_rate_title", nil),self.pick.pickChampionWinRate,@"%"];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [attributedString addAttributes:@{
                                      NSFontAttributeName:[UIFont systemFontOfSize:12.0f]
                                      }
                   range:[titleString rangeOfString:LTZLocalizedString(@"win_rate_title", nil)]];
    
    self.winRateLabel.attributedText = attributedString;
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([PickerCollectionViewCell class])
                          bundle:[NSBundle bundleForClass:[PickerCollectionViewCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([PickerCollectionViewCell class]);
}

+ (CGSize)cellSize
{
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds])/5;
    
    return CGSizeMake(width, width+21.0f+4.0f+21.0f+2.0f);
}

- (void)languageDidChanged
{
    if (!self.pick) return;
    
    NSString *titleString = [NSString stringWithFormat:@"%@%.f%@",LTZLocalizedString(@"win_rate_title", nil),self.pick.pickChampionWinRate,@"%"];
    
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [attributedString addAttributes:@{
                                      NSFontAttributeName:[UIFont systemFontOfSize:11.0f]
                                      }
                              range:[titleString rangeOfString:LTZLocalizedString(@"win_rate_title", nil)]];
    
    self.winRateLabel.attributedText = attributedString;
}


@end
