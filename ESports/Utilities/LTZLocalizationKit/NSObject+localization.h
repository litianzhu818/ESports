//
//  NSObject+localization.h
//  LTZLocalizationKitDemo
//
//  Created by Peter Lee on 16/5/31.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTZLocalizationManager.h"

@interface NSObject (localization)

@property (strong, nonatomic) NSString *textTable;
@property (strong, nonatomic) NSString *textKey;
@property (assign, nonatomic) BOOL hasLocalizationObserver;
@property (copy,   nonatomic) void (^languageDidChangedBlock) (NSString *language);
@property (strong, nonatomic) NSDictionary<NSString *, NSDictionary *> *localStringDictionary;

- (void)setTextTable:(NSString *)textTable textKey:(NSString *)textKey;
- (void)addLanguageChangeNotificationObserver;
- (void)languageDidChanged;

- (id)localization_init;
- (void)localization_dealloc;

+ (void)exchangeMethodWithClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
