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
 {
    GlobalRanking = 20;
    PlayerId = 419;
    PlayerLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/player/4bac4289-9f05-47c0-903b-ecd81507f143.jpg";
    PlayerName = Smeb;
    Price = 14356526;
    Ranking = 20;
    RegionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/region/7d7f87f0-2648-4a18-b726-a705db19805d.png";
    RegionRanking = 5;
    RoleId = 1;
    Strength = 1865;
    TeamParentRegionId = 45;
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
@property (strong, nonatomic) NSString *playerRoleId;
@property (strong, nonatomic) NSString *playerTeamParentRegionId;
@property (strong, nonatomic) NSString *playerRegionRanking;

@end
