//
//  PickerCollectionViewCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/17.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrengScorePlayerDetail.h"

@interface PickerCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) StrengScorePlayerPickChampion *pick;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGSize)cellSize;


@end
