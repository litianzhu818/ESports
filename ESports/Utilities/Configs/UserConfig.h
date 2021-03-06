//
//  UserConfig.h
//  QingChunApp
//
//  Created by  李天柱 on 14-10-22.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserConfig : NSObject

+ (id)sharedInstance;

//存取赛区信息
- (void)SetMatchZoneId:(NSString *)zoneId;
- (NSString *)GetMatchZoneId;

- (void)SetHasLogin:(BOOL)value;
- (BOOL)GetHasLogin;

- (void)SetUserName:(NSString *)name;
- (NSString *)GetUserName;

//存取用户基本信息的值
- (void)SetUserInfo:(id)value;
- (id)GetUserInfo;
- (BOOL)removeUserInfo;

//存取SessionId的值
-(void)SetSessionId:(NSString *)value;
-(NSString *)GetSessionId;
-(void)RemoveSessionId;


//User login name
-(void)SetUserName:(NSString *)value;
-(NSString *)GetUserName;

//存取用户密码的值
-(void)SetUserPassword:(NSString *)value;
-(NSString *)GetUserPassword;

//存取自动登录的值
-(void)SetAutoLogin:(BOOL)value;
-(BOOL)GetAutoLogin;

//存取用户head_url_prefix的值
-(void)SetHeadURLPrefix:(NSString *)value;
-(NSString *)GetHeadURLPrefix;

//存取用户image_url_prefix的值
-(void)SetImageURLPrefix:(NSString *)value;
-(NSString *)GetImageURLPrefix;

//存取用户Tencent的Token值
-(void)SetTencentToken:(NSString *)value;
-(NSString *)GetTencentToken;

//存取用户Weibo的Token值
-(void)SetWeiboToken:(NSString *)value;
-(NSString *)GetWeiboToken;


/*************************************天天赢数据****************************/



@end
