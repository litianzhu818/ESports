//
//  ResultMatchesManager.m
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "ResultMatchesManager.h"
#import "NSObject+Custom.h"

@implementation ResultMatchesManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.resultMatchesContainers = [NSMutableArray array];
    }
    return self;
}

- (NSIndexPath *)addResultMatch:(ResultMatch *)resultMatch
{
    if (!self.resultMatchesContainers) self.resultMatchesContainers = [NSMutableArray array];
    
    __block BOOL hasResultMatchesContainer = NO;
    __block NSIndexPath *indexPath = nil;
    WEAK_SELF;
    [self.resultMatchesContainers enumerateObjectsUsingBlock:^(ResultMatchesContainer * _Nonnull resultMatchesContainer, NSUInteger idx, BOOL * _Nonnull stop) {
        STRONG_SELF;
        if ([strongSelf isSameDay:resultMatchesContainer.date date2:resultMatch.date]) {
            [resultMatchesContainer addResultMatch:resultMatch];
            hasResultMatchesContainer = YES;
            indexPath = [NSIndexPath indexPathForRow:resultMatchesContainer.resultMatches.count-1 inSection:idx];
        }
        
    }];
    
    if (!hasResultMatchesContainer) {
        ResultMatchesContainer *resultMatchesContainer = [[ResultMatchesContainer alloc] initWithResultMatch:resultMatch];
        [self.resultMatchesContainers addObject:resultMatchesContainer];
        indexPath = [NSIndexPath indexPathForRow:0 inSection:self.resultMatchesContainers.count-1];
    }
    return indexPath;
}

- (void)addResultMatchesContainer:(ResultMatchesContainer *)resultMatchesContainer
{
    if (resultMatchesContainer) {
        [self.resultMatchesContainers addObject:resultMatchesContainer];
    }
}
- (void)removeAllObjects
{
    [self.resultMatchesContainers removeAllObjects];
}

// 判断是否是同一天
- (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}

@end

@implementation ResultMatchesContainer

- (instancetype)init
{
    return [self initWithResultMatch:nil];
}
- (instancetype)initWithResultMatch:(ResultMatch *)resultMatch
{
    self = [super init];
    if (self) {
        self.resultMatches = [NSMutableArray array];
        
        if (resultMatch) {
            [self.resultMatches addObject:resultMatch];
            self.date = resultMatch.date;
        }
    }
    return self;
}
- (void)addResultMatch:(ResultMatch *)resultMatch
{
    if (!self.resultMatches) self.resultMatches = [NSMutableArray array];
    [self.resultMatches addObject:resultMatch];
}

@end

@implementation ResultMatch

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"ATeamId":@"aTeamId",
                                                       @"ATeamName":@"aTeamName",
                                                       @"ATeamSrc":@"aTeamImageUrl",
                                                       @"AScore":@"aScore",
                                                       @"BTeamId":@"bTeamId",
                                                       @"BTeamName":@"bTeamName",
                                                       @"BTeamSrc":@"bTeamImageUrl",
                                                       @"BScore":@"bScore",
                                                       @"Date":@"dateString",
                                                       @"MatchId":@"resultMatchId"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSDate *)date
{
    if (!_date) _date = [self dateWithSpecialDateSring:self.dateString];
    return _date;
}

@end
