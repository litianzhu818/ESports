//
//  MatchVideoData.h
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/*
{
    GameOrder = 1;
    MatchId = 3086;
    VideoUrlApp = "<null>";
}
 */

@interface MatchVideoData : JSONModel

@property (strong, nonatomic) NSString *gameOrder;
@property (strong, nonatomic) NSString *matchId;
@property (strong, nonatomic) NSString *videoUrlApp;

@end
