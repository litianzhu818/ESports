//
//  MatchTeamDataCenterCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/28.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchTeamDataCenterCell.h"

@interface MatchTeamDataCenterCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *blueTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *redTeamNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *blueTowerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *towerLabel;
@property (weak, nonatomic) IBOutlet UILabel *redTowerScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blueTowerImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueTowerImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *redTowerImageView;

@property (weak, nonatomic) IBOutlet UILabel *blueDragonScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *dragonLabel;
@property (weak, nonatomic) IBOutlet UILabel *redDragonScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blueDragonImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueDragonImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *redDragonImageView;


@property (weak, nonatomic) IBOutlet UILabel *blueGoldDiffScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldDiffLabel;
@property (weak, nonatomic) IBOutlet UILabel *redGoldDiffScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blueGoldDiffImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueGoldDiffImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *redGoldDiffImageView;


@property (weak, nonatomic) IBOutlet UILabel *blueKillScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *killLabel;
@property (weak, nonatomic) IBOutlet UILabel *redKillScoreLabel;

@property (weak, nonatomic) IBOutlet UIImageView *blueKillImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueKillImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *redKillImageView;

@end

@implementation MatchTeamDataCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UIColor *blueColor = HexColor(0x245fa9);
    UIColor *redColor = HexColor(0x245fa9);
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.blueTeamNameLabel.textColor = blueColor;
    self.redTeamNameLabel.textColor = redColor;
    
    self.blueTowerScoreLabel.textColor = HexColor(0xffffff);
    self.redTowerScoreLabel.textColor = HexColor(0xffffff);
    self.towerLabel.textColor = HexColor(0xa7a8ab);
    self.blueTowerImageView.backgroundColor = blueColor;
    self.redTowerImageView.backgroundColor = redColor;
    
    self.blueDragonScoreLabel.textColor = HexColor(0xffffff);
    self.redDragonScoreLabel.textColor = HexColor(0xffffff);
    self.dragonLabel.textColor = HexColor(0xa7a8ab);
    self.blueDragonImageView.backgroundColor = blueColor;
    self.redDragonImageView.backgroundColor = redColor;
    
    self.blueGoldDiffScoreLabel.textColor = HexColor(0xffffff);
    self.redGoldDiffScoreLabel.textColor = HexColor(0xffffff);
    self.goldDiffLabel.textColor = HexColor(0xa7a8ab);
    self.blueGoldDiffImageView.backgroundColor = blueColor;
    self.redGoldDiffImageView.backgroundColor = redColor;
    
    self.blueKillScoreLabel.textColor = HexColor(0xffffff);
    self.redKillScoreLabel.textColor = HexColor(0xffffff);
    self.killLabel.textColor = HexColor(0xa7a8ab);
    self.blueKillImageView.backgroundColor = blueColor;
    self.redKillImageView.backgroundColor = redColor;
    
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"notice_title":@"team data statistics",
                                           @"tower_title":@"Number of towers in 20 minutes",
                                           @"dragon_title":@"Number of dragons in 20 minutes",
                                           @"goldDiff_title":@"Economic difference in 25 minutes",
                                           @"kill_title":@"Total game kill"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"notice_title":@"队伍数据统计",
                                           @"tower_title":@"20分钟塔数",
                                           @"dragon_title":@"20分钟小龙",
                                           @"goldDiff_title":@"25分钟经济差",
                                           @"kill_title":@"比赛总杀数"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"notice_title":@"隊伍數據統計",
                                           @"tower_title":@"20分鐘塔數",
                                           @"dragon_title":@"20分鐘小龍",
                                           @"goldDiff_title":@"25分鐘經濟差",
                                           @"kill_title":@"比賽總殺數"
                                           }
                                   };
    
    self.titleLabel.text = LTZLocalizedString(@"notice_title", nil);
    self.towerLabel.text = LTZLocalizedString(@"tower_title", nil);
    self.dragonLabel.text = LTZLocalizedString(@"dragon_title", nil);
    self.goldDiffLabel.text = LTZLocalizedString(@"goldDiff_title", nil);
    self.killLabel.text = LTZLocalizedString(@"kill_title", nil);
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
    CGContextSetStrokeColorWithColor(context, HexColor(0x414952).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    
    // 上顶线
    CGContextMoveToPoint(context, 0, 33.0f);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, 33.0f);   //终点坐标
    
    // 下顶线
    CGContextMoveToPoint(context, 0, 63.0f);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, 63.0f);   //终点坐标
    
    // 中间线
    CGContextMoveToPoint(context, rect.size.width*0.5, 33.0f);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width*0.5, 63.0f);   //终点坐标
    
    
    CGContextStrokePath(context);
}

- (void)setBlueTeamName:(NSString *)blueTeamName
{
    _blueTeamName = blueTeamName;
    
    self.blueTeamNameLabel.text = _blueTeamName;
}

- (void)setRedTeamName:(NSString *)redTeamName
{
    _redTeamName = redTeamName;
    
    self.redTeamNameLabel.text = _redTeamName;
}

- (void)setMatchTeamData:(MatchTeamData *)matchTeamData
{
    _matchTeamData = matchTeamData;
    
    self.blueTowerScoreLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)_matchTeamData.blueTeamGameData.tower20];
    self.blueDragonScoreLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)_matchTeamData.blueTeamGameData.dragon20];
    self.blueGoldDiffScoreLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)_matchTeamData.blueTeamGameData.goldDiffAt25];
    self.blueKillScoreLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)_matchTeamData.blueTeamGameData.kill];
    
    self.redTowerScoreLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)_matchTeamData.redTeamGameData.tower20];
    self.redDragonScoreLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)_matchTeamData.redTeamGameData.dragon20];
    self.redGoldDiffScoreLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)_matchTeamData.redTeamGameData.goldDiffAt25];
    self.redKillScoreLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)_matchTeamData.redTeamGameData.kill];
    
    [self justWidthConstraintWithImageView:self.blueTowerImageView
                           widthConstraint:self.blueTowerImageViewWidthConstraint
                                 blueScore:_matchTeamData.blueTeamGameData.tower20
                                  redScore:_matchTeamData.redTeamGameData.tower20];
    
    [self justWidthConstraintWithImageView:self.blueDragonImageView
                           widthConstraint:self.blueDragonImageViewWidthConstraint
                                 blueScore:_matchTeamData.blueTeamGameData.dragon20
                                  redScore:_matchTeamData.redTeamGameData.dragon20];
    
//    [self justWidthConstraintWithImageView:self.blueGoldDiffImageView
//                           widthConstraint:self.blueGoldDiffImageViewWidthConstraint
//                                 blueScore:_matchTeamData.blueTeamGameData.goldDiffAt25
//                                  redScore:_matchTeamData.redTeamGameData.goldDiffAt25];
    
    [self justWidthConstraintWithImageView:self.blueGoldDiffImageView
                           widthConstraint:self.blueGoldDiffImageViewWidthConstraint
                                 blueScore:_matchTeamData.blueTeamGameData.tower20
                                  redScore:_matchTeamData.redTeamGameData.tower20];

    
//    [self justWidthConstraintWithImageView:self.blueKillImageView
//                           widthConstraint:self.blueKillImageViewWidthConstraint
//                                 blueScore:_matchTeamData.blueTeamGameData.kill
//                                  redScore:_matchTeamData.redTeamGameData.kill];
    [self justWidthConstraintWithImageView:self.blueKillImageView
                           widthConstraint:self.blueKillImageViewWidthConstraint
                                 blueScore:_matchTeamData.blueTeamGameData.dragon20
                                  redScore:_matchTeamData.blueTeamGameData.dragon20];
    
    
}

- (void)languageDidChanged
{
    self.titleLabel.text = LTZLocalizedString(@"notice_title", nil);
    self.towerLabel.text = LTZLocalizedString(@"tower_title", nil);
    self.dragonLabel.text = LTZLocalizedString(@"dragon_title", nil);
    self.goldDiffLabel.text = LTZLocalizedString(@"goldDiff_title", nil);
    self.killLabel.text = LTZLocalizedString(@"kill_title", nil);
}

- (void)justWidthConstraintWithImageView:(UIImageView *)imageView
                         widthConstraint:(NSLayoutConstraint *)widthConstraint
                               blueScore:(NSInteger)blueScore
                                redScore:(NSInteger)redScore
{
    CGFloat totalWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8.0*3;
    NSInteger totalScore = blueScore+redScore;
    
    CGFloat blueWidth = totalWidth *((CGFloat)blueScore/(CGFloat)totalScore);
    
    widthConstraint.constant = blueWidth;
    [imageView setNeedsLayout];
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchTeamDataCenterCell class])
                          bundle:[NSBundle bundleForClass:[MatchTeamDataCenterCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchTeamDataCenterCell class]);
}

+ (CGFloat)cellHeight
{
    return 246.0f;;
}


@end
