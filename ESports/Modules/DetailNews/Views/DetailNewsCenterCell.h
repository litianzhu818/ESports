//
//  DetailNewsCenterCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailNew.h"

@interface DetailNewsCenterCell : UITableViewCell

@property (strong, nonatomic) DetailNew *detailNew;
@property (assign, nonatomic) BOOL needRelaod;
@property (copy, nonatomic) void (^cellHeightBlock) (CGFloat height);

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
