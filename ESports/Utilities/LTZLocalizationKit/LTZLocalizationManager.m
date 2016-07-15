//
//  LTZLocalizationManager.m
//  LTZLocalizationKit
//
//  Created by Peter Lee on 16/5/30.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "LTZLocalizationManager.h"

NSString *const LTZLocalizationKitUserLanguageKey = @"LTZLocalizationKit_User_Language_Key";
NSString *const LTZLocalizationKitLanguageDidChangedKey = @"LTZLocalizationKit_Language_Did_Changed_Key";

@interface LTZLocalizationManager ()
{
    NSBundle *_bundle;
    NSString *_language;
}

@property (strong, nonatomic) NSMutableDictionary <NSString *, void (^)(NSString *)> *changedBlocks;

@end

@implementation LTZLocalizationManager
@synthesize bundle = _bundle;
@synthesize language = _language;

+ (LTZLocalizationManager *)sharedManager
{
    static LTZLocalizationManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

+ (void)initialize
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currentlanguage = [userDefaults valueForKey:LTZLocalizationKitUserLanguageKey];
    
    if(currentlanguage.length < 1){
        
        //获取系统当前语言版本
        //NSArray* languages = [userDefaults objectForKey:@"AppleLanguages"];
        NSArray *languages = [NSLocale preferredLanguages];
        currentlanguage = [languages objectAtIndex:0];

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE90_
        NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
        NSString * suffix = [NSString stringWithFormat:@"-%@",countryCode];
        
        if ([currentlanguage hasSuffix:suffix]) {//例如-CN
            currentlanguage =  [currentlanguage stringByReplacingOccurrencesOfString:suffix withString:@""];
        }
#endif
        
        [userDefaults setValue:currentlanguage forKey:LTZLocalizationKitUserLanguageKey];
        [userDefaults synchronize];
    }
}

+ (NSBundle *)bundle
{
    return [[LTZLocalizationManager sharedManager] bundle];
}

+ (NSString *)language
{
    return [[LTZLocalizationManager sharedManager] language];
}

+ (void)setLanguage:(NSString *)language
{
    [[LTZLocalizationManager sharedManager] setLanguage:language];
}

+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)table
{
    if ([[LTZLocalizationManager sharedManager] localizationType] == LTZLocalizationTypeDictionary) {
        NSString *languageKey = [LTZLocalizationManager language];
        NSString *displayString = nil;
        if (table) {
            NSDictionary *dic = [LTZLocalizationManager sharedManager].localStringDictionary[table];
            if (dic) {
                displayString = dic[languageKey][key];
            }else{
                displayString = [LTZLocalizationManager sharedManager].localStringDictionary[languageKey][key];
            }
        }else{
            displayString = [LTZLocalizationManager sharedManager].localStringDictionary[languageKey][key];
        }
        if (!displayString) {
            displayString = key;
        }
        return displayString;
    }
    return [[[LTZLocalizationManager sharedManager] bundle] localizedStringForKey:key value:value table:table];
}

+ (void)addNoticationBlock:(void (^)(NSString *))noticationBlock key:(NSString *)key
{
    if (noticationBlock && key) {
        [[LTZLocalizationManager sharedManager].changedBlocks setValue:noticationBlock forKey:key];
    }
}
+ (void)removeNoticationBlockWithKey:(NSString *)key
{
    if (key) {
        [[LTZLocalizationManager sharedManager].changedBlocks removeObjectForKey:key];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.localizationType = LTZLocalizationTypeSystem;
        self.changedBlocks = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSString *)language
{
    if (!_language) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _language = [userDefaults valueForKey:LTZLocalizationKitUserLanguageKey];
        
        if (_language.length < 1) {
            NSArray *languages = [NSLocale preferredLanguages];
            _language = [languages objectAtIndex:0];
            [userDefaults setValue:_language forKey:LTZLocalizationKitUserLanguageKey];
            [userDefaults synchronize];
        }

    }
    
    return _language;
}

- (void)setLanguage:(NSString *)language
{
    _language = language;
    
    _bundle = nil;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:_language forKey:LTZLocalizationKitUserLanguageKey];
    [userDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LTZLocalizationKitLanguageDidChangedKey object:language];
    if (self.languageDidChangedBlock) {
        self.languageDidChangedBlock(_language);
    }
    
    [self.changedBlocks enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, void (^ _Nonnull obj)(NSString *), BOOL * _Nonnull stop) {
        obj(_language);
    }];
}

- (NSBundle *)bundle
{
    if (!_bundle) {
        //获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:self.language ofType:@"lproj"];
        _bundle = [NSBundle bundleWithPath:path];//生成bundle
    }
    
    return _bundle;
}

- (void)dealloc
{
    [self.changedBlocks removeAllObjects];
    self.changedBlocks = nil;
}

@end
