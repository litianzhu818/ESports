//
//  StrengScorePlayer.m
//  ESports
//
//  Created by Peter Lee on 16/8/9.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScorePlayer.h"

@implementation StrengScorePlayer

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"PlayerId":@"playerId",
                                                       @"PlayerName":@"playerName",
                                                       @"PlayerLogo":@"playerImageUrl",
                                                       @"Ranking":@"playerRanking",
                                                       @"GlobalRanking":@"playerGlobalRanking",
                                                       @"RegionLogo":@"playerRegionImageUrl",
                                                       @"Strength":@"playerStrength",
                                                       @"Price":@"playerPrice"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
