//
//  MatchPlayerData.m
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchPlayerData.h"

@implementation MatchPlayerData

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"MatchId":@"matchId",
                                                       @"TeamAInfo":@"teamAInfo",
                                                       @"TeamBInfo":@"teamBInfo",
                                                       @"TeamAScore":@"teamAScore",
                                                       @"TeamBScore":@"teamBScore",
                                                       @"PlayerPerformanceList":@"gameOrders"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end

@implementation MatchPlayerGameOrder

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"GameOrder":@"gameOrder",
                                                       @"IsTeamARedSide":@"isTeamARedSide",
                                                       @"TeamAWin":@"isTeamAWin",
                                                       @"TeamAPlayersStatsList":@"teamAPlayerDetailDatas",
                                                       @"TeamBPlayersStatsList":@"teamBPlayerDetailDatas"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSArray<MatchPlayerDetailData *> *)teamAllPlayerDetailDatas
{
    NSMutableArray<MatchPlayerDetailData *> *datas = [NSMutableArray array];
    
    if (self.isTeamARedSide) {
        [self.teamBPlayerDetailDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [datas addObject:obj];
            MatchPlayerDetailData *redTeamPlayerDetailData = self.teamAPlayerDetailDatas[idx];
            if (redTeamPlayerDetailData) {
                [datas addObject:redTeamPlayerDetailData];
            }
        }];
    }else{
        [self.teamAPlayerDetailDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [datas addObject:obj];
            MatchPlayerDetailData *redTeamPlayerDetailData = self.teamBPlayerDetailDatas[idx];
            if (redTeamPlayerDetailData) {
                [datas addObject:redTeamPlayerDetailData];
            }
        }];
    }
    return datas;
}
@end

@implementation MatchPlayerDetailData

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"PlayerId":@"playerId",
                                                       @"Name":@"playerName",
                                                       @"Role":@"playerRole",
                                                       @"RoleOrder":@"playerRoleOrder",
                                                       @"TeamName":@"playerTeamName",
                                                       @"Carry":@"carry",
                                                       @"Cs15Min":@"cs15Min",
                                                       @"Kda":@"kda",
                                                       @"Troll":@"troll",
                                                       @"Kill":@"kill",
                                                       @"Death":@"death",
                                                       @"Assist":@"assist",
                                                       @"ChampionLogo":@"championImageUrl"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
