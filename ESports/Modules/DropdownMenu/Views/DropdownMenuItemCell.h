//
//  DropdownMenuItemCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/7.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownMenuItem.h"

@interface DropdownMenuItemCell : UITableViewCell

@property (strong, nonatomic) DropdownMenuItem *item;
@property (assign, nonatomic) BOOL hasBottomLine;
@property (assign, nonatomic) BOOL isSelected;

+ (UINib *)nib;
+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;

@end
