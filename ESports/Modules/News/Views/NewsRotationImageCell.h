//
//  NewsRotationImageCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/14.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsRotationImage.h"

@interface NewsRotationImageCell : UITableViewCell

@property (strong, nonatomic) NSArray<NewsRotationImage *> *images;
@property (copy, nonatomic) void (^clikedBlock) (NSInteger index);

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeightWithWidth:(CGFloat)width;

@end
