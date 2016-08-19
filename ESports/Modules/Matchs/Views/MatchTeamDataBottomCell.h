//
//  MatchTeamDataBottomCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchTeamData.h"

@interface MatchTeamDataBottomCell : UITableViewCell

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) MatchTeamData *matchTeamData;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;


@end
