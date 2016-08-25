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

@property (weak, nonatomic) IBOutlet UIImageView *teamAKillImageView;
@property (weak, nonatomic) IBOutlet UIImageView *teamADeathImageView;
@property (weak, nonatomic) IBOutlet UIImageView *teamAAssistsImageView;

@property (weak, nonatomic) IBOutlet UIImageView *teamBKillImageView;
@property (weak, nonatomic) IBOutlet UIImageView *teamBDeathImageView;
@property (weak, nonatomic) IBOutlet UIImageView *teamBAssistsImageView;

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
    
    self.redPicksImageView1.layer.borderWidth = 1.0;
    self.redPicksImageView1.layer.masksToBounds = YES;
    
    self.redPicksImageView2.layer.borderWidth = 1.0;
    self.redPicksImageView2.layer.masksToBounds = YES;
    
    self.redPicksImageView3.layer.borderWidth = 1.0;
    self.redPicksImageView3.layer.masksToBounds = YES;
    
    self.redPicksImageView4.layer.borderWidth = 1.0;
    self.redPicksImageView4.layer.masksToBounds = YES;
    
    self.redPicksImageView5.layer.borderWidth = 1.0;
    self.redPicksImageView5.layer.masksToBounds = YES;
    
    self.bluePicksImageView1.layer.borderWidth = 1.0;
    self.bluePicksImageView1.layer.masksToBounds = YES;
    
    self.bluePicksImageView2.layer.borderWidth = 1.0;
    self.bluePicksImageView2.layer.masksToBounds = YES;
    
    self.bluePicksImageView3.layer.borderWidth = 1.0;
    self.bluePicksImageView3.layer.masksToBounds = YES;
    
    self.bluePicksImageView4.layer.borderWidth = 1.0;
    self.bluePicksImageView4.layer.masksToBounds = YES;
    
    self.bluePicksImageView5.layer.borderWidth = 1.0;
    self.bluePicksImageView5.layer.masksToBounds = YES;
    

    self.redBannedImageView1.layer.borderWidth = 1.0;
    self.redBannedImageView1.layer.masksToBounds = YES;
    self.redBannedImageView1.layer.borderColor = HexColor(0x2d343a).CGColor;
    
    self.redBannedImageView2.layer.borderWidth = 1.0;
    self.redBannedImageView2.layer.masksToBounds = YES;
    self.redBannedImageView2.layer.borderColor = HexColor(0x2d343a).CGColor;
    
    self.redBannedImageView3.layer.borderWidth = 1.0;
    self.redBannedImageView3.layer.masksToBounds = YES;
    self.redBannedImageView3.layer.borderColor = HexColor(0x2d343a).CGColor;
    
    self.blueBannedImageView1.layer.borderWidth = 1.0;
    self.blueBannedImageView1.layer.masksToBounds = YES;
    self.blueBannedImageView1.layer.borderColor = HexColor(0x2d343a).CGColor;
    
    self.blueBannedImageView2.layer.borderWidth = 1.0;
    self.blueBannedImageView2.layer.masksToBounds = YES;
    self.blueBannedImageView2.layer.borderColor = HexColor(0x2d343a).CGColor;
    
    self.blueBannedImageView3.layer.borderWidth = 1.0;
    self.blueBannedImageView3.layer.masksToBounds = YES;
    self.blueBannedImageView3.layer.borderColor = HexColor(0x2d343a).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    MatchTeamGameOrder *gameOrder = self.matchTeamData.gameOrders[self.index];
    UIColor *blueTeamColor = HexColor(0x367bd2);
    UIColor *redTeamColor = HexColor(0xdd222b);
    
    if (gameOrder.isATeamRedSide) {
        self.teamAKillImageView.image = [UIImage imageNamed:@"match_kill_red.png"];
        self.teamADeathImageView.image = [UIImage imageNamed:@"match_death_red.png"];
        self.teamAAssistsImageView.image = [UIImage imageNamed:@"match_assists_red.png"];
        
        self.teamBKillImageView.image = [UIImage imageNamed:@"match_kill_blue.png"];
        self.teamBDeathImageView.image = [UIImage imageNamed:@"match_death_blue.png"];
        self.teamBAssistsImageView.image = [UIImage imageNamed:@"match_assists_blue.png"];
        
        self.redPicksImageView1.layer.borderColor = redTeamColor.CGColor;
        self.redPicksImageView2.layer.borderColor = redTeamColor.CGColor;
        self.redPicksImageView3.layer.borderColor = redTeamColor.CGColor;
        self.redPicksImageView4.layer.borderColor = redTeamColor.CGColor;
        self.redPicksImageView5.layer.borderColor = redTeamColor.CGColor;
        
        self.bluePicksImageView1.layer.borderColor = blueTeamColor.CGColor;
        self.bluePicksImageView2.layer.borderColor = blueTeamColor.CGColor;
        self.bluePicksImageView3.layer.borderColor = blueTeamColor.CGColor;
        self.bluePicksImageView4.layer.borderColor = blueTeamColor.CGColor;
        self.bluePicksImageView5.layer.borderColor = blueTeamColor.CGColor;
        
    }else{
        self.teamAKillImageView.image = [UIImage imageNamed:@"match_kill_blue.png"];
        self.teamADeathImageView.image = [UIImage imageNamed:@"match_death_blue.png"];
        self.teamAAssistsImageView.image = [UIImage imageNamed:@"match_assists_blue.png"];
        
        self.teamBKillImageView.image = [UIImage imageNamed:@"match_kill_red.png"];
        self.teamBDeathImageView.image = [UIImage imageNamed:@"match_death_red.png"];
        self.teamBAssistsImageView.image = [UIImage imageNamed:@"match_assists_red.png"];
        
        self.redPicksImageView1.layer.borderColor = blueTeamColor.CGColor;
        self.redPicksImageView2.layer.borderColor = blueTeamColor.CGColor;
        self.redPicksImageView3.layer.borderColor = blueTeamColor.CGColor;
        self.redPicksImageView4.layer.borderColor = blueTeamColor.CGColor;
        self.redPicksImageView5.layer.borderColor = blueTeamColor.CGColor;
        
        self.bluePicksImageView1.layer.borderColor = redTeamColor.CGColor;
        self.bluePicksImageView2.layer.borderColor = redTeamColor.CGColor;
        self.bluePicksImageView3.layer.borderColor = redTeamColor.CGColor;
        self.bluePicksImageView4.layer.borderColor = redTeamColor.CGColor;
        self.bluePicksImageView5.layer.borderColor = redTeamColor.CGColor;
    }
    
    
    self.redKillLabel.text = gameOrder.teamAGameState.teamKill;
    self.redDeathLabel.text = gameOrder.teamAGameState.teamDeath;
    self.redAssistsLabel.text = gameOrder.teamAGameState.teamAssist;
    
    self.blueKillLabel.text = gameOrder.teamBGameState.teamKill;
    self.blueDeathLabel.text = gameOrder.teamBGameState.teamDeath;
    self.blueAssistsLabel.text = gameOrder.teamBGameState.teamAssist;
    
    
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
    return 108.0f;
}

@end
