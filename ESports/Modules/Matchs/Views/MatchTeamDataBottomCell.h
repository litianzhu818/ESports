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

@property (strong, nonatomic) MatchTeamData *matchTeamData;
@property (assign, nonatomic) BOOL isPicks;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeightWithMatchTeamData:(MatchTeamData *)matchTeamData isPicks:(BOOL)isPicks;


@end
