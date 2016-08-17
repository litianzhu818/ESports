//
//  StrengScorePlayerFourthCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/17.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScorePlayerFourthCell.h"
#import "JYRadarChart.h"

@interface StrengScorePlayerFourthCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noDataTitleLabel;
@property (strong, nonatomic) JYRadarChart *raderChart;

@end

@implementation StrengScorePlayerFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"win_rate_title":@"personal game data",
                                           @"carry_title":@"carry rate",
                                           @"troll_title":@"Offered rate",
                                           @"kda_title":@"Averag KDA",
                                           @"win_title":@"win line rate",
                                           @"dao_title":@"fill knife 15m"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"win_rate_title":@"个人比赛数据",
                                           @"carry_title":@"carry率",
                                           @"troll_title":@"平均参团率",
                                           @"kda_title":@"平均KDA",
                                           @"win_title":@"赢线率",
                                           @"dao_title":@"15分钟补刀"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"win_rate_title":@"個人比賽數據",
                                           @"carry_title":@"carry率",
                                           @"troll_title":@"平均參團率",
                                           @"kda_title":@"平均KDA",
                                           @"win_title":@"贏線率",
                                           @"dao_title":@"15分鐘補刀"
                                           }
                                   };
    
    self.titleLabel.textColor = HexColor(0x5ed2f7);
    self.titleLabel.text = LTZLocalizedString(@"win_rate_title", nil);
    self.noDataTitleLabel.hidden = YES;
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    self.raderChart = [[JYRadarChart alloc] initWithFrame:CGRectMake(20, 40, width-20, 150)];
    self.raderChart.center = CGPointMake(width/2, 115);
    self.raderChart.steps = 10;
    self.raderChart.showStepText = NO;
    self.raderChart.backgroundColor = [UIColor clearColor];
    self.raderChart.r = 60;
    self.raderChart.minValue = 0;
    self.raderChart.maxValue = 100;
    self.raderChart.fillArea = YES;
    self.raderChart.colorOpacity = 0.7;
    self.raderChart.backgroundFillColor = [UIColor clearColor];
    self.raderChart.backgroundLineColor = HexColor(0x095f98);
    self.raderChart.showLegend = NO;
    [self.raderChart setColors:@[HexColor(0x2e5b82)]];
    [self.contentView addSubview:self.raderChart];
    self.raderChart.hidden = NO;
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
    
    CGContextSetStrokeColorWithColor(context, HexColor(0x1f262e).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 30);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, 30);   //终点坐标
    
    CGContextStrokePath(context);
}

- (void)setPlayerDetail:(StrengScorePlayerDetail *)playerDetail
{
    _playerDetail = playerDetail;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.playerDetail.playerGlobalRanking == 0) {
        self.noDataTitleLabel.hidden = NO;
        self.raderChart.hidden = YES;
    }else{
        self.noDataTitleLabel.hidden = YES;
        self.raderChart.hidden = NO;
    }
    
    CGFloat carry = self.playerDetail.playerCarry/self.playerDetail.bestStatsModel.bestCarry;
    NSInteger carryValue = 100*carry;
    NSString *carryTitle = [NSString stringWithFormat:@"%@(%.f%@)",LTZLocalizedString(@"carry_title", nil),carry*100,@"%"];
    
    CGFloat offered = self.playerDetail.playerAvgKillParticipation/self.playerDetail.bestStatsModel.bestAvgKillParticipation;
    NSInteger offeredValue = 100*offered;
    NSString *offeredTitle = [NSString stringWithFormat:@"%@(%.f%@)",LTZLocalizedString(@"troll_title", nil),offered*100,@"%"];
    
    CGFloat kda = self.playerDetail.playerKda/self.playerDetail.bestStatsModel.bestAvgKda;
    NSInteger kdaValue = 100*kda;
    NSString *kdaTitle = [NSString stringWithFormat:@"%@(%.2f)",LTZLocalizedString(@"kda_title", nil),self.playerDetail.playerKda];
    
    CGFloat win = self.playerDetail.playerLaneWin15Min / self.playerDetail.bestStatsModel.bestWinLane;
    NSInteger winValue = 100*win;
    NSString *winTitle = [NSString stringWithFormat:@"%@(%.f%@)",LTZLocalizedString(@"win_title", nil),100*win,@"%"];
    
    CGFloat fillKnife = self.playerDetail.playerCs15Min/self.playerDetail.bestStatsModel.bestCs15Min;
    NSInteger fillKnifeValue = 100*fillKnife;
    NSString *fillKnifeTitle = [NSString stringWithFormat:@"%@(%.f%@)",LTZLocalizedString(@"dao_title", nil),100*fillKnife,@"%"];
    
    
    NSArray *data = @[@(carryValue), @(fillKnifeValue), @(winValue),@(kdaValue), @(offeredValue)];
    self.raderChart.dataSeries = @[data];
    self.raderChart.attributes = @[carryTitle, fillKnifeTitle, winTitle, kdaTitle, offeredTitle];
    [self.raderChart setNeedsDisplay];
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.raderChart.center = CGPointMake(width/2, 115);
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScorePlayerFourthCell class])
                          bundle:[NSBundle bundleForClass:[StrengScorePlayerFourthCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScorePlayerFourthCell class]);
}

+ (CGFloat)cellHeight
{
    return 200;
}

#pragma mark - language change action
- (void)languageDidChanged
{
    self.titleLabel.text = LTZLocalizedString(@"win_rate_title", nil);
}


@end
