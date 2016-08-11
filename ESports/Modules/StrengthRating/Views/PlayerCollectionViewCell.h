//
//  CollectionViewCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/11.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrengScoreTeamDetail.h"

@interface PlayerCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) StrengScoreTeamPlayer *player;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGSize)cellSize;

@end
