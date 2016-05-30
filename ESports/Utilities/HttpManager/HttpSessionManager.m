//
//  HttpRequestManager.m
//  QingChunApp
//
//  Created by  李天柱 on 14/12/30.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import "HttpSessionManager.h"
#import "HttpSessionClient.h"

@implementation HttpSessionManager

+ (id)sharedInstance
{
    static HttpSessionManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    
    return _sharedManager;
}

//- (void)loginWithIdentifier:(NSString *)identifier
//                     params:(id)params
//                      block:(void (^)(id data, NSError *error))block
//{
//    
////    NSString *checksumStr = [NSString stringWithFormat:@"%@%@%@%@%@",identifier,[params objectForKey:@"openid"],[params objectForKey:@"token"],[params objectForKey:@"userName"],[[SystemConfig sharedInstance] GetCheckSumSecret]];
//    
//    [params setObject:identifier forKey:@"identifier"];
//    [params setObject:SHA1StringWith([NSString stringWithFormat:@"%@%@%@%@%@",
//                                      identifier,
//                                      [params objectForKey:@"openid"],
//                                      [params objectForKey:@"token"],
//                                      [params objectForKey:@"userName"],
//                                      @""]
//                                     )
//               forKey:@"checksum"];
//    
//    [[HttpSessionClient sharedClient] requestJsonDataWithPath:QCD_LOGIN_PATH_STRING_IOS
//                                                   withParams:params
//                                               withMethodType:HttpSessionTypePOST
//                                                     andBlock:^(id data, NSError *error) {
//                                                         
//                                                         if (data) {
//                                                             
//                                                             block(data,nil);
//                                                             
//                                                         }else{
//                                                             block(nil,error);
//                                                         }
//                                                         
//                                                     }];
//}

@end
