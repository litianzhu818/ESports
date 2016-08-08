//
//  PointsType.m
//  ESports
//
//  Created by Peter Lee on 16/8/4.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "PointsType.h"

@implementation PointsType

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"pointsTypeId",
                                                       @"TypeName":@"pointsTypeName"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
