//
//  PlayerRole.m
//  ESports
//
//  Created by Peter Lee on 16/8/24.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "PlayerRole.h"

@implementation PlayerRole
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"roleId",
                                                       @"Name":@"roleName",
                                                       @"NameCn":@"roleNameCn",
                                                       @"NameEn":@"roleNameEn",
                                                       @"NameTw":@"roleNameTw",
                                                       @"Order":@"roleOrder"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
