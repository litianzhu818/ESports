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
