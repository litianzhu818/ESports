//
//  StrengScoreTeam.m
//  ESports
//
//  Created by Peter Lee on 16/8/9.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScoreTeam.h"

@implementation StrengScoreTeam

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"TeamId":@"teamId",
                                                       @"Name":@"teamName",
                                                       @"TeamLogo":@"teamImageUrl",
                                                       @"Ranking":@"teamRanking",
                                                       @"GlobalRanking":@"teamGlobalRanking",
                                                       @"RegionLogo":@"teamRegionImageUrl",
                                                       @"Strength":@"teamStrength"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
