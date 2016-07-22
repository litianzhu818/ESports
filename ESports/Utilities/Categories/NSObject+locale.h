//
//  NSObject+locale.h
//  ESports
//
//  Created by Peter Lee on 16/7/21.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (locale)

#pragma mark - 根据自己的语言标识获取的当前locale（不是系统locale）

- (NSLocale *)currentLocale;

@end
