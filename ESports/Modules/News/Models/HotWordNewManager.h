//
//  HotWordNewManager.h
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotWordNew.h"

@class HotWordNewContainer;

@interface HotWordNewManager : NSObject

@property (strong, nonatomic) NSMutableArray<HotWordNewContainer *> *hotWordNewContainers;

- (void)addHotWordNew:(HotWordNew *)hotWordNew;

@end

@interface HotWordNewContainer : NSObject

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSMutableArray<HotWordNew *> *hotWordNews;

- (instancetype)initWithHotWordNew:(HotWordNew *)hotWordNew;
- (void)addHotWordNew:(HotWordNew *)hotWordNew;
- (void)sortHotWordNewsWithDate;

@end
