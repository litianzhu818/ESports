//
//  HotFocus.m
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "HotFocusNew.h"

@interface JSONValueTransformer (NSDateStringformer)

- (NSDate *)NSDateFromNSString:(NSString*)string;
- (NSString *)JSONObjectFromNSDate:(NSDate *)date;

@end

@implementation JSONValueTransformer (NSDateStringformer)

- (NSDate *)NSDateFromNSString:(NSString*)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    return [formatter dateFromString:string];
}

- (NSString *)JSONObjectFromNSDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

@end

@implementation HotFocusNew

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"newsId",
                                                       @"Title":@"newsTitle",
                                                       @"ImgSrc":@"newsImageUrl",
                                                       @"Area":@"newsArea",
                                                       @"Date":@"newsDate"
                                                       }];
}


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSString *)newsDateString
{
    return [[JSONValueTransformer new] JSONObjectFromNSDate:self.newsDate];
}

@end
