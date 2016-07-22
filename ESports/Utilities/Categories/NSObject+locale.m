//
//  NSObject+locale.m
//  ESports
//
//  Created by Peter Lee on 16/7/21.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "NSObject+locale.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE90_
    #define ENGLISH_LANGUAGE_IDENTIFIER @"en-US"          //英语
    #define S_CHINESE_LANGUAGE_IDENTIFIER @"zh-Hans-CN"   //简体中文
    #define T_CHINESE_LANGUAGE_IDENTIFIER @"zh-Hant-TW"   //繁体中文
#else
    #define ENGLISH_LANGUAGE_IDENTIFIER @"en"          //英语
    #define S_CHINESE_LANGUAGE_IDENTIFIER @"zh-Hans"   //简体中文
    #define T_CHINESE_LANGUAGE_IDENTIFIER @"zh-Hant"   //繁体中文
#endif

@implementation NSObject (locale)

#pragma mark - locale method

- (NSLocale *)currentLocale
{
    NSString *lcocaleIdentifier = nil;
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        lcocaleIdentifier = ENGLISH_LANGUAGE_IDENTIFIER;
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]){
        lcocaleIdentifier = S_CHINESE_LANGUAGE_IDENTIFIER;
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]){
        lcocaleIdentifier = T_CHINESE_LANGUAGE_IDENTIFIER;
    }
    
    if (lcocaleIdentifier) {
        return [[NSLocale alloc] initWithLocaleIdentifier:lcocaleIdentifier];
    }
    
    return [NSLocale currentLocale];
}


@end
