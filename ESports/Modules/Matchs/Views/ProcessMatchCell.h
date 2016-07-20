//
//  ProcessMatchCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessMatchesManager.h"

@interface ProcessMatchCell : UITableViewCell

@property (strong, nonatomic) ProcessMatch *processMatch;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
