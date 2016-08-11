//
//  StrengScoreTeamThirdCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/11.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrengScoreTeamDetail.h"

@interface StrengScoreTeamThirdCell : UITableViewCell

@property (strong, nonatomic) NSArray<StrengScoreTeamPlayer *> *players;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
