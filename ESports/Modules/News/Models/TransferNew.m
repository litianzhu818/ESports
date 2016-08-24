//
//  TransferNew.m
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "TransferNew.h"
#import "NSObject+Custom.h"

@implementation TransferNew

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"newsId",
                                                       @"PlayerId":@"playerId",
                                                       @"PlayerName":@"playerName",
                                                       @"PlayerCountry":@"playerCountry",
                                                       @"PlayerSrc":@"playerImageUrl",
                                                       @"JoinTeamName":@"joinTeamName",
                                                       @"JoinTeamSrc":@"joinTeamImageUrl",
                                                       @"JoinTeamDate":@"joinTeamDateString",
                                                       @"FromTeamName":@"fromTeamName",
                                                       @"FromTeamSrc":@"fromTeamImageUrl",
                                                       @"RoleName":@"roleName",
                                                       @"RoleNameEn":@"roleNameEn",
                                                       @"RoleNameCn":@"roleNameCn",
                                                       @"RoleNameTw":@"roleNameTw",
                                                       @"RoleId":@"roleId"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSDate *)joinTeamDate
{
    if (!_joinTeamDate) _joinTeamDate = [self dateWithSpecialDateSring:self.joinTeamDateString];
    return _joinTeamDate;
}

@end
