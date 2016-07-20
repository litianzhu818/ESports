//
//  ResultMatchCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultMatchesManager.h"

@interface ResultMatchCell : UITableViewCell

@property (strong, nonatomic) ResultMatch *resultMatch;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
