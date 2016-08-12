//
//  StrengScoreTeamFourthCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/12.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScoreTeamFourthCell.h"

@interface StrengScoreTeamFourthCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

// 胜率
@property (weak, nonatomic) IBOutlet UIView *winRateView;
@property (weak, nonatomic) IBOutlet UILabel *winRateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *winRateValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *winRateViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *winRateViewHeightConstraint;

// 一血
@property (weak, nonatomic) IBOutlet UIView *firstBloodView;
@property (weak, nonatomic) IBOutlet UILabel *firstBloodTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstBloodValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstBloodViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstBloodViewHeightConstraint;

// 一塔
@property (weak, nonatomic) IBOutlet UIView *firstTowerView;
@property (weak, nonatomic) IBOutlet UILabel *firstTowerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstTowerValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstTowerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstTowerViewHeightConstraint;

// 一龙
@property (weak, nonatomic) IBOutlet UIView *firstDragonView;
@property (weak, nonatomic) IBOutlet UILabel *firstDragonTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstDragonValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstDragonViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstDragonViewheightConstraint;

// 首大龙
@property (weak, nonatomic) IBOutlet UIView *firstBigDragonView;
@property (weak, nonatomic) IBOutlet UILabel *firstBigDragonTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstBigDragonValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstBigDragonViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstBigDragonViewheightConstraint;

// 首先锋
@property (weak, nonatomic) IBOutlet UIView *firstVanguardView;
@property (weak, nonatomic) IBOutlet UILabel *firstVanguardTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstVanguardValueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstVanguardViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstVanguardViewheightConstraint;

@end

@implementation StrengScoreTeamFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e1720);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds])/3;
    CGFloat height = width*3/4;
    
    [self adjustWidthWidthConstraint:self.winRateViewWidthConstraint value:width forView:self.winRateView];
    [self adjustWidthWidthConstraint:self.winRateViewHeightConstraint value:height forView:self.winRateView];
    
    [self adjustWidthWidthConstraint:self.firstBloodViewWidthConstraint value:width forView:self.firstBloodView];
    [self adjustWidthWidthConstraint:self.firstBloodViewHeightConstraint value:height forView:self.firstBloodView];
    
    [self adjustWidthWidthConstraint:self.firstTowerViewWidthConstraint value:width forView:self.firstTowerView];
    [self adjustWidthWidthConstraint:self.firstTowerViewHeightConstraint value:height forView:self.firstTowerView];
    
    [self adjustWidthWidthConstraint:self.firstDragonViewWidthConstraint value:width forView:self.firstDragonView];
    [self adjustWidthWidthConstraint:self.firstDragonViewheightConstraint value:height forView:self.firstDragonView];
    
    [self adjustWidthWidthConstraint:self.firstBigDragonViewWidthConstraint value:width forView:self.firstBigDragonView];
    [self adjustWidthWidthConstraint:self.firstBigDragonViewheightConstraint value:height forView:self.firstBigDragonView];
    
    [self adjustWidthWidthConstraint:self.firstVanguardViewWidthConstraint value:width forView:self.firstVanguardView];
    [self adjustWidthWidthConstraint:self.firstVanguardViewheightConstraint value:height forView:self.firstVanguardView];
    
    self.titleLabel.textColor = HexColor(0x61d3f7);
    self.titleLabel.backgroundColor = HexColor(0x131b28);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"title":@"The last 25 game data",
                                           @"win_rate_title":@"win rate",
                                           @"first_blood_title":@"first blood",
                                           @"first_tower_title":@"first tower",
                                           @"first_dragon_title":@"first dragon",
                                           @"first_big_dragon_title":@"first big dragon",
                                           @"first_vanguard_title":@"first vanguard"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"title":@"最近25场比赛数据",
                                           @"win_rate_title":@"胜率",
                                           @"first_blood_title":@"一血",
                                           @"first_tower_title":@"一塔",
                                           @"first_dragon_title":@"一龙",
                                           @"first_big_dragon_title":@"首大龙",
                                           @"first_vanguard_title":@"首先锋"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"title":@"最近25場比賽數據",
                                           @"win_rate_title":@"勝率",
                                           @"first_blood_title":@"一血",
                                           @"first_tower_title":@"一塔",
                                           @"first_dragon_title":@"一龍",
                                           @"first_big_dragon_title":@"首大龍",
                                           @"first_vanguard_title":@"首先鋒"
                                           }
                                   };
    
    self.titleLabel.text = LTZLocalizedString(@"title", nil);
    self.winRateTitleLabel.text = LTZLocalizedString(@"win_rate_title", nil);
    self.firstBloodTitleLabel.text = LTZLocalizedString(@"first_blood_title", nil);
    self.firstTowerTitleLabel.text = LTZLocalizedString(@"first_tower_title", nil);
    self.firstDragonTitleLabel.text = LTZLocalizedString(@"first_dragon_title", nil);
    self.firstBigDragonTitleLabel.text = LTZLocalizedString(@"first_big_dragon_title", nil);
    self.firstVanguardTitleLabel.text = LTZLocalizedString(@"first_vanguard_title", nil);
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.winRateTitleLabel.textColor = [self colorWithRate:self.teamDetail.teamWinRate];
    self.winRateValueLabel.textColor = [self colorWithRate:self.teamDetail.teamWinRate];
    self.firstBloodTitleLabel.textColor = [self colorWithRate:self.teamDetail.teamFb];
    self.firstBloodValueLabel.textColor = [self colorWithRate:self.teamDetail.teamFb];
    self.firstTowerTitleLabel.textColor = [self colorWithRate:self.teamDetail.teamFt];
    self.firstTowerValueLabel.textColor = [self colorWithRate:self.teamDetail.teamFt];
    self.firstDragonTitleLabel.textColor = [self colorWithRate:self.teamDetail.teamFd];
    self.firstDragonValueLabel.textColor = [self colorWithRate:self.teamDetail.teamFd];
    self.firstBigDragonTitleLabel.textColor = [self colorWithRate:self.teamDetail.teamFbaron];
    self.firstBigDragonValueLabel.textColor = [self colorWithRate:self.teamDetail.teamFbaron];
    self.firstVanguardTitleLabel.textColor = [self colorWithRate:self.teamDetail.teamFh];
    self.firstVanguardValueLabel.textColor = [self colorWithRate:self.teamDetail.teamFh];
    
    self.winRateValueLabel.text = [self stringFromRate:self.teamDetail.teamWinRate];
    self.firstBloodValueLabel.text = [self stringFromRate:self.teamDetail.teamFb];
    self.firstTowerValueLabel.text = [self stringFromRate:self.teamDetail.teamFt];
    self.firstDragonValueLabel.text = [self stringFromRate:self.teamDetail.teamFd];
    self.firstBigDragonValueLabel.text = [self stringFromRate:self.teamDetail.teamFbaron];
    self.firstVanguardValueLabel.text = [self stringFromRate:self.teamDetail.teamFh];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    
    CGContextSetStrokeColorWithColor(context, HexColor(0x1f262e).CGColor);  //线的颜色
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds])/3;
    CGFloat height = width*3/4;
    
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, 0);   //终点坐标
    
    CGContextMoveToPoint(context, 0, 30);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, 30);   //终点坐标
    
    
    CGContextMoveToPoint(context, 0, 30+height);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, 30+height);   //终点坐标
    
    
    CGContextMoveToPoint(context, 0, rect.size.height);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);   //终点坐标
    
    
    CGContextMoveToPoint(context, width, 30.0);  //起点坐标
    CGContextAddLineToPoint(context, width, rect.size.height);   //终点坐标
    
    CGContextMoveToPoint(context, 2*width, 30.0);  //起点坐标
    CGContextAddLineToPoint(context, 2*width, rect.size.height);   //终点坐标
    
    CGContextStrokePath(context);
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

- (NSString *)stringFromRate:(NSInteger)rate
{
    NSString *str = [NSString stringWithFormat:@"%ld%@",(unsigned long)rate,@"%"];
    return str;
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScoreTeamFourthCell class])
                          bundle:[NSBundle bundleForClass:[StrengScoreTeamFourthCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScoreTeamFourthCell class]);
}

+ (CGFloat)cellHeight
{
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds])/3;
    CGFloat height = width*3/4;
    return 2*height+30;
}

#pragma mark - language change action
- (void)languageDidChanged
{
    self.titleLabel.text = LTZLocalizedString(@"title", nil);
    self.winRateTitleLabel.text = LTZLocalizedString(@"win_rate_title", nil);
    self.firstBloodTitleLabel.text = LTZLocalizedString(@"first_blood_title", nil);
    self.firstTowerTitleLabel.text = LTZLocalizedString(@"first_tower_title", nil);
    self.firstDragonTitleLabel.text = LTZLocalizedString(@"first_dragon_title", nil);
    self.firstBigDragonTitleLabel.text = LTZLocalizedString(@"first_big_dragon_title", nil);
    self.firstVanguardTitleLabel.text = LTZLocalizedString(@"first_vanguard_title", nil);
}

#pragma mark - tool methods
- (void)adjustWidthWidthConstraint:(NSLayoutConstraint *)widthConstraint value:(CGFloat)value forView:(UIView *)view
{
    widthConstraint.constant = value;
    [view setNeedsUpdateConstraints];
}



@end
