//
//  PopMenuModel.h
//  Kissnapp
//
//  Created by Peter Lee on 15/4/3.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopMenuModel : NSObject<NSCopying, NSCoding>

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;

- (id)initWithImage:(UIImage *)image title:(NSString *)title;

@end
