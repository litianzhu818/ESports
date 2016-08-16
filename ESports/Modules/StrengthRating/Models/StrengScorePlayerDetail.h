//
//  StrengScorePlayerDetail.h
//  ESports
//
//  Created by Peter Lee on 16/8/10.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/*
{
    *AvgKillParticipation = "0.7548";
    *Carry = "0.8";
    *Cs15Min = "71.08";
    *GlobalRanking = 1;
    *Kda = "10.66";
    *LaneLose15Min = 0;
    *LaneWin15Min = "0.04";
    *PlayerId = 348;
    *PlayerLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/player/e504ba22-bd0a-4cc1-9370-35c05dd56c7c.jpg";
    *PlayerName = Peanut;
    *Price = 23254137;
    *Ranking = 0;
    *RegionLogo = "http:cdn.esportsmatrix.com/Content/images/uploaded/region/7d7f87f0-2648-4a18-b726-a705db19805d.png";
    *RegionName = "\U97e9\U56fd";
    *RegionRanking = 0;
    *RoleId = 5;
    *RoleRanking = 1;
    *Strength = 2120;
    *TeamParentRegionId = 0;
    *TrollFeed = "0.04";
    *WinRate = "0.88";
    MostPickChampions =     (
                             {
                                 Logo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/05a054ab-d141-4834-a168-897e788ca69c.png";
                                 Name = "\U8718\U86db\U5973\U7687";
                                 WinRate = 91;
                             },
                             {
                                 Logo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/47d84a94-3354-4e88-bd55-6ab1732265b6.png";
                                 Name = "\U6c38\U6052\U730e\U624b";
                                 WinRate = 66;
                             }
                             );
    PlayRoleBestStatsModel =     {
        BestAvgKda = "12.26";
        BestAvgKillParticipation = "0.8332000000000001";
        BestCarry = "0.8";
        BestCs15Min = "94.31999999999999";
        BestWinLane = "0.24";
    };
 
    PriceList =     (
                     23254137,
                     22964652,
 
                     ........
 
                     10084633,
                     10317983
                     );
}
*/

@protocol  StrengScorePlayerPickChampion
@end

@class StrengScorePlayerBestStatsModel;

@interface StrengScorePlayerDetail : JSONModel

@property (strong, nonatomic) NSString *playerId;
@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSString *playerImageUrl;
@property (strong, nonatomic) NSString *playerRoleId;
@property (strong, nonatomic) NSString *playeRoleRankinge;
@property (strong, nonatomic) NSString *playerRegionName;
@property (strong, nonatomic) NSString *playerRegionImageUrl;
@property (strong, nonatomic) NSString *playerParentRegionId;
@property (assign, nonatomic) NSInteger playerRegionRanking;
@property (assign, nonatomic) NSInteger playerRanking;
@property (assign, nonatomic) NSInteger playerGlobalRanking;
@property (assign, nonatomic) NSInteger playerStrength;
@property (assign, nonatomic) NSInteger playerPrice;
@property (assign, nonatomic) CGFloat playerWinRate;
@property (assign, nonatomic) CGFloat playerTrollFeed;
@property (assign, nonatomic) CGFloat playerAvgKillParticipation;
@property (assign, nonatomic) CGFloat playerCarry;
@property (assign, nonatomic) CGFloat playerCs15Min;


@property (assign, nonatomic) CGFloat playerKda;
@property (assign, nonatomic) CGFloat playerLaneLose15Min;
@property (assign, nonatomic) CGFloat playerLaneWin15Min;
@property (strong, nonatomic) NSArray<StrengScorePlayerPickChampion> *pickChampions;
@property (strong, nonatomic) StrengScorePlayerBestStatsModel *bestStatsModel;
@property (strong, nonatomic) NSArray *playerPriceList;


@end


@interface StrengScorePlayerPickChampion : JSONModel

@property (strong, nonatomic) NSString *pickChampionName;
@property (strong, nonatomic) NSString *pickChampionImageUrl;
@property (assign, nonatomic) CGFloat pickChampionWinRate;

@end

@interface StrengScorePlayerBestStatsModel : JSONModel

@property (assign, nonatomic) CGFloat bestAvgKda;
@property (assign, nonatomic) CGFloat bestAvgKillParticipation;
@property (assign, nonatomic) CGFloat bestCarry;
@property (assign, nonatomic) CGFloat bestCs15Min;
@property (assign, nonatomic) CGFloat bestWinLane;

@end
