//
//  HotWordNewCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotWordNew.h"

@interface HotWordNewCell : UITableViewCell

@property (strong, nonatomic) HotWordNew *hotWordNew;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
