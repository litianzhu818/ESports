//
//  StrengScorePlayerDetail.m
//  ESports
//
//  Created by Peter Lee on 16/8/10.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScorePlayerDetail.h"

@implementation StrengScorePlayerDetail

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"PlayerId":@"playerId",
                                                       @"PlayerName":@"playerName",
                                                       @"PlayerLogo":@"playerImageUrl",
                                                       @"RoleId":@"playerRoleId",
                                                       @"RoleRanking":@"playeRoleRankinge",
                                                       @"RegionName":@"playerRegionName",
                                                       @"RegionLogo":@"playerRegionImageUrl",
                                                       @"TeamParentRegionId":@"playerParentRegionId",
                                                       @"RegionRanking":@"playerRegionRanking",
                                                       @"Ranking":@"playerRanking",
                                                       @"GlobalRanking":@"playerGlobalRanking",
                                                       @"Strength":@"playerStrength",
                                                       @"Price":@"playerPrice",
                                                       @"WinRate":@"playerWinRate",
                                                       @"TrollFeed":@"playerTrollFeed",
                                                       @"AvgKillParticipation":@"playerAvgKillParticipation",
                                                       @"Carry":@"playerCarry",
                                                       @"Cs15Min":@"playerCs15Min",
                                                       @"Kda":@"playerKda",
                                                       @"LaneLose15Min":@"playerLaneLose15Min",
                                                       @"LaneWin15Min":@"playerLaneWin15Min",
                                                       @"MostPickChampions":@"pickChampions",
                                                       @"PlayRoleBestStatsModel":@"bestStatsModel",
                                                       @"PriceList":@"playerPriceList"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end

@implementation StrengScorePlayerPickChampion

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Name":@"pickChampionName",
                                                       @"Logo":@"pickChampionImageUrl",
                                                       @"WinRate":@"pickChampionWinRate"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation StrengScorePlayerBestStatsModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"BestAvgKda":@"bestAvgKda",
                                                       @"BestAvgKillParticipation":@"bestAvgKillParticipation",
                                                       @"BestCarry":@"bestCarry",
                                                       @"BestCs15Min":@"bestCs15Min",
                                                       @"BestWinLane":@"bestWinLane"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
