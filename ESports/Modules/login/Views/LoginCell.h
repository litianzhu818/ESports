//
//  LoginCell.h
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginCell : UITableViewCell

@property (strong, nonatomic) NSString *loginName;
@property (copy, nonatomic) void (^loginNameTextChangedBlock)(NSString *name);
@property (copy, nonatomic) void (^loginPwdTextChangedBlock)(NSString *name);
@property (copy, nonatomic) void (^loginActionBlock)(void);
@property (copy, nonatomic) void (^findPwdActionBlock)(void);
@property (copy, nonatomic) void (^registerActionBlock)(void);
@property (copy, nonatomic) void (^skipActionBlock)(void);
@property (copy, nonatomic) void (^selectedOtherWayLoginBlock)(NSInteger index);

+ (UINib *)nib;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
