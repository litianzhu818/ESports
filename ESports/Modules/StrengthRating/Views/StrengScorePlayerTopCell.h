//
//  StrengScorePlayerTopCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/16.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrengScorePlayerDetail.h"

@interface StrengScorePlayerTopCell : UITableViewCell

@property (strong, nonatomic) StrengScorePlayerDetail *playerDetail;
@property (copy, nonatomic) void (^followActionBlock) (void);
@property (assign, nonatomic) BOOL isFollowed;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
