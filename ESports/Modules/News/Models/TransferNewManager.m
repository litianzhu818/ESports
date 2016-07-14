//
//  TransferNewManager.m
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "TransferNewManager.h"

@implementation TransferNewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transferNewContainers = [NSMutableArray array];
    }
    return self;
}

- (NSIndexPath *)addTransferNew:(TransferNew *)transferNew
{
    if (!self.transferNewContainers) self.transferNewContainers = [NSMutableArray array];
    __block BOOL hasTransferNewContainer = NO;
    __block NSIndexPath *indexPath = nil;
    [self.transferNewContainers enumerateObjectsUsingBlock:^(TransferNewContainer * _Nonnull transferNewContainer, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[transferNew joinTeamDateString] isEqualToString:transferNewContainer.date]) {
            [transferNewContainer addTransferNew:transferNew];
            hasTransferNewContainer = YES;
            indexPath = [NSIndexPath indexPathForRow:transferNewContainer.transferNews.count-1 inSection:idx];
        }
    }];
    
    if (!hasTransferNewContainer) {
        TransferNewContainer *newTransferNewContainer = [[TransferNewContainer alloc] initWithTransferNew:transferNew];
        [self.transferNewContainers addObject:newTransferNewContainer];
        indexPath = [NSIndexPath indexPathForRow:0 inSection:self.transferNewContainers.count-1];
    }
    return indexPath;
}

@end

@implementation TransferNewContainer

- (instancetype)init
{
    return [self initWithTransferNew:nil];
}

- (instancetype)initWithTransferNew:(TransferNew *)transferNew
{
    self = [super init];
    if (self) {
        self.transferNews = [NSMutableArray array];
        
        if (transferNew) {
            [self.transferNews addObject:transferNew];
            self.date = [transferNew joinTeamDateString];
        }
    }
    return self;
}
- (void)addTransferNew:(TransferNew *)transferNew
{
    if (!self.transferNews) self.transferNews = [NSMutableArray array];
    [self.transferNews addObject:transferNew];
}

- (void)sortTransferNewsWithDate
{
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"joinTeamDate" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    self.transferNews = [NSMutableArray arrayWithArray:[self.transferNews sortedArrayUsingDescriptors:descriptors]];
}

@end
