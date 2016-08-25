//
//  MatchTeamDataTopCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/28.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchTeamData.h"

@interface MatchTeamDataTopCell : UITableViewCell

@property (strong, nonatomic) NSString *teamAImageUrl;
@property (strong, nonatomic) NSString *teamBImageUrl;
@property (assign, nonatomic) BOOL isARedSide;
@property (strong, nonatomic) MatchTeamGameResult *gameResult;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
