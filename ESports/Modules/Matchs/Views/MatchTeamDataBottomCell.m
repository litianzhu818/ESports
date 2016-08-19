//
//  MatchTeamDataBottomCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchTeamDataBottomCell.h"
#import "UIImageView+WebCache.h"

@interface MatchTeamDataBottomCell ()

@property (weak, nonatomic) IBOutlet UILabel *winTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *redTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueTeamNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *redKillLabel;
@property (weak, nonatomic) IBOutlet UILabel *redDeathLabel;
@property (weak, nonatomic) IBOutlet UILabel *redAssistsLabel;

@property (weak, nonatomic) IBOutlet UILabel *blueKillLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueDeathLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueAssistsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *redPicksImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *redPicksImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *redPicksImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *redPicksImageView4;
@property (weak, nonatomic) IBOutlet UIImageView *redPicksImageView5;


@property (weak, nonatomic) IBOutlet UIImageView *bluePicksImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *bluePicksImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *bluePicksImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *bluePicksImageView4;
@property (weak, nonatomic) IBOutlet UIImageView *bluePicksImageView5;

@property (weak, nonatomic) IBOutlet UIImageView *redBannedImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *redBannedImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *redBannedImageView3;

@property (weak, nonatomic) IBOutlet UIImageView *blueBannedImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *blueBannedImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *blueBannedImageView3;

@end

@implementation MatchTeamDataBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    //self.blueTeamNameLabel.textColor = HexColor(0xa7a8ab);
    //self.redTeamNameLabel.textColor = HexColor(0xa7a8ab);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    MatchTeamGameOrder *gameOrder = self.matchTeamData.gameOrders[self.index];
    
    if (gameOrder.teamAGameResult.win) {
        if (gameOrder.isATeamRedSide) {
            self.winTitleLabel.text = @"Win - Loss";
            self.redTeamNameLabel.text = self.matchTeamData.teamAInfo.teamName;
            self.blueTeamNameLabel.text = self.matchTeamData.teamBInfo.teamName;
            self.redKillLabel.text = gameOrder.teamAGameState.teamKill;
            self.redDeathLabel.text = gameOrder.teamAGameState.teamDeath;
            self.redAssistsLabel.text = gameOrder.teamAGameState.teamAssist;
            self.blueKillLabel.text = gameOrder.teamBGameState.teamKill;
            self.blueDeathLabel.text = gameOrder.teamBGameState.teamKill;
            self.blueAssistsLabel.text = gameOrder.teamBGameState.teamKill;
            [self.redPicksImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[0]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[1]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[2]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView4 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[3]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView5 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[4]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[0]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[1]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[2]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView4 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[3]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView5 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[4]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[0]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[1]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[2]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[0]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[1]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[2]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];

        }else{
            self.winTitleLabel.text = @"Loss - Win";
            self.redTeamNameLabel.text = self.matchTeamData.teamBInfo.teamName;
            self.blueTeamNameLabel.text = self.matchTeamData.teamAInfo.teamName;
            self.redKillLabel.text = gameOrder.teamBGameState.teamKill;
            self.redDeathLabel.text = gameOrder.teamBGameState.teamDeath;
            self.redAssistsLabel.text = gameOrder.teamBGameState.teamAssist;
            self.blueKillLabel.text = gameOrder.teamAGameState.teamKill;
            self.blueDeathLabel.text = gameOrder.teamAGameState.teamKill;
            self.blueAssistsLabel.text = gameOrder.teamAGameState.teamKill;
            [self.redPicksImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[0]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[1]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[2]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView4 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[3]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView5 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[4]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[0]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[1]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[2]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView4 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[3]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView5 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[4]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[0]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[1]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[2]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[0]]
                                         placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[1]]
                                         placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[2]]
                                         placeholderImage:[UIImage imageNamed:@"占位图片"]];
        }
    }else{
        if (gameOrder.isATeamRedSide) {
            self.winTitleLabel.text = @"Loss - Win";
            self.redTeamNameLabel.text = self.matchTeamData.teamAInfo.teamName;
            self.blueTeamNameLabel.text = self.matchTeamData.teamBInfo.teamName;
            self.redKillLabel.text = gameOrder.teamAGameState.teamKill;
            self.redDeathLabel.text = gameOrder.teamAGameState.teamDeath;
            self.redAssistsLabel.text = gameOrder.teamAGameState.teamAssist;
            self.blueKillLabel.text = gameOrder.teamBGameState.teamKill;
            self.blueDeathLabel.text = gameOrder.teamBGameState.teamKill;
            self.blueAssistsLabel.text = gameOrder.teamBGameState.teamKill;
            [self.redPicksImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[0]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[1]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[2]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView4 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[3]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView5 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[4]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[0]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[1]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[2]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView4 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[3]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView5 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[4]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[0]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[1]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[2]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[0]]
                                         placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[1]]
                                         placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[2]]
                                         placeholderImage:[UIImage imageNamed:@"占位图片"]];
        }else{
            self.winTitleLabel.text = @"Win - Loss";
            self.redTeamNameLabel.text = self.matchTeamData.teamBInfo.teamName;
            self.blueTeamNameLabel.text = self.matchTeamData.teamAInfo.teamName;
            self.redKillLabel.text = gameOrder.teamBGameState.teamKill;
            self.redDeathLabel.text = gameOrder.teamBGameState.teamDeath;
            self.redAssistsLabel.text = gameOrder.teamBGameState.teamAssist;
            self.blueKillLabel.text = gameOrder.teamAGameState.teamKill;
            self.blueDeathLabel.text = gameOrder.teamAGameState.teamKill;
            self.blueAssistsLabel.text = gameOrder.teamAGameState.teamKill;
            [self.redPicksImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[0]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[1]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[2]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView4 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[3]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redPicksImageView5 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.PickedChampions[4]]
                                       placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[0]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[1]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[2]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView4 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[3]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.bluePicksImageView5 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.PickedChampions[4]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[0]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[1]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.redBannedImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamBGameState.teamBannedChampions[2]]
                                        placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView1 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[0]]
                                         placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView2 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[1]]
                                         placeholderImage:[UIImage imageNamed:@"占位图片"]];
            [self.blueBannedImageView3 sd_setImageWithURL:[NSURL URLWithString:gameOrder.teamAGameState.teamBannedChampions[2]]
                                         placeholderImage:[UIImage imageNamed:@"占位图片"]];
        }
    }
}

- (void)setMatchTeamData:(MatchTeamData *)matchTeamData
{
    _matchTeamData = matchTeamData;
    
    [self setNeedsLayout];
}
/*
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, HexColor(0x4c5157).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 8.0, 30);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width-8.0, 30);   //终点坐标
    CGContextStrokePath(context);
}
*/

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchTeamDataBottomCell class])
                          bundle:[NSBundle bundleForClass:[MatchTeamDataBottomCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchTeamDataBottomCell class]);
}

+ (CGFloat)cellHeight
{
    return 126.0f;
}

@end
