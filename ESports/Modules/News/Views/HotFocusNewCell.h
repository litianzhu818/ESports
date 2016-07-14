//
//  HotFocusNewCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/14.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotFocusNew.h"

@interface HotFocusNewCell : UITableViewCell

@property (strong, nonatomic) HotFocusNew *hotFocusNew;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
