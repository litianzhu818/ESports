//
//  LTZLocalizationManager.h
//  LTZLocalizationKit
//
//  Created by Peter Lee on 16/5/30.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+localization.h"

//本地化字典格式,推荐使用独立模块模式便于维护
/*
 #格式1：（全局不包含子模块和独立子模块模式）
 ##@{
    @"地区1语言标识":@{
                     @"字符串1key":@"字符串1内容",
                     @"字符串2key":@"字符串2内容"
                    },
    @"地区2语言标识":@{
                     @"字符串1key":@"字符串1内容",
                     @"字符串2key":@"字符串2内容"
                    }
    }
    **例如:@{
            @"zh-Hans":@{
                         @"title":@"测试",
                         @"btn_title":@"切换"
                        },
            @"en":@{
                    @"title":@"test",
                    @"btn_title":@"change"
                    }
            }
 #格式2：（全局包含子模块）
 ##@{
    @"模块1key":@{
                    @"地区1语言标识":@{
                                    @"字符串1key":@"字符串1内容",
                                    @"字符串2key":@"字符串2内容"
                                    } ,
                    @"地区2语言标识":@{
                                    @"字符串1key":@"字符串1内容",
                                    @"字符串2key":@"字符串2内容"
                                    }
                },
    @"模块2key":@{
                    @"地区1语言标识":@{
                                    @"字符串1key":@"字符串1内容",
                                    @"字符串2key":@"字符串2内容"
                                    } ,
                    @"地区2语言标识":@{
                                    @"字符串1key":@"字符串1内容",
                                    @"字符串2key":@"字符串2内容"
                                    }
                    }
    }
    **例如:@{
            @"ViewController":@{
                                @"zh-Hans":@{
                                            @"title":@"测试",
                                            @"btn_title":@"切换"
                                            },
                                @"en":@{
                                        @"title":@"test",
                                        @"btn_title":@"change"
                                        }
                                },
            @"ViewController2":@{
                                @"zh-Hans":@{
                                            @"title":@"测试",
                                            @"btn_title":@"切换"
                                            },
                                @"en":@{
                                        @"title":@"test",
                                        @"btn_title":@"change"
                                        }
                                }
      }
*/

FOUNDATION_EXTERN NSString *const LTZLocalizationKitUserLanguageKey;
FOUNDATION_EXTERN NSString *const LTZLocalizationKitLanguageDidChangedKey;

#define LTZLocalizedString(key, comment) \
self.localStringDictionary ? self.localStringDictionary[[LTZLocalizationManager language]][(key)]:[LTZLocalizationManager localizedStringForKey:(key) value:@"" table:nil]

#define LTZLocalizedStringFromTable(key, tbl, comment) \
self.localStringDictionary ? self.localStringDictionary[[LTZLocalizationManager language]][(key)]:[LTZLocalizationManager localizedStringForKey:(key) value:@"" table:(tbl)]


typedef NS_ENUM(NSUInteger, LTZLocalizationType) {
    LTZLocalizationTypeSystem = 0,
    LTZLocalizationTypeDictionary
};

@interface LTZLocalizationManager : NSObject

@property (strong, nonatomic) NSBundle *bundle;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSDictionary *> *localStringDictionary;
@property (assign, nonatomic) LTZLocalizationType localizationType;
@property (copy, nonatomic) void (^languageDidChangedBlock) (NSString *language);

+ (void)initialize; //初始化语言文件

+ (LTZLocalizationManager *)sharedManager;

+ (NSBundle *)bundle;//获取当前资源文件

+ (NSString *)language;//获取应用当前语言

+ (void)setLanguage:(NSString *)language;//设置当前语言

+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)table;

+ (void)addNoticationBlock:(void (^)(NSString *))noticationBlock key:(NSString *)key;

+ (void)removeNoticationBlockWithKey:(NSString *)key;

@end
