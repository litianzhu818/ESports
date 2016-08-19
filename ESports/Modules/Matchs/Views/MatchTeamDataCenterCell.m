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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueTowerImageViewLeftConstraint;

@property (weak, nonatomic) IBOutlet UILabel *blueDragonScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *dragonLabel;
@property (weak, nonatomic) IBOutlet UILabel *redDragonScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blueDragonImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueDragonImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *redDragonImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueDragonImageViewLeftConstraint;


@property (weak, nonatomic) IBOutlet UILabel *blueGoldDiffScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldDiffLabel;
@property (weak, nonatomic) IBOutlet UILabel *redGoldDiffScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blueGoldDiffImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueGoldDiffImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *redGoldDiffImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueGoldDiffImageViewLeftConstraint;


@property (weak, nonatomic) IBOutlet UILabel *blueKillScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *killLabel;
@property (weak, nonatomic) IBOutlet UILabel *redKillScoreLabel;

@property (weak, nonatomic) IBOutlet UIImageView *blueKillImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueKillImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *redKillImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueKillImageViewLeftConstraint;

@end

@implementation MatchTeamDataCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UIColor *blueColor = HexColor(0x245fa9);
    UIColor *redColor = HexColor(0xdd222b);
    
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

- (void)setGameOrder:(MatchTeamGameOrder *)gameOrder
{
    _gameOrder = gameOrder;
    
    if (gameOrder.isATeamRedSide) {
        self.blueTowerScoreLabel.text = _gameOrder.teamBGameState.teamTower20;
        self.blueDragonScoreLabel.text = _gameOrder.teamBGameState.teamDragon20;
        self.blueGoldDiffScoreLabel.text = _gameOrder.teamBGameState.teamGoldDiffAt25;
        self.blueKillScoreLabel.text = _gameOrder.teamBGameState.teamKill;
        
        self.redTowerScoreLabel.text = _gameOrder.teamAGameState.teamTower20;
        self.redDragonScoreLabel.text = _gameOrder.teamAGameState.teamDragon20;
        self.redGoldDiffScoreLabel.text = _gameOrder.teamAGameState.teamGoldDiffAt25;
        self.redKillScoreLabel.text = _gameOrder.teamAGameState.teamKill;
        
        
        [self justWidthConstraintWithImageView:self.blueTowerImageView
                               widthConstraint:self.blueTowerImageViewWidthConstraint
                                leftConstraint:self.blueTowerImageViewLeftConstraint
                                     blueScore:[_gameOrder.teamBGameState.teamTower20 integerValue]
                                      redScore:[_gameOrder.teamAGameState.teamTower20 integerValue]];
        
        [self justWidthConstraintWithImageView:self.blueDragonImageView
                               widthConstraint:self.blueDragonImageViewWidthConstraint
                                leftConstraint:self.blueDragonImageViewLeftConstraint
                                     blueScore:[_gameOrder.teamBGameState.teamDragon20 integerValue]
                                      redScore:[_gameOrder.teamAGameState.teamDragon20 integerValue]];
        
        [self justGoldDiffWidthConstraintWithImageView:self.blueGoldDiffImageView
                                       widthConstraint:self.blueGoldDiffImageViewWidthConstraint
                                        leftConstraint:self.blueGoldDiffImageViewLeftConstraint
                                             blueScore:[_gameOrder.teamBGameState.teamGoldDiffAt25 integerValue]
                                              redScore:[_gameOrder.teamAGameState.teamGoldDiffAt25 integerValue]];
        
        
        [self justWidthConstraintWithImageView:self.blueKillImageView
                               widthConstraint:self.blueKillImageViewWidthConstraint
                                leftConstraint:self.blueKillImageViewLeftConstraint
                                     blueScore:[_gameOrder.teamBGameState.teamKill integerValue]
                                      redScore:[gameOrder.teamAGameState.teamKill integerValue]];
    }else{
        self.blueTowerScoreLabel.text = _gameOrder.teamAGameState.teamTower20;
        self.blueDragonScoreLabel.text = _gameOrder.teamAGameState.teamDragon20;
        self.blueGoldDiffScoreLabel.text = _gameOrder.teamAGameState.teamGoldDiffAt25;
        self.blueKillScoreLabel.text = _gameOrder.teamAGameState.teamKill;
        
        self.redTowerScoreLabel.text = _gameOrder.teamBGameState.teamTower20;
        self.redDragonScoreLabel.text = _gameOrder.teamBGameState.teamDragon20;
        self.redGoldDiffScoreLabel.text = _gameOrder.teamBGameState.teamGoldDiffAt25;
        self.redKillScoreLabel.text = _gameOrder.teamBGameState.teamKill;
        
        
        [self justWidthConstraintWithImageView:self.blueTowerImageView
                               widthConstraint:self.blueTowerImageViewWidthConstraint
                                leftConstraint:self.blueTowerImageViewLeftConstraint
                                     blueScore:[_gameOrder.teamAGameState.teamTower20 integerValue]
                                      redScore:[_gameOrder.teamBGameState.teamTower20 integerValue]];
        
        [self justWidthConstraintWithImageView:self.blueDragonImageView
                               widthConstraint:self.blueDragonImageViewWidthConstraint
                                leftConstraint:self.blueDragonImageViewLeftConstraint
                                     blueScore:[_gameOrder.teamAGameState.teamDragon20 integerValue]
                                      redScore:[_gameOrder.teamBGameState.teamDragon20 integerValue]];
        
        [self justGoldDiffWidthConstraintWithImageView:self.blueGoldDiffImageView
                                       widthConstraint:self.blueGoldDiffImageViewWidthConstraint
                                        leftConstraint:self.blueGoldDiffImageViewLeftConstraint
                                             blueScore:[_gameOrder.teamAGameState.teamGoldDiffAt25 integerValue]
                                              redScore:[_gameOrder.teamBGameState.teamGoldDiffAt25 integerValue]];
        
        
        [self justWidthConstraintWithImageView:self.blueKillImageView
                               widthConstraint:self.blueKillImageViewWidthConstraint
                                leftConstraint:self.blueKillImageViewLeftConstraint
                                     blueScore:[_gameOrder.teamAGameState.teamKill integerValue]
                                      redScore:[_gameOrder.teamBGameState.teamKill integerValue]];
    }
    
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
                          leftConstraint:(NSLayoutConstraint *)leftConstraint
                               blueScore:(NSInteger)blueScore
                                redScore:(NSInteger)redScore
{
    CGFloat totalWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8.0*3;
    
    if (blueScore == 0 && redScore == 0) {
        widthConstraint.constant = totalWidth*0.5;
        leftConstraint.constant = 8.0f;
        [imageView setNeedsLayout];
        return;
    };
    
    NSInteger totalScore = blueScore+redScore;
    CGFloat blueWidth = totalWidth *((CGFloat)blueScore/(CGFloat)totalScore);
    
    if (blueScore == 0) {
        leftConstraint.constant = 0.0f;
    }else if (blueScore == totalScore) {
        leftConstraint.constant = 0.0f;
        blueWidth += 8.0f;
    }else{
        leftConstraint.constant = 8.0f;
    }
    
    widthConstraint.constant = blueWidth;
    [imageView setNeedsLayout];
}

- (void)justGoldDiffWidthConstraintWithImageView:(UIImageView *)imageView
                         widthConstraint:(NSLayoutConstraint *)widthConstraint
                                  leftConstraint:(NSLayoutConstraint *)leftConstraint
                               blueScore:(double)blueGoldDiffAt25
                                redScore:(double)redGoldDiffAt25
{
    CGFloat totalWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8.0*3;
    
    if (blueGoldDiffAt25 == 0 && redGoldDiffAt25 == 0) {
        
        widthConstraint.constant = totalWidth*0.5;
        leftConstraint.constant = 8.0f;
        [imageView setNeedsLayout];
        
        return;
    };
    
    
    double totalScore = 7.0;
    
    CGFloat blueWidth = 0.0f;
    
    if (blueGoldDiffAt25 < 0 && blueGoldDiffAt25 > -7) {
        blueWidth = 0.5*totalWidth *((totalScore-fabs(blueGoldDiffAt25))/(CGFloat)totalScore);
    }else if (redGoldDiffAt25 < 0 && redGoldDiffAt25 > -7) {
        blueWidth = 0.5*totalWidth *(1+(totalScore-fabs(redGoldDiffAt25))/(CGFloat)totalScore);
    }else if (blueGoldDiffAt25 <= -7) {
        blueWidth = 0.0f;
    }else if (redGoldDiffAt25 <= -7) {
        blueWidth = totalWidth;
    }
    

    if (blueWidth == 0) {
        leftConstraint.constant = 0.0f;
    }else if (blueWidth == totalWidth){
        leftConstraint.constant = 0.0f;
        blueWidth += 8.0f;
    }else{
        leftConstraint.constant = 8.0f;
    }
    
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
