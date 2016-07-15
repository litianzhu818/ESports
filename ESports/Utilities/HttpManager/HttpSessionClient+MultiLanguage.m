//
//  HttpSessionClient+MultiLanguage.m
//  ESports
//
//  Created by Peter Lee on 16/6/22.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "HttpSessionClient+MultiLanguage.h"
#import "LTZLocalizationKit.h"

@implementation HttpSessionClient (MultiLanguage)

- (NSString *)locationPathWithSubPath:(NSString *)subPath
{
    NSString *localization = @"en";// 默认英文
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {//简体中文
        localization = @"zh-CN";
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]){//繁体中文
        localization = @"zh-TW";
    }else{
        //localization = @"en";
    }
    return [localization stringByAppendingPathComponent:subPath];
}

@end
