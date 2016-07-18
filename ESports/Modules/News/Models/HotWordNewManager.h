//
//  HotWordNewManager.h
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HotWordNew.h"

@class HotWordNewContainer;

@protocol HotWordNew
@end

@interface HotWordNewManager : JSONModel

@property (strong, nonatomic) NSMutableArray<HotWordNewContainer *> *hotWordNewContainers;

- (NSIndexPath *)addHotWordNew:(HotWordNew *)hotWordNew;

- (void)addHotWordNewContainer:(HotWordNewContainer *)hotWordNewContainer;
- (void)removeAllObjects;

@end

@interface HotWordNewContainer : JSONModel

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) NSMutableArray<HotWordNew> *hotWordNews;

- (instancetype)initWithHotWordNew:(HotWordNew *)hotWordNew;
- (void)addHotWordNew:(HotWordNew *)hotWordNew;
- (void)sortHotWordNewsWithDate;

@end
