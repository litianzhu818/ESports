//
//  DetailNewSubNewCell.h
//  ESports
//
//  Created by Peter Lee on 16/7/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailNewSubNewCell : UITableViewCell

@property (strong, nonatomic) NSString *newsId;
@property (strong, nonatomic) NSString *newsTitle;
@property (strong, nonatomic) NSString *newsImageUrl;

@property (assign, nonatomic) BOOL notShowBottomLine;

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
