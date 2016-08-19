//
//  MatchTeamDataCenterCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/28.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchTeamData.h"

@interface MatchTeamDataCenterCell : UITableViewCell

@property (strong, nonatomic) MatchTeamGameOrder *gameOrder;
@property (strong, nonatomic) NSString *blueTeamName;
@property (strong, nonatomic) NSString *redTeamName;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
