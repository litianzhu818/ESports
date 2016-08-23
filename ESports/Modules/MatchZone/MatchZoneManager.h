//
//  MatchZoneManager.h
//  ESports
//
//  Created by Peter Lee on 16/8/23.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonManager.h"

FOUNDATION_EXTERN NSString *const MatchZoneValueDidChangedKey;

@interface MatchZoneManager : NSObject

Single_interface(MatchZoneManager);

- (void)initialize;
- (NSString *)matchZoneId;
- (void)setMatchZoneId:(NSString *)matchZoneId;

@end
