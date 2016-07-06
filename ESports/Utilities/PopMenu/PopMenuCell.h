//
//  PopMenuCell.h
//  Kissnapp
//
//  Created by Peter Lee on 15/4/3.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopMenuModel;
@class PopMenuStyle;

@interface PopMenuCell : UITableViewCell

// whether show the bottom Line
@property (assign, nonatomic) BOOL showBottomLine;

// the model of display view
@property (strong, nonatomic) PopMenuModel *model;

@property (strong, nonatomic) PopMenuStyle *menuSytle;

@property (strong, nonatomic) UIImage *bottomLineImage;

+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;

@end
