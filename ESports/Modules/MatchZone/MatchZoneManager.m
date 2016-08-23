//
//  MatchZoneManager.m
//  ESports
//
//  Created by Peter Lee on 16/8/23.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchZoneManager.h"
#import "UserConfig.h"

NSString *const MatchZoneValueDidChangedKey = @"match_zone_manager_value_did_changed_key";

@implementation MatchZoneManager
Single_implementation(MatchZoneManager);

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initialize
{
    NSString *matchZoneId = [[UserConfig sharedInstance] GetMatchZoneId];
    
    if (!matchZoneId) {
        [self _setMatchZoneId:@"50" sendNotification:NO];
    }
}

- (void)setMatchZoneId:(NSString *)matchZoneId
{
    [self _setMatchZoneId:matchZoneId sendNotification:YES];
}

- (NSString *)matchZoneId
{
    NSString *matchZoneId = [[UserConfig sharedInstance] GetMatchZoneId];
    
    if (!matchZoneId) {
        matchZoneId = @"50";
        [self _setMatchZoneId:matchZoneId sendNotification:NO];
    }

    return matchZoneId;
}

- (void)_setMatchZoneId:(NSString *)matchZoneId sendNotification:(BOOL)sendNotification
{
    if ([matchZoneId isEqualToString:[[UserConfig sharedInstance] GetMatchZoneId]]) return;
    
    [[UserConfig sharedInstance] SetMatchZoneId:matchZoneId];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"preferred_region" forKey:NSHTTPCookieName];
    [cookieProperties setObject:matchZoneId forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"lol.esportsmatrix.com" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"lol.esportsmatrix.com" forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    if (sendNotification) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MatchZoneValueDidChangedKey object:matchZoneId];
    }
}

@end
