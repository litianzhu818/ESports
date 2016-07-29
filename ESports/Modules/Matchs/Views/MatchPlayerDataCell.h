//
//  MatchPlayerDataCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchPlayerData.h"

@interface MatchPlayerDataCell : UITableViewCell

@property (strong, nonatomic) MatchPlayerDetailData *matchPlayerDetailData;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
