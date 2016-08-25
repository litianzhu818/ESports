//
//  NSString+Common.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

- (BOOL)emailAddressString //设定邮箱验证 信息
{
    NSString *regex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    //注意\d正则法则在OC中表达式\\d
    //用谓词过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //返回一个BOOL值
    return [predicate evaluateWithObject:self];
}

@end
