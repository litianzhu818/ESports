//
//  HotWordNew.m
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "HotWordNew.h"
#import "NSObject+Custom.h"
/*
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
*/
@implementation HotWordNew

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"newsId",
                                                       @"Title":@"newsTitle",
                                                       @"ImgSrc":@"newsImageUrl",
                                                       @"Date":@"stringDate",
                                                       @"CreateTime":@"stringCreateDate"
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
    _newsDate = [self dateWithSpecialDateSring:self.stringDate];
    return _newsDate;
}

- (NSDate *)newsCreateDate
{
    if (_newsCreateDate) {
        return _newsCreateDate;
    }
    _newsCreateDate = [self dateWithSpecialDateSring:self.stringCreateDate];
    return _newsCreateDate;
}

@end
