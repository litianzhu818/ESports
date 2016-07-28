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
                                                       @"GameOrder":@"gameOrder",
                                                       @"BlueTeamLogo":@"buleTeamImageUrl",
                                                       @"RedTeamLogo":@"redTeamImageUrl",
                                                       @"GameResults":@"teamGameResult",
                                                       @"BlueTeamGameStats":@"blueTeamGameData",
                                                       @"RedTeamGameStats":@"redTeamGameData"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation MatchTeamGameData

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Dragon20":@"dragon20",
                                                       @"Tower20":@"tower20",
                                                       @"GoldDiffAt25":@"goldDiffAt25",
                                                       @"Kill":@"kill",
                                                       @"BannedChampions":@"bannedChampions",
                                                       @"PickedChampions":@"pickedChampions"
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
                                                       @"Win":@"firstAncientDragon"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
