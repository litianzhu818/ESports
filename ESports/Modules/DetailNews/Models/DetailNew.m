//
//  DetailNew.m
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DetailNew.h"
#import "NSObject+Custom.h"

/*
 Time：4/10/2016 4:00:00 PM +00:00,
 Date: 2016/4/23 16:00:00 +00:00,
 */

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
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

@end


@implementation DetailNew

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"newsId",
                                                       @"Title":@"newsTitle",
                                                       @"Area":@"newsArea",
                                                       @"From":@"newsFrom",
                                                       @"Date":@"newsDateString",
                                                       @"Content":@"newsContent",
                                                       @"HotNews":@"hotNews",
                                                       @"RelNews":@"relNews"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSDate *)newsDate
{
    if (_newsDate) {
        return _newsDate;
    }
    _newsDate = [self dateWithSpecialDateSring:self.newsDateString];
    return _newsDate;
}

- (NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:self.newsDate];
}

@end

@implementation HotNew

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"hotNewId",
                                                       @"Title":@"hotNewTitle",
                                                       @"ImgSrc":@"hotNewImageUrl"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


@end

@implementation RelNew

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"relNewId",
                                                       @"Title":@"relNewTitle"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


@end
