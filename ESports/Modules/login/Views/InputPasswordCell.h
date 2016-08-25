//
//  InputPasswordCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputPasswordCell : UITableViewCell

@property (copy, nonatomic) void (^pwd1TextChangedBlock)(NSString *pwd);
@property (copy, nonatomic) void (^pwd2TextChangedBlock)(NSString *pwd);
@property (copy, nonatomic) void (^registerActionBlock)(void);

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
