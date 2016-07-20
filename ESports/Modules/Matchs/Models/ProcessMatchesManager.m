//
//  ProcessMatchesManager.m
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "ProcessMatchesManager.h"
#import "NSObject+Custom.h"

@implementation ProcessMatchesManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.processMatchesContainers = [NSMutableArray array];
    }
    return self;
}

- (NSIndexPath *)addProcessMatch:(ProcessMatch *)processMatch
{
    if (!self.processMatchesContainers) self.processMatchesContainers = [NSMutableArray array];
    
    __block BOOL hasProcessMatchesContainer = NO;
    __block NSIndexPath *indexPath = nil;
    WEAK_SELF;
    [self.processMatchesContainers enumerateObjectsUsingBlock:^(ProcessMatchesContainer * _Nonnull processMatchesContainer, NSUInteger idx, BOOL * _Nonnull stop) {
        STRONG_SELF;
        if ([strongSelf isSameDay:processMatchesContainer.date date2:processMatch.date]) {
            [processMatchesContainer addProcessMatch:processMatch];
            hasProcessMatchesContainer = YES;
            indexPath = [NSIndexPath indexPathForRow:processMatchesContainer.processMatches.count-1 inSection:idx];
        }

    }];
    
    if (!hasProcessMatchesContainer) {
        ProcessMatchesContainer *processMatchesContainer = [[ProcessMatchesContainer alloc] initWithProcessMatch:processMatch];
        [self.processMatchesContainers addObject:processMatchesContainer];
        indexPath = [NSIndexPath indexPathForRow:0 inSection:self.processMatchesContainers.count-1];
    }
    return indexPath;
}

- (void)addProcessMatchesContainer:(ProcessMatchesContainer *)processMatchesContainer
{
    if (processMatchesContainer) {
        [self.processMatchesContainers addObject:processMatchesContainer];
    }
}
- (void)removeAllObjects
{
    [self.processMatchesContainers removeAllObjects];
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

@implementation ProcessMatchesContainer

- (instancetype)init
{
    return [self initWithProcessMatch:nil];
}

- (instancetype)initWithProcessMatch:(ProcessMatch *)processMatch
{
    self = [super init];
    if (self) {
        self.processMatches = [NSMutableArray array];
        
        if (processMatch) {
            [self.processMatches addObject:processMatch];
            self.date = processMatch.date;
        }
    }
    return self;
}
- (void)addProcessMatch:(ProcessMatch *)processMatch
{
    if (!self.processMatches) self.processMatches = [NSMutableArray array];
    [self.processMatches addObject:processMatch];
}

/*
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Date":@"dateString",
                                                       @"List":@"processMatches"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
 */

@end

@implementation ProcessMatch

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"ATeamId":@"aTeamId",
                                                       @"ATeamName":@"aTeamName",
                                                       @"ATeamSrc":@"aTeamImageUrl",
                                                       @"BTeamId":@"bTeamId",
                                                       @"BTeamName":@"bTeamName",
                                                       @"BTeamSrc":@"bTeamImageUrl",
                                                       @"Bo":@"bo",
                                                       @"Date":@"dateString",
                                                       @"Id":@"processMatchId",
                                                       @"LiveStreamPage":@"liveStreamPage",
                                                       @"LiveVideoApp":@"liveVideoApp",
                                                       @"ScorePrediction":@"scorePrediction"
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
