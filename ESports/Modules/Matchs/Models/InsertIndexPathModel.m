//
//  InsertIndexPathModel.m
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "InsertIndexPathModel.h"

@implementation InsertIndexPathModel

- (instancetype)initWithLastSectionIndex:(NSInteger)lastSectionIndex
{
    self = [super init];
    if (self) {
        self.lastSectionIndex = lastSectionIndex;
        self.indexPaths = [NSMutableArray array];
        self.sectionsSet = [NSMutableIndexSet indexSet];
    }
    return self;
}

- (void)addIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath) return;
    
    if (indexPath.section == self.lastSectionIndex) {
        [self.indexPaths addObject:indexPath];
    }else{
        [self.sectionsSet addIndex:indexPath.section];
    }
}

@end
