//
//  MatchVideoData.m
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchVideoData.h"

@implementation MatchVideoData

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"GameOrder":@"gameOrder",
                                                       @"MatchId":@"matchId",
                                                       @"VideoUrlApp":@"videoUrlApp"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
