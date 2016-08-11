//
//  StrengScoreTeamDetail.m
//  ESports
//
//  Created by Peter Lee on 16/8/10.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScoreTeamDetail.h"

@implementation StrengScoreTeamDetail

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"TeamId":@"teamId",
                                                       @"Name":@"teamName",
                                                       @"TeamLogo":@"teamImageUrl",
                                                       @"Ranking":@"teamRanking",
                                                       @"GlobalRanking":@"teamGlobalRanking",
                                                       @"RegionLogo":@"teamRegionImageUrl",
                                                       @"RegionName":@"teamRegionName",
                                                       @"ParentRegionId":@"teamParentRegionId",
                                                       @"Strength":@"teamStrength",
                                                       @"WinRate":@"teamWinRate",
                                                       @"Fb":@"teamFb",
                                                       @"Ft":@"teamFt",
                                                       @"Fd":@"teamFd",
                                                       @"Fh":@"teamFh",
                                                       @"Fbaron":@"teamFbaron",
                                                       @"PlayerList":@"teamPlayers",
                                                       @"StrengthList":@"teamStrengths"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation StrengScoreTeamPlayer

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"playerId",
                                                       @"Name":@"playerName",
                                                       @"Logo":@"playerImageUrl",
                                                       @"RoleId":@"playerRoleId",
                                                       @"Description":@"playerDescription"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
