//
//  HotWordNewManager.m
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "HotWordNewManager.h"

@implementation HotWordNewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hotWordNewContainers = [NSMutableArray array];
    }
    return self;
}

- (void)addHotWordNew:(HotWordNew *)hotWordNew
{
    if (!self.hotWordNewContainers) self.hotWordNewContainers = [NSMutableArray array];
    __block BOOL hasHotWordNewContainer = NO;
    [self.hotWordNewContainers enumerateObjectsUsingBlock:^(HotWordNewContainer * _Nonnull hotWordNewContainer, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[hotWordNew newsDateString] isEqualToString:hotWordNewContainer.date]) {
            [hotWordNewContainer addHotWordNew:hotWordNew];
            hasHotWordNewContainer = YES;
        }
    }];
    
    if (!hasHotWordNewContainer) {
        HotWordNewContainer *newHotWordNewContainer = [[HotWordNewContainer alloc] initWithHotWordNew:hotWordNew];
        [self.hotWordNewContainers addObject:newHotWordNewContainer];
    }
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
            self.date = [hotWordNew newsDateString];
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

@end
