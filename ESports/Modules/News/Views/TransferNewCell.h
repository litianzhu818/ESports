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

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
