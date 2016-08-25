//
//  EmailRegisterCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailRegisterCell : UITableViewCell

@property (copy, nonatomic) void (^emailTextChangedBlock)(NSString *emai);
@property (copy, nonatomic) void (^emailRegisterAction)(void);

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
