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
                                                       @"GameOrder":@"gameOrder",
                                                       @"BlueTeamPlayersStatsList":@"bluePlayersDetailData",
                                                       @"RedTeamPlayersStatsList":@"redPlayersDetailData"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation MatchPlayerDetailData

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"PlayerId":@"playerId",
                                                       @"Name":@"playerName",
                                                       @"Role":@"playerRole",
                                                       @"ChampionLogo":@"playerImageUrl",
                                                       @"Carry":@"carry",
                                                       @"Cs15Min":@"cs15Min",
                                                       @"Kda":@"kda",
                                                       @"Troll":@"troll"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
