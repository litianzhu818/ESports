//
//  TransferNewManager.h
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TransferNew.h"

@class TransferNewContainer;

@protocol TransferNew
@end

@interface TransferNewManager : JSONModel

@property (strong, nonatomic) NSMutableArray<TransferNewContainer *> *transferNewContainers;

- (NSIndexPath *)addTransferNew:(TransferNew *)transferNew;
- (void)addTransferNewContainer:(TransferNewContainer *)transferNewContainer;
- (void)removeAllObjects;

@end

@interface TransferNewContainer : JSONModel

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) NSMutableArray<TransferNew> *transferNews;

- (instancetype)initWithTransferNew:(TransferNew *)transferNew;
- (void)addTransferNew:(TransferNew *)transferNew;
- (void)sortTransferNewsWithDate;
@end
