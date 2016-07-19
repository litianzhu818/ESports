//
//  DetailHotNewsBottomCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailNew.h"

@interface DetailHotNewsBottomCell : UITableViewCell

@property (strong, nonatomic) NSArray<HotNew *> *hotNews;
@property (copy, nonatomic) void (^selectedNewsBlock) (NSString *newsId);

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeightWithHotNews:(NSArray<HotNew *> *)hotNews;

@end
