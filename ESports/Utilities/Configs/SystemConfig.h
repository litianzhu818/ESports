//
//  SystemConfig.h
//  QingChunApp
//
//  Created by  李天柱 on 14-10-22.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonManager.h"


@interface SystemConfig : NSObject
Single_interface(SystemConfig);


//存取Session的值
-(void)SetSession:(NSData *)value;
-(NSData *)GetSession;
-(void)RemoveSession;

//存取FistLaunch的值
-(void)SetFistLaunch:(BOOL)value;
-(BOOL)GetFistLaunch;

//存取欢迎界面图片的URL
-(void)SetWelcomeImageURL:(NSString *)value;
-(NSString *)GetWelcomeImageURL;

//存取推送token
- (void)SetDeviceToken:(NSString *)value;
- (NSString *)GetDeviceToken;

@end
