//
//  DropdownMenuItem.h
//  ESports
//
//  Created by Peter Lee on 16/7/6.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DropdownMenuItem : NSObject <NSCopying, NSCoding>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithTitle:(NSString *)title;

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image;

@end
