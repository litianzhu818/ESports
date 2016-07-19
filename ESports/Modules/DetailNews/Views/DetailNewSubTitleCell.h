//
//  DetailNewSubTitleCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailNewSubTitleCell : UITableViewCell

@property (strong, nonatomic) NSString *title;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
