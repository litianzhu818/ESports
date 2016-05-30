//
//  SystemConfig.m
//  QingChunApp
//
//  Created by  李天柱 on 14-10-22.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import "SystemConfig.h"

#define SYSTEM_IS_FIRST_LAUNCH @"system_is_first_launch"
#define WELCOME_IMAGE_URL @"welcome_image_url"
#define SYSTEM_HTTP_SESSION @"system_http_session"

@implementation SystemConfig
Single_implementation(SystemConfig);

//存取Session的值
-(void)SetSession:(NSData *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:SYSTEM_HTTP_SESSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSData *)GetSession
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:SYSTEM_HTTP_SESSION];
}

-(void)RemoveSession
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SYSTEM_HTTP_SESSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//存取FistLaunch的标志
-(void)SetFistLaunch:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:SYSTEM_IS_FIRST_LAUNCH];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)GetFistLaunch
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:SYSTEM_IS_FIRST_LAUNCH];
}

//存取欢迎界面图片的URL
-(void)SetWelcomeImageURL:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:WELCOME_IMAGE_URL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetWelcomeImageURL
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:WELCOME_IMAGE_URL];
}

@end
