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

- (void)requestNewsCarouselImagesWithOffset:(NSInteger)offset
                              numbersOfPage:(NSInteger)numbersOfPage
                                      block:(void (^)(id data, NSError *error))block;

@end
