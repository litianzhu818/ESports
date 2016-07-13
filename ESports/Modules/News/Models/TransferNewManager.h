//
//  TransferNewManager.h
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransferNew.h"

@class TransferNewContainer;

@interface TransferNewManager : NSObject

@property (strong, nonatomic) NSMutableArray<TransferNewContainer *> *transferNewContainers;

- (void)addTransferNew:(TransferNew *)transferNew;

@end

@interface TransferNewContainer : NSObject

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSMutableArray<TransferNew *> *transferNews;

- (instancetype)initWithTransferNew:(TransferNew *)transferNew;
- (void)addTransferNew:(TransferNew *)transferNew;
- (void)sortTransferNewsWithDate;
@end
