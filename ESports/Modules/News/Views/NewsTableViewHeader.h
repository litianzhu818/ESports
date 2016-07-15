//
//  NewsTableViewHeader.h
//  ESports
//
//  Created by Peter Lee on 16/7/15.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewHeader : UITableViewHeaderFooterView

@property (strong, nonatomic) NSDate *date;

+ (UINib *)nib;
+ (CGFloat)headerHeight;
+ (NSString *)headerReuseIdentifier;

@end
