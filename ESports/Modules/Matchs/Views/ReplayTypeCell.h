//
//  ReplayTypeCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/26.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplayTypeCell : UITableViewCell

@property (copy, nonatomic) void (^selectedIndexBlock) (NSInteger index);

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
