//
//  ProcessMatchCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessMatchesManager.h"

@interface ProcessMatchCell : UITableViewCell

@property (strong, nonatomic) ProcessMatch *processMatch;
@property (copy, nonatomic) void (^liveVideoBlock) (NSString *livePage);

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
