//
//  StrengScoreTeamTopCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/11.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrengScoreTeamDetail.h"

@interface StrengScoreTeamTopCell : UITableViewCell

@property (strong, nonatomic) StrengScoreTeamDetail *teamDetail;
@property (copy, nonatomic) void (^followActionBlock) (void);
@property (assign, nonatomic) BOOL isFollowed;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
