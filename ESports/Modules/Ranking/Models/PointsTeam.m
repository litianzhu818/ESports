//
//  PointsTeam.m
//  ESports
//
//  Created by Peter Lee on 16/8/8.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "PointsTeam.h"

@implementation PointsTeam

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"TeamId":@"pointsTeamId",
                                                       @"TeamName":@"pointsTeamName",
                                                       @"TeamSrc":@"pointsTeamImageUrl",
                                                       @"Rank":@"pointsRank",
                                                       @"Win":@"pointsWin",
                                                       @"Draw":@"pointsDraw",
                                                       @"Loss":@"pointsLoss",
                                                       @"Points":@"pointsScore"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
