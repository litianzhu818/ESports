//
//  MatchPickCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchPickCell : UICollectionViewCell

@property (strong, nonatomic) NSString *imageUrl;
@property (assign, nonatomic) BOOL isBlueTeam;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGSize)cellSize;

@end
