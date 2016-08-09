//
//  StrengScoreTeamCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/9.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrengScoreTeam.h"

@interface StrengScoreTeamCell : UITableViewCell

@property (strong, nonatomic) StrengScoreTeam *team;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
