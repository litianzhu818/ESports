//
//  StrengScoreTeamSecondCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/11.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScoreTeamSecondCell.h"
#import "UIImageView+WebCache.h"

@interface StrengScoreTeamSecondCell ()

@property (weak, nonatomic) IBOutlet UIView *regionView;
@property (weak, nonatomic) IBOutlet UILabel *regionTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *regionImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *regionViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rankingView;
@property (weak, nonatomic) IBOutlet UILabel *rankingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankingValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankingViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *strengthView;
@property (weak, nonatomic) IBOutlet UILabel *strengthTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *strengthValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *strengthViewWidthConstraint;

@end

@implementation StrengScoreTeamSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e1720);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat width = (screenWidth - 3*8)/3;
    
    [self adjustWidthWidthConstraint:self.regionViewWidthConstraint value:width forView:self.regionView];
    [self adjustWidthWidthConstraint:self.rankingViewWidthConstraint value:width forView:self.rankingView];
    [self adjustWidthWidthConstraint:self.strengthViewWidthConstraint value:width forView:self.strengthView];
    
    self.regionTitleLabel.textColor = HexColor(0xb6babb);
    self.rankingTitleLabel.textColor = HexColor(0xb6babb);
    self.rankingValueLabel.textColor = HexColor(0xb6babb);
    self.strengthTitleLabel.textColor = HexColor(0xb6babb);
    self.strengthValueLabel.textColor = HexColor(0xb6babb);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"region_title":@"region",
                                           @"ranking_title":@"global ranking",
                                           @"strength_title":@"strength score"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"region_title":@"地区",
                                           @"ranking_title":@"全球排名",
                                           @"strength_title":@"实力评分"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"region_title":@"地區",
                                           @"ranking_title":@"全球排名",
                                           @"strength_title":@"實力評分"
                                           }
                                   };
    
    self.regionTitleLabel.text = LTZLocalizedString(@"region_title", nil);
    self.rankingTitleLabel.text = LTZLocalizedString(@"ranking_title", nil);
    self.strengthTitleLabel.text = LTZLocalizedString(@"strength_title", nil);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    
    CGContextSetStrokeColorWithColor(context, HexColor(0x1e2730).CGColor);  //线的颜色
    
    CGFloat width = (CGRectGetWidth([[UIScreen mainScreen] bounds]) - 1*2)/3;
    
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, width, 0);  //起点坐标
    CGContextAddLineToPoint(context, width, rect.size.height);   //终点坐标
    
    CGContextMoveToPoint(context, 2*width+1, 0);  //起点坐标
    CGContextAddLineToPoint(context, 2*width+1, rect.size.height);   //终点坐标
    
    CGContextMoveToPoint(context, 0, rect.size.height-1);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-1);   //终点坐标
    
    CGContextStrokePath(context);
}

- (void)setTeamDetail:(StrengScoreTeamDetail *)teamDetail
{
    _teamDetail = teamDetail;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.regionImageView sd_setImageWithURL:[NSURL URLWithString:self.teamDetail.teamRegionImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.rankingValueLabel.text = self.teamDetail.teamGlobalRanking;
    self.strengthValueLabel.text = [self getStringFromStrength:self.teamDetail.teamStrength];
}

- (NSString *)getStringFromStrength:(NSInteger)strength
{
    NSString *strengthStr = nil;
    if (strength < 1000) {
        strengthStr = [NSString stringWithFormat:@"%ld",(unsigned long)strength];
    }else if (strength >= 1000 && strength < 10000) {
        strengthStr = [NSString stringWithFormat:@"%.fk",strength/1000.0f];
    }else if (strength >= 10000) {
        strengthStr = [NSString stringWithFormat:@"%.fw",strength/10000.0f];
    }
    
    return strengthStr;
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScoreTeamSecondCell class])
                          bundle:[NSBundle bundleForClass:[StrengScoreTeamSecondCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScoreTeamSecondCell class]);
}

+ (CGFloat)cellHeight
{
    return 80.0f;
}

#pragma mark - language change action
- (void)languageDidChanged
{
    self.regionTitleLabel.text = LTZLocalizedString(@"region_title", nil);
    self.rankingTitleLabel.text = LTZLocalizedString(@"ranking_title", nil);
    self.strengthTitleLabel.text = LTZLocalizedString(@"strength_title", nil);
}

#pragma mark - tool methods
- (void)adjustWidthWidthConstraint:(NSLayoutConstraint *)widthConstraint value:(CGFloat)value forView:(UIView *)view
{
    widthConstraint.constant = value;
    [view setNeedsUpdateConstraints];
}


@end
