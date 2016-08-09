//
//  StrengScorePlayer.h
//  ESports
//
//  Created by Peter Lee on 16/8/9.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/*
{
    GlobalRanking: 1/2/3/4,
    PlayerName: “Faker”,
    Ranking: 1/2/3,
    RegionLogo: “http://cdn....../region/dafdsfsdf.png”,
    Price: 123123123,
    Strength: 1931,
    PlayerId: 1,
    PlayerLogo: “http://cdn...../team/dsfasdf.png”
}
 */

@interface StrengScorePlayer : JSONModel

@property (strong, nonatomic) NSString *playerId;
@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSString *playerImageUrl;
@property (strong, nonatomic) NSString *playerRanking;
@property (strong, nonatomic) NSString *playerGlobalRanking;
@property (strong, nonatomic) NSString *playerRegionImageUrl;
@property (strong, nonatomic) NSString *playerStrength;
@property (strong, nonatomic) NSString *playerPrice;

@end
