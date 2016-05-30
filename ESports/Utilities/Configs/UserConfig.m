//
//  UserConfig.m
//  QingChunApp
//
//  Created by  李天柱 on 14-10-22.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import "UserConfig.h"


@implementation UserConfig

+ (id)sharedInstance
{
    static UserConfig *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UserConfig alloc] init];
    });
    
    return _sharedInstance;
}

//存取用户基本信息的值
-(void)SetUserInfo:(id)value
{
    NSData *object = [NSKeyedArchiver archivedDataWithRootObject:value];
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:@"userInfoKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(id)GetUserInfo
{
    NSData *data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoKey"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (BOOL)removeUserInfo
{
    BOOL result = NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfoKey"];
    result = [[NSUserDefaults standardUserDefaults] synchronize];
    return  result;
}

- (void)SetHasLogin:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:value] forKey:@"hasLoginkey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)GetHasLogin
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"hasLoginkey"] boolValue];

}

//存取SessionId的值
-(void)SetSessionId:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"user_session_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetSessionId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user_session_id"];
}
-(void)RemoveSessionId
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_session_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
//User login name
-(void)SetUserName:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:qcdUserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:qcdUserName];
}

//存取用户密码的值
-(void)SetUserPassword:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:qcdUserPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetUserPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:qcdUserPassword];
}

//存取自动登录的值
-(void)SetAutoLogin:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:value] forKey:qcdUserAutoLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)GetAutoLogin
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:qcdUserAutoLogin] boolValue];
}

//存取用户head_url_prefix的值
-(void)SetHeadURLPrefix:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:qcdUserHeadURLPrefix];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetHeadURLPrefix
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:qcdUserHeadURLPrefix];
}

//存取用户image_url_prefix的值
-(void)SetImageURLPrefix:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:qcdImageURLPrefix];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetImageURLPrefix
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:qcdImageURLPrefix];
}

//存取用户Tencent的Token值
-(void)SetTencentToken:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:qcdUserTencentTokenStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetTencentToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:qcdUserTencentTokenStr];
}

//存取用户Weibo的Token值
-(void)SetWeiboToken:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:qcdUserWeiboTokenStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetWeiboToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:qcdUserWeiboTokenStr];
}
*/



@end
