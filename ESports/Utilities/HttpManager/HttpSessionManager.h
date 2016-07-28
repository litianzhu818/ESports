//
//  HttpRequestManager.h
//  QingChunApp
//
//  Created by  李天柱 on 14/12/30.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HttpSessionManager : NSObject

+ (id)sharedInstance;

#pragma mark - 新闻API
- (void)requestNewsCarouselImagesWithOffset:(NSInteger)offset
                              numbersOfPage:(NSInteger)numbersOfPage
                                      block:(void (^)(id data, NSError *error))block;

- (void)requestHotfocusNewsWithOffset:(NSInteger)offset
                         limitsOfPage:(NSInteger)limitsOfPage
                                block:(void (^)(id data, NSError *error))block;

- (void)requestTransferNewsWithOffset:(NSInteger)offset
                         limitsOfPage:(NSInteger)limitsOfPage
                                block:(void (^)(id data, NSError *error))block;

- (void)requestHotwordsNewsWithOffset:(NSInteger)offset
                         limitsOfPage:(NSInteger)limitsOfPage
                                block:(void (^)(id data, NSError *error))block;

- (void)requestDetailNewsWithId:(NSString *)newsId
                          block:(void (^)(id data, NSError *error))block;

#pragma mark - 赛事API
- (void)requestMatchProcessWithOffset:(NSInteger)offset
                        numbersOfPage:(NSInteger)numbersOfPage
                                block:(void (^)(id data, NSError *error))block;

- (void)requestMatchResultWithOffset:(NSInteger)offset
                       numbersOfPage:(NSInteger)numbersOfPage
                               block:(void (^)(id data, NSError *error))block;

- (void)requestMatchTeamDataWithMatchId:(NSString *)matchId
                                  block:(void (^)(id data, NSError *error))block;

- (void)requestMatchPlayerDataWithMatchId:(NSString *)matchId
                                    block:(void (^)(id data, NSError *error))block;

- (void)requestMatchReplayVideoWithMatchId:(NSString *)matchId
                                     block:(void (^)(id data, NSError *error))block;
@end
