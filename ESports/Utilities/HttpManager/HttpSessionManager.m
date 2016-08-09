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

#pragma mark - 新闻API

- (void)requestNewsCarouselImagesWithOffset:(NSInteger)offset
                              numbersOfPage:(NSInteger)numbersOfPage
                                      block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"start":@(offset),
                             @"limit":@(numbersOfPage)
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:newsCarouselImagsURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

- (void)requestHotfocusNewsWithOffset:(NSInteger)offset
                         limitsOfPage:(NSInteger)limitsOfPage
                                block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"start":@(offset),
                             @"limit":@(limitsOfPage)
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:hotfocusNewsURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];

}

- (void)requestTransferNewsWithOffset:(NSInteger)offset
                         limitsOfPage:(NSInteger)limitsOfPage
                                block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"start":@(offset),
                             @"limit":@(limitsOfPage)
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:transferNewsURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

- (void)requestHotwordsNewsWithOffset:(NSInteger)offset
                         limitsOfPage:(NSInteger)limitsOfPage
                                block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"start":@(offset),
                             @"limit":@(limitsOfPage)
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:hotwordsNewsURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

- (void)requestDetailNewsWithId:(NSString *)newsId
                          block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"id":newsId
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:detailNewsURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

#pragma mark - 赛事API
- (void)requestMatchProcessWithOffset:(NSInteger)offset
                        numbersOfPage:(NSInteger)numbersOfPage
                                block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"start":@(offset),
                             @"limit":@(numbersOfPage)
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:matchProcessURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}
- (void)requestMatchResultWithOffset:(NSInteger)offset
                       numbersOfPage:(NSInteger)numbersOfPage
                               block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"start":@(offset),
                             @"limit":@(numbersOfPage)
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:matchResultURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

- (void)requestMatchTeamDataWithMatchId:(NSString *)matchId
                                  block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"matchId":matchId
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:matchTeamDataURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

- (void)requestMatchPlayerDataWithMatchId:(NSString *)matchId
                                    block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"matchId":matchId
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:matchPlayerDataURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

- (void)requestMatchReplayVideoWithMatchId:(NSString *)matchId
                                     block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"matchId":matchId
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:matchReplayVideoURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}


#pragma mark - 积分API
- (void)requestMatchPointsTypeListWithBlock:(void (^)(id data, NSError *error))block
{
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:matchPointsTypeListURL
                                                   withParams:nil
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}
- (void)requestTeamListWithPointsTypeId:(NSString *)pointsTypeId
                                  block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"pointsTypeId":pointsTypeId
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:matchStandingListURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}


#pragma mark - 实力评级API
- (void)requestStrengthScoreTeamsListWithOffset:(NSInteger)offset
                                  numbersOfPage:(NSInteger)numbersOfPage
                                          block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"start":@(offset),
                             @"limit":@(numbersOfPage)
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:strengthScoreTeamsListURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

- (void)requestStrengthScorePlayersListWithOffset:(NSInteger)offset
                                    numbersOfPage:(NSInteger)numbersOfPage
                                            block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"start":@(offset),
                             @"limit":@(numbersOfPage)
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:strengthScorePlayersListURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

- (void)requestStrengthScoreTeamDetailWithTeamId:(NSString *)teamId
                                           block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"teamId":teamId
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:strengthScoreTeamsDetailURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
}

- (void)requestStrengthScorePlayerDetailWithPlayerId:(NSString *)playerId
                                               block:(void (^)(id data, NSError *error))block
{
    NSDictionary *params = @{
                             @"playerId":playerId
                             };
    
    [[HttpSessionClient sharedClient] requestJsonDataWithPath:strengthScorePlayersDetailURL
                                                   withParams:params
                                               withMethodType:HttpSessionTypeGET
                                                     andBlock:^(id data, NSError *error) {
                                                         if (data) {
                                                             block(data, nil);
                                                         }else{
                                                             block(nil, error);
                                                         }
                                                     }];
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
