//
//  StrengScorePlayerCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/9.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrengScorePlayer.h"

@interface StrengScorePlayerCell : UITableViewCell

@property (strong, nonatomic) StrengScorePlayer *player;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
