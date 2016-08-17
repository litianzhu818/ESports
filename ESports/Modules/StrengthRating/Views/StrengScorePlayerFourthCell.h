//
//  StrengScorePlayerFourthCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/17.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrengScorePlayerDetail.h"

@interface StrengScorePlayerFourthCell : UITableViewCell

@property (strong, nonatomic) StrengScorePlayerDetail *playerDetail;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
