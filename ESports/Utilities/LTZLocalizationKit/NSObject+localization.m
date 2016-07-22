//
//  NSObject+localization.m
//  LTZLocalizationKitDemo
//
//  Created by Peter Lee on 16/5/31.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "NSObject+localization.h"
#import <objc/runtime.h>

@implementation NSObject (localization)

#pragma mark - properties

- (void)setLocalStringDictionary:(NSDictionary<NSString *,NSDictionary *> *)localStringDictionary
{
    [self addLanguageChangeNotificationObserver];
    objc_setAssociatedObject(self, @selector(localStringDictionary), localStringDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary<NSString *,NSDictionary *> *)localStringDictionary
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHasLocalizationObserver:(BOOL)hasLocalizationObserver
{
    objc_setAssociatedObject(self, @selector(hasLocalizationObserver), @(hasLocalizationObserver), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hasLocalizationObserver
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setTextTable:(NSString *)textTable
{
    objc_setAssociatedObject(self, @selector(textTable), textTable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)textTable
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTextKey:(NSString *)textKey
{
    objc_setAssociatedObject(self, @selector(textKey), textKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)textKey
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLanguageDidChangedBlock:(void (^)(NSString *))languageDidChangedBlock
{
    objc_setAssociatedObject(self, @selector(languageDidChangedBlock), languageDidChangedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))languageDidChangedBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - public methods

- (void)setTextTable:(NSString *)textTable textKey:(NSString *)textKey
{
    self.textTable = textTable;
    self.textKey = textKey;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    if ([self respondsToSelector:@selector(setText:)]) {
        NSString *displayContent = self.textTable ? LTZLocalizedStringFromTable(self.textKey, self.textTable, nil):LTZLocalizedString(self.textKey, nil);
        if (displayContent.length > 0) {
            [self performSelector:@selector(setText:)
                       withObject:displayContent];
        }
    }
    
#pragma clang diagnostic pop
}


- (void)languageDidChanged
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    if ([self respondsToSelector:@selector(setText:)]) {
    
        NSString *displayContent = self.textTable ? LTZLocalizedStringFromTable(self.textKey, self.textTable, nil):LTZLocalizedString(self.textKey, nil);
        if (displayContent.length > 0) {
            [self performSelector:@selector(setText:)
                       withObject:displayContent];
        }
    }
    
#pragma clang diagnostic pop
        
    if (self.languageDidChangedBlock) {
        self.languageDidChangedBlock([LTZLocalizationManager language]);
    }
}


+ (void)exchangeMethodWithClass:(Class)class
               originalSelector:(SEL)originalSelector
               swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod){
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

#pragma mark - load method
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        /*
        SEL originalSelector = @selector(init);
        SEL swizzledSelector = @selector(localization_init);
        
        [class exchangeMethodWithClass:class
                      originalSelector:originalSelector
                      swizzledSelector:swizzledSelector];
         */
        
        SEL originalDeallocSelector = NSSelectorFromString(@"dealloc");
        SEL swizzledDeallocSelector = @selector(localization_dealloc);
        
        [class exchangeMethodWithClass:class
                      originalSelector:originalDeallocSelector
                      swizzledSelector:swizzledDeallocSelector];
        
        /*
        Class objectClass = object_getClass((id)self);
        SEL originalNewSelector = @selector(new);
        SEL swizzledNewSelector = @selector(localization_new);
        
        [class exchangeMethodWithClass:objectClass
                      originalSelector:originalNewSelector
                      swizzledSelector:swizzledNewSelector];
         */
        
    });
}

- (void)addLanguageChangeNotificationObserver
{
    if (!self.hasLocalizationObserver) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(languageDidChanged)
                                                     name:LTZLocalizationKitLanguageDidChangedKey
                                                   object:nil];
        self.hasLocalizationObserver = YES;
    }
}

#pragma mark - swizzling methods
/*
+ (id)localization_new
{
    id object = [[self class] localization_new];
    if (!self.hasLocalizationObserver) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(languageDidChanged)
                                                     name:LTZLocalizationKitLanguageDidChangedKey
                                                   object:nil];
        self.hasLocalizationObserver = YES;
    }
    //NSLog(@"%@:%@",NSStringFromClass([self class]),@"execute new from localization category");
    return object;
}
 */
- (id)localization_init
{
    id object = [self localization_init];
    
    if (!self.hasLocalizationObserver && ![NSStringFromClass([object class]) isEqualToString:@"_CFXNotificationTokenRegistration"]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(languageDidChanged)
                                                     name:LTZLocalizationKitLanguageDidChangedKey
                                                   object:nil];
        self.hasLocalizationObserver = YES;
    }
    
    //NSLog(@"%@:%@",NSStringFromClass([self class]),@"execute init from localization category");
    return object;
}

- (void)localization_dealloc
{
    if (self.hasLocalizationObserver) {
        @try {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:LTZLocalizationKitLanguageDidChangedKey
                                                          object:nil];
            self.localStringDictionary = nil;
        } @catch (NSException *exception) {
            
            
        } @finally {
            //NSLog(@"%@:%@",NSStringFromClass([self class]),@"execute dealloc from localization category");
        }
        
    }

    [self localization_dealloc];
}
@end
