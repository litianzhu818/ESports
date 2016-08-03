//
//  MatchVideoDataCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/3.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchVideoData.h"

@interface MatchVideoDataCell : UITableViewCell

@property (strong, nonatomic) MatchVideoData *matchVideoData;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
