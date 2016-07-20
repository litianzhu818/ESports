//
//  InsertIndexPathModel.h
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface InsertIndexPathModel : JSONModel

@property (assign, nonatomic) NSInteger lastSectionIndex;
@property (strong, nonatomic) NSMutableArray<NSIndexPath *> *indexPaths;
@property (strong, nonatomic) NSMutableIndexSet *sectionsSet;

- (instancetype)initWithLastSectionIndex:(NSInteger)lastSectionIndex;
- (void)addIndexPath:(NSIndexPath *)indexPath;

@end
