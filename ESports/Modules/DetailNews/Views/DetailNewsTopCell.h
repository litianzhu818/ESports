//
//  DetailNewsTopCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailNew.h"

@interface DetailNewsTopCell : UITableViewCell

@property (strong, nonatomic) DetailNew *detailNew;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
