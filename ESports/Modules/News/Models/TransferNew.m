//
//  TransferNew.m
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "TransferNew.h"

@interface JSONValueTransformer (NSDateStringformer)

- (NSDate *)NSDateFromNSString:(NSString*)string;
- (NSString *)JSONObjectFromNSDate:(NSDate *)date;

@end

@implementation JSONValueTransformer (NSDateStringformer)

- (NSDate *)NSDateFromNSString:(NSString*)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss Z"];
    return [formatter dateFromString:string];
}

- (NSString *)JSONObjectFromNSDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd "];
    return [formatter stringFromDate:date];
}

@end


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
                                                       @"JoinTeamDate":@"joinTeamDate",
                                                       @"FromTeamName":@"fromTeamName",
                                                       @"FromTeamSrc":@"fromTeamImageUrl",
                                                       @"FromTeamDate":@"fromTeamDate"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSString *)joinTeamDateString
{
    return [[JSONValueTransformer new] JSONObjectFromNSDate:self.joinTeamDate];
}
- (NSString *)fromTeamDateString
{
    return [[JSONValueTransformer new] JSONObjectFromNSDate:self.fromTeamDate];
}

@end
