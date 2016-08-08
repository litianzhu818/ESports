//
//  MatchStandingCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/4.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointsTeam.h"

@interface MatchStandingCell : UITableViewCell

@property (strong, nonatomic) PointsTeam *pointsTeam;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
