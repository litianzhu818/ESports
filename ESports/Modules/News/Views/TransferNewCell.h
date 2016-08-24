//
//  TransferNewCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/15.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferNew.h"

@interface TransferNewCell : UITableViewCell

@property (strong, nonatomic) TransferNew *transferNew;
@property (copy, nonatomic) void (^tapOnPlayerIconBlock) (NSString *playerId, NSString *playerRoleId);

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeightWithTransferNew:(TransferNew *)transferNew;

@end
