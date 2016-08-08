//
//  PointsTypeSelectView.h
//  ESports
//
//  Created by Peter Lee on 16/8/4.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointsTypeSelectView : UIView

@property (strong, nonatomic) NSString *teamName;
@property (copy, nonatomic) void (^tapActionBlock) (void);

+ (instancetype)instanceFromNib;

@end
