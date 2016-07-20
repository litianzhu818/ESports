//
//  HotFocus.m
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "HotFocusNew.h"
#import "NSObject+Custom.h"

@implementation HotFocusNew

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Id":@"newsId",
                                                       @"Title":@"newsTitle",
                                                       @"ImgSrc":@"newsImageUrl",
                                                       @"Area":@"newsArea",
                                                       @"Date":@"stringDate"
                                                       }];
}


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSDate *)newsDate
{
    if (!_newsDate) _newsDate = [self dateWithSpecialDateSring:self.stringDate];
    return _newsDate;
}

- (NSString *)newsDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:self.newsDate];
}

@end
