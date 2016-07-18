//
//  HotWordNewManager.m
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "HotWordNewManager.h"
#import "NSObject+Custom.h"

@implementation HotWordNewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hotWordNewContainers = [NSMutableArray array];
    }
    return self;
}

- (NSIndexPath *)addHotWordNew:(HotWordNew *)hotWordNew
{
    __block NSIndexPath *indexPath = nil;
    if (!self.hotWordNewContainers) self.hotWordNewContainers = [NSMutableArray array];
    __block BOOL hasHotWordNewContainer = NO;
    [self.hotWordNewContainers enumerateObjectsUsingBlock:^(HotWordNewContainer * _Nonnull hotWordNewContainer, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[hotWordNew stringDate] isEqualToString:hotWordNewContainer.dateString]) {
            [hotWordNewContainer addHotWordNew:hotWordNew];
            hasHotWordNewContainer = YES;
            indexPath = [NSIndexPath indexPathForRow:hotWordNewContainer.hotWordNews.count-1 inSection:idx];
        }
    }];
    
    if (!hasHotWordNewContainer) {
        HotWordNewContainer *newHotWordNewContainer = [[HotWordNewContainer alloc] initWithHotWordNew:hotWordNew];
        [self.hotWordNewContainers addObject:newHotWordNewContainer];
        
        indexPath = [NSIndexPath indexPathForRow:0 inSection:self.hotWordNewContainers.count-1];
    }
    
    return indexPath;
}

- (void)addHotWordNewContainer:(HotWordNewContainer *)hotWordNewContainer
{
    if (!self.hotWordNewContainers) self.hotWordNewContainers = [NSMutableArray array];
    
    if (hotWordNewContainer) {
        [self.hotWordNewContainers addObject:hotWordNewContainer];
    }
}

- (void)removeAllObjects
{
    [self.hotWordNewContainers removeAllObjects];
}


@end

@implementation HotWordNewContainer

- (instancetype)init
{
    return [self initWithHotWordNew:nil];
}

- (instancetype)initWithHotWordNew:(HotWordNew *)hotWordNew
{
    self = [super init];
    if (self) {
        self.hotWordNews = [NSMutableArray array];
        
        if (hotWordNew) {
            [self.hotWordNews addObject:hotWordNew];
            self.dateString = [hotWordNew stringDate];
        }
    }
    return self;
}
- (void)addHotWordNew:(HotWordNew *)hotWordNew
{
    if (!self.hotWordNews) self.hotWordNews = [NSMutableArray array];
    [self.hotWordNews addObject:hotWordNew];
}

- (void)sortHotWordNewsWithDate
{
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"newsDate" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    self.hotWordNews = [NSMutableArray arrayWithArray:[self.hotWordNews sortedArrayUsingDescriptors:descriptors]];
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Date":@"dateString",
                                                       @"List":@"hotWordNews"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSDate *)date
{
    _date = [self dateWithSpecialDateSring:self.dateString];
    return _date;
}


@end
