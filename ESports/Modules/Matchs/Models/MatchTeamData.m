//
//  MatchTeamData.m
//  ESports
//
//  Created by Peter Lee on 16/7/27.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchTeamData.h"

@implementation MatchTeamData

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"MatchId":@"matchId",
                                                       @"TeamAScore":@"teamAScore",
                                                       @"TeamBScore":@"teamBScore",
                                                       @"TeamAInfo":@"teamAInfo",
                                                       @"TeamBInfo":@"teamBInfo",
                                                       @"GameDetailList":@"gameOrders"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation MatchTeamGameOrder

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"GameOrder":@"gameOrder",
                                                       @"IsTeamARedSide":@"isATeamRedSide",
                                                       @"TeamAGameStats":@"teamAGameState",
                                                       @"TeamBGameStats":@"teamBGameState",
                                                       @"TeamAGameResult":@"teamAGameResult"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end


@implementation MatchTeamGameResult

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Fb":@"firstBlood",
                                                       @"Fh":@"firstVanguard",
                                                       @"Fd":@"firstDragon",
                                                       @"Fbaron":@"firstBigDragon",
                                                       @"Ft":@"firstTower",
                                                       @"Fe":@"firstAncientDragon",
                                                       @"Win":@"win"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end


@implementation MatchTeamGameState

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Assist":@"teamAssist",
                                                       @"Death":@"teamDeath",
                                                       @"Dragon20":@"teamDragon20",
                                                       @"GoldDiffAt25":@"teamGoldDiffAt25",
                                                       @"Kill":@"teamKill",
                                                       @"Tower20":@"teamTower20",
                                                       @"BannedChampions":@"teamBannedChampions",
                                                       @"PickedChampions":@"PickedChampions"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end

@implementation MatchTeam

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"teamId",
                                                       @"Name":@"teamName",
                                                       @"Logo":@"teamImageUrl",
                                                       @"Description":@"teamDescription"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

