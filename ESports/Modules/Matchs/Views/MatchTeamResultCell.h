//
//  MatchTeamResultCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/28.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchTeamResultCell : UICollectionViewCell

@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isBlueTeam;
@property (assign, nonatomic) BOOL hasTeam;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGSize)cellSize;

@end
