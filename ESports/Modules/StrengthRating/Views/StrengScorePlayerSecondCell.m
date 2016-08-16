//
//  StrengScorePlayerSecondCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/16.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScorePlayerSecondCell.h"
#import "UIImageView+WebCache.h"

@interface StrengScorePlayerSecondCell ()

@property (weak, nonatomic) IBOutlet UIView *regionView;
@property (weak, nonatomic) IBOutlet UILabel *regionTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *regionImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *regionViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *globalRankingView;
@property (weak, nonatomic) IBOutlet UILabel *globalRankingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *globalRankingValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *globalRankingViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rankingView;
@property (weak, nonatomic) IBOutlet UILabel *rankingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankingValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankingViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *matrixPriceView;
@property (weak, nonatomic) IBOutlet UILabel *matrixPriceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *matrixPriceValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *matrixPriceViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *winRateView;
@property (weak, nonatomic) IBOutlet UILabel *winRateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *winRateValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *winRateViewWidthConstraint;


@property (weak, nonatomic) IBOutlet UIView *kdaView;
@property (weak, nonatomic) IBOutlet UILabel *kdaTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *kdaValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kdaViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *offeredRateView;
@property (weak, nonatomic) IBOutlet UILabel *offeredRateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *offeredRateValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offeredRateViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *strengthView;
@property (weak, nonatomic) IBOutlet UILabel *strengthTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *strengthValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *strengthViewWidthConstraint;

@end

@implementation StrengScorePlayerSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat width = (screenWidth - 5*8)/4;
    
    [self adjustWidthWidthConstraint:self.regionViewWidthConstraint value:width forView:self.regionView];
    [self adjustWidthWidthConstraint:self.globalRankingViewWidthConstraint value:width forView:self.globalRankingView];
    [self adjustWidthWidthConstraint:self.rankingViewWidthConstraint value:width forView:self.rankingView];
    [self adjustWidthWidthConstraint:self.matrixPriceViewWidthConstraint value:width forView:self.matrixPriceView];
    [self adjustWidthWidthConstraint:self.winRateViewWidthConstraint value:width forView:self.winRateView];
    [self adjustWidthWidthConstraint:self.kdaViewWidthConstraint value:width forView:self.kdaView];
    [self adjustWidthWidthConstraint:self.offeredRateViewWidthConstraint value:width forView:self.offeredRateView];
    [self adjustWidthWidthConstraint:self.strengthViewWidthConstraint value:width forView:self.strengthView];
    
    self.regionTitleLabel.textColor = HexColor(0xb6b9be);
    self.globalRankingTitleLabel.textColor = HexColor(0xb6b9be);
    self.globalRankingValueLabel.textColor = HexColor(0xb6b9be);
    self.rankingTitleLabel.textColor = HexColor(0xb6b9be);
    self.rankingValueLabel.textColor = HexColor(0xb6b9be);
    self.matrixPriceTitleLabel.textColor = HexColor(0xb6b9be);
    self.matrixPriceValueLabel.textColor = HexColor(0xb6b9be);
    self.winRateTitleLabel.textColor = HexColor(0xb6b9be);
    self.kdaTitleLabel.textColor = HexColor(0xb6b9be);
    self.offeredRateTitleLabel.textColor = HexColor(0xb6b9be);
    self.strengthTitleLabel.textColor = HexColor(0xb6b9be);
    self.strengthValueLabel.textColor = HexColor(0xb6b9be);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"region_title":@"region",
                                           @"global_ranking_title":@"global ranking",
                                           @"ranking_title":@"ranking",
                                           @"matrix_title":@"matrix price",
                                           @"win_rate_title":@"win rate",
                                           @"kda_title":@"average KDA",
                                           @"offered_rate_title":@"offered rate",
                                           @"strength_title":@"average strength"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"region_title":@"地区",
                                           @"ranking_title":@"全球排名",
                                           @"ranking_title":@"位置排名",
                                           @"matrix_title":@"matrix价值",
                                           @"win_rate_title":@"胜率",
                                           @"kda_title":@"平均KDA",
                                           @"offered_rate_title":@"参团率",
                                           @"strength_title":@"平均实力"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"region_title":@"地区",
                                           @"ranking_title":@"全球排名",
                                           @"ranking_title":@"位置排名",
                                           @"matrix_title":@"matrix价值",
                                           @"win_rate_title":@"胜率",
                                           @"kda_title":@"平均KDA",
                                           @"offered_rate_title":@"参团率",
                                           @"strength_title":@"平均实力"
                                           }
                                   };
    
    self.regionTitleLabel.text = LTZLocalizedString(@"region_title", nil);
    self.globalRankingTitleLabel.text = LTZLocalizedString(@"global_ranking_title", nil);;
    self.rankingTitleLabel.text = LTZLocalizedString(@"ranking_title", nil);;
    self.matrixPriceTitleLabel.text = LTZLocalizedString(@"matrix_title", nil);;
    self.winRateTitleLabel.text = LTZLocalizedString(@"win_rate_title", nil);;
    self.kdaTitleLabel.text = LTZLocalizedString(@"kda_title", nil);;
    self.offeredRateTitleLabel.text = LTZLocalizedString(@"offered_rate_title", nil);;
    self.strengthTitleLabel.text = LTZLocalizedString(@"strength_title", nil);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPlayerDetail:(StrengScorePlayerDetail *)playerDetail
{
    _playerDetail = playerDetail;
    
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.regionImageView sd_setImageWithURL:[NSURL URLWithString:self.playerDetail.playerRegionImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.globalRankingValueLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)self.playerDetail.playerGlobalRanking];
    self.rankingValueLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)self.playerDetail.playerRanking];
    self.matrixPriceValueLabel.text = [self getStringFromStrength:self.playerDetail.playerPrice];
    
    
    self.winRateTitleLabel.textColor = [self colorWithRate:self.playerDetail.playerWinRate];
    self.winRateValueLabel.textColor = [self colorWithRate:self.playerDetail.playerWinRate];
    self.winRateValueLabel.text = [self stringFromRate:self.playerDetail.playerWinRate];
    
    self.kdaTitleLabel.textColor = [self colorWithKda:self.playerDetail.playerKda];
    self.kdaValueLabel.textColor = [self colorWithKda:self.playerDetail.playerKda];
    self.kdaValueLabel.text = [NSString stringWithFormat:@"%.lf",self.playerDetail.playerKda];
    
    self.offeredRateTitleLabel.textColor = [self colorWithOfferedRate:self.playerDetail.playerCarry];
    self.offeredRateValueLabel.textColor = [self colorWithOfferedRate:self.playerDetail.playerCarry];
    self.offeredRateValueLabel.text = [NSString stringWithFormat:@"%.lf",self.playerDetail.playerCarry];
    
    self.strengthValueLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)self.playerDetail.playerStrength];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    
    CGContextSetStrokeColorWithColor(context, HexColor(0x1f262e).CGColor);  //线的颜色
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds])/4;
    CGFloat height = width*3/4;
    
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, width, 0);  //起点坐标
    CGContextAddLineToPoint(context, width, rect.size.height);   //终点坐标
    
    CGContextMoveToPoint(context, width*2, 0);  //起点坐标
    CGContextAddLineToPoint(context, width*2, rect.size.height);   //终点坐标
    
    CGContextMoveToPoint(context, width*3, 0);  //起点坐标
    CGContextAddLineToPoint(context, width*3, rect.size.height);   //终点坐标
    
    
    CGContextMoveToPoint(context, 0, 76);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, 76);   //终点坐标
    
    
    CGContextMoveToPoint(context, 0, rect.size.height);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);   //终点坐标
    
    CGContextStrokePath(context);
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

- (UIColor *)colorWithRate:(NSInteger)rate
{
    UIColor *bottomColor = HexColor(0xca0000);
    UIColor *lowColor = HexColor(0xbbb200);
    UIColor *heightColor = HexColor(0x00b600);
    UIColor *topColor = HexColor(0x00ff00);
    
    if (rate >= 0 && rate <= 25) {
        return bottomColor;
    }else if (rate > 25 && rate <= 50) {
        return lowColor;
    }else if (rate > 50 && rate <= 75) {
        return heightColor;
    }else if (rate > 75) {
        return topColor;
    }
    
    return HexColor(0x878c8f);
}

- (UIColor *)colorWithKda:(CGFloat)kda
{
    UIColor *bottomColor = HexColor(0xca0000);
    UIColor *lowColor = HexColor(0xbbb200);
    UIColor *heightColor = HexColor(0x00b600);
    UIColor *topColor = HexColor(0x00ff00);
    
    if (kda >= 0 && kda <= 3) {
        return bottomColor;
    }else if (kda > 3 && kda <= 5) {
        return lowColor;
    }else if (kda > 5 && kda <= 8) {
        return heightColor;
    }else if (kda > 8) {
        return topColor;
    }
    
    return HexColor(0x878c8f);
}

- (UIColor *)colorWithOfferedRate:(CGFloat)offeredRate
{
    UIColor *bottomColor = HexColor(0xca0000);
    UIColor *lowColor = HexColor(0xbbb200);
    UIColor *heightColor = HexColor(0x00b600);
    UIColor *topColor = HexColor(0x00ff00);
    
    if ([self.playerDetail.playerRoleId isEqualToString:@"1"]) {
        if (offeredRate >= 0 && offeredRate <= 50) {
            return bottomColor;
        }else if (offeredRate > 50 && offeredRate <= 55) {
            return lowColor;
        }else if (offeredRate > 55 && offeredRate <= 60) {
            return heightColor;
        }else if (offeredRate > 60) {
            return topColor;
        }
    }else{
    
        if (offeredRate >= 0 && offeredRate <= 50) {
            return bottomColor;
        }else if (offeredRate > 50 && offeredRate <= 60) {
            return lowColor;
        }else if (offeredRate > 60 && offeredRate <= 70) {
            return heightColor;
        }else if (offeredRate > 70) {
            return topColor;
        }
    }
    return HexColor(0x878c8f);
}

- (NSString *)stringFromRate:(NSInteger)rate
{
    NSString *str = [NSString stringWithFormat:@"%ld%@",(unsigned long)rate,@"%"];
    return str;
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScorePlayerSecondCell class])
                          bundle:[NSBundle bundleForClass:[StrengScorePlayerSecondCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScorePlayerSecondCell class]);
}

+ (CGFloat)cellHeight
{
    return 152.0f;
}

#pragma mark - language change action
- (void)languageDidChanged
{
    self.regionTitleLabel.text = LTZLocalizedString(@"region_title", nil);
    self.globalRankingTitleLabel.text = LTZLocalizedString(@"global_ranking_title", nil);;
    self.rankingTitleLabel.text = LTZLocalizedString(@"ranking_title", nil);;
    self.matrixPriceTitleLabel.text = LTZLocalizedString(@"matrix_title", nil);;
    self.winRateTitleLabel.text = LTZLocalizedString(@"win_rate_title", nil);;
    self.kdaTitleLabel.text = LTZLocalizedString(@"kda_title", nil);;
    self.offeredRateTitleLabel.text = LTZLocalizedString(@"offered_rate_title", nil);;
    self.strengthTitleLabel.text = LTZLocalizedString(@"strength_title", nil);
}

#pragma mark - tool methods
- (void)adjustWidthWidthConstraint:(NSLayoutConstraint *)widthConstraint value:(CGFloat)value forView:(UIView *)view
{
    widthConstraint.constant = value;
    [view setNeedsUpdateConstraints];
}

@end
