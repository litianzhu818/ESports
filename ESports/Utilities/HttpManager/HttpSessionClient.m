//
//  HttpSessionClient.m
//  AFNetworking iOS Example
//
//  Created by Peter Lee on 14/12/31.
//  Copyright (c) 2014年 Gowalla. All rights reserved.
//

#import "HttpSessionClient.h"
#import "NSObject+Custom.h"
#import "SystemConfig.h"
#import "UserConfig.h"
#import "HttpSessionClient+MultiLanguage.h"

@implementation HttpSessionClient

+ (id)sharedClient
{
    static HttpSessionClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HttpSessionClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

+ (void)saveCookieData
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        // Here I see the correct rails session cookie
        LOG(@"\nSave cookie: \n====================\n%@", cookie);
    }
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    [[SystemConfig sharedInstance] SetSession:cookiesData];
}

+ (void)removeCookieData
{
    NSURL *url = [NSURL URLWithString:LoginURL];
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            LOG(@"\nDelete cookie: \n====================\n%@", cookie);
        }
    }
    [[SystemConfig sharedInstance] RemoveSession];
}



#pragma mark - private methods

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html", nil];
        
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        self.securityPolicy.allowInvalidCertificates = YES;
                
        NSOperationQueue *operationQueue = self.operationQueue;
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
        
        [self.reachabilityManager startMonitoring];
    }
    
    return self;
}


#pragma mark - class public request method
+ (id)requestJsonDataWithPath:(NSString *)aPath
                   withParams:(NSDictionary*)params
               withMethodType:(HttpSessionType)sessionType
                     andBlock:(void (^)(id data, NSError *error))block
{
    return [[HttpSessionClient sharedClient] requestJsonDataWithPath:aPath
                                                          withParams:params
                                                      withMethodType:sessionType
                                                            andBlock:block];
}

+ (id)uploadImage:(UIImage *)image
             path:(NSString *)path
       withParams:(NSDictionary*)params
         progress:(NSProgress * __autoreleasing *)progress
     successBlock:(void (^)(NSURLSessionUploadTask *task, id responseObject))success
     failureBlock:(void (^)(NSURLSessionUploadTask *task, NSError *error))failure
{
    return [[HttpSessionClient sharedClient] uploadImage:image
                                                    path:path
                                              withParams:params
                                                progress:progress
                                            successBlock:success
                                            failureBlock:failure];
}


#pragma mark - public request method

- (NSURLSessionDataTask *)requestJsonDataWithPath:(NSString *)aPath
                                       withParams:(NSDictionary*)params
                                   withMethodType:(HttpSessionType)sessionType
                                         andBlock:(void (^)(id data, NSError *error))block
{
    //log请求数据
    NSLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    aPath = [self locationPathWithSubPath:aPath];
    
    NSURLSessionDataTask *urlSessionDataTask = nil;
    
    //发起请求
    switch (sessionType) {
        case HttpSessionTypeGET:
        {
            urlSessionDataTask = [self GET:aPath
                                parameters:params
                                  progress:^(NSProgress * _Nonnull downloadProgress) {
                                      
                                  }
                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       NSError *error = nil;
                                       id tempdata = [self handleResponse:responseObject error:&error];
                                       if (error) {
                                           [self showError:error];
                                           block(nil, error);
                                       }else{
                                           block(tempdata, nil);
                                       }
                                  }
                                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       [self showError:error];
                                       block(nil, error);
                                   }];
            
            break;
        }
            
        case HttpSessionTypePOST:
        {
            urlSessionDataTask = [self POST:aPath
                                 parameters:params
                                   progress:^(NSProgress * _Nonnull uploadProgress) {
                                       
                                   }
                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        LOG(@"\n%@===========response===========:\n%@", aPath, responseObject);
                                        NSError *error = nil;
                                        id tempdata = [self handlePostResponse:responseObject error:&error];
                                        
                                        if (error) {
                                            //[self showError:error];
                                            block(nil, error);
                                        }else{
                                            
                                             if (![aPath isEqualToString:LoginURL]) {
                                                 [HttpSessionClient saveCookieData];
                                             }
                                            
                                            block(tempdata, nil);
                                        }
                                    }
                                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                        //[self showError:error];
                                        block(nil, error);
                                    }];
            break;
        }
            
        case HttpSessionTypePUT:
        {
            urlSessionDataTask = [self PUT:aPath
                                parameters:params
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       LOG(@"\n%@===========response===========:\n%@", aPath, responseObject);
                                       NSError *error = nil;
                                       id tempdata = [self handleResponse:responseObject error:&error];
                                       if (error) {
                                           [self showError:error];
                                           block(nil, error);
                                       }else{
                                           block(tempdata, nil);
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       [self showError:error];
                                       block(nil, error);
                                   }];
            break;
        }
            
        case HttpSessionTypeDELETE:
        {
            urlSessionDataTask = [self DELETE:aPath
                                   parameters:params
                                      success:^(NSURLSessionDataTask *task, id responseObject) {
                                          LOG(@"\n%@===========response===========:\n%@", aPath, responseObject);
                                          NSError *error = nil;
                                          id tempdata = [self handleResponse:responseObject error:&error];
                                          if (error) {
                                              [self showError:error];
                                              block(nil, error);
                                          }else{
                                              block(tempdata, nil);
                                          }
                                          
                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                          [self showError:error];
                                          block(nil, error);
                                      }];
            break;
        }
        default:
            break;
    }
    
    return urlSessionDataTask;
}

- (NSURLSessionUploadTask *)uploadImage:(UIImage *)image
                                   path:(NSString *)path
                             withParams:(NSDictionary*)params
                               progress:(NSProgress * __autoreleasing *)progress
                           successBlock:(void (^)(NSURLSessionUploadTask *task, id responseObject))success
                           failureBlock:(void (^)(NSURLSessionUploadTask *task, NSError *error))failure
{
    float maxSizeOfImage = 500.0;// 允许上传到图片的最大的质量大小
    NSUInteger SIZE_PER_K_BIT = 1024;// 每一KB所用字节数
    
    // 如果图片占用的内存太大，就压缩，让其小于500k
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (((float)imageData.length / SIZE_PER_K_BIT) > maxSizeOfImage) {
        imageData = UIImageJPEGRepresentation(image, ((SIZE_PER_K_BIT * maxSizeOfImage) / (float)imageData.length));
    }
    
    // init a temp file name accord to the user name and system time
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *timeStr = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", [[UserConfig sharedInstance] GetUserName], timeStr];
    
    NSLog(@"uploadImageSize: %.0f", ((float)imageData.length / SIZE_PER_K_BIT));
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:path
                                                                                             parameters:params
                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                  [formData appendPartWithFileData:imageData
                                                                                                              name:@"fileData"
                                                                                                          fileName:fileName
                                                                                                          mimeType:@"image/jpeg"];
                                                                                  
                                                                              } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
                                                                    progress:^(NSProgress * _Nonnull uploadProgress) {
                                                                        
                                                                    }
                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            [self showError:error];
            failure(uploadTask,error);
        } else {
            success(uploadTask,responseObject);

        }
                                                                  
    }];
        
    [uploadTask resume];
    
    return uploadTask;
}

/*//Creating an Upload Task for a Multi-Part Request, with Progress
 NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
 [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
 } error:nil];
 
 AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
 NSProgress *progress = nil;
 
 NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
 if (error) {
 NSLog(@"Error: %@", error);
 } else {
 NSLog(@"%@ %@", response, responseObject);
 }
 }];
 
 [uploadTask resume];
 */

/*//Creating a Download Task
 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
 AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
 
 NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
 NSURLRequest *request = [NSURLRequest requestWithURL:URL];
 
 NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
 NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
 return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
 } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
 NSLog(@"File downloaded to: %@", filePath);
 }];
 [downloadTask resume];
*/

/*//Creating a Data Task
 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
 AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
 
 NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
 NSURLRequest *request = [NSURLRequest requestWithURL:URL];
 
 NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
 if (error) {
 NSLog(@"Error: %@", error);
 } else {
 NSLog(@"%@ %@", response, responseObject);
 }
 }];
 [dataTask resume];
 */

@end
