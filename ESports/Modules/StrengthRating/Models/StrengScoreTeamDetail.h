//
//  StrengScoreTeamDetail.h
//  ESports
//
//  Created by Peter Lee on 16/8/10.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/*
{
    TeamId: 1,
    Name: “SKT Telecom T1”,
    TeamLogo: “http://cdn....../team/fdfasdf.png”,
    GlobalRanking: 1,
    Ranking: 1,
    RegionLogo: “http://cdn...../region/sdfasda.png”,
    RegionName: “韩国”
    WinRate: 72,
    Fb: 32,
    Ft: 52,
    Fd: 80,
    Fbaron: 70.833,
    Fh: 73.684,
    Strength: 1931,
    PlayerList:[
                {
                    Id: 39,
                    Name: “Bang”,
                    Logo: “http:cdn..../player/sdfasdf.png”
                },
                ....
                ],
    StrengthList:[
                  1931,
                  1917,
                  1903,
                  1886,
                  ......
                  ]
}
*/

@protocol StrengScoreTeamPlayer
@end


@interface StrengScoreTeamDetail : JSONModel

@property (strong, nonatomic) NSString *teamId;
@property (strong, nonatomic) NSString *teamName;
@property (strong, nonatomic) NSString *teamImageUrl;
@property (strong, nonatomic) NSString *teamRanking;
@property (strong, nonatomic) NSString *teamGlobalRanking;
@property (strong, nonatomic) NSString *teamRegionImageUrl;
@property (strong, nonatomic) NSString *teamRegionName;
@property (strong, nonatomic) NSString *teamParentRegionId;

@property (assign, nonatomic) NSInteger teamWinRate;
@property (assign, nonatomic) NSInteger teamFb;
@property (assign, nonatomic) NSInteger teamFt;
@property (assign, nonatomic) NSInteger teamFd;
@property (assign, nonatomic) NSInteger teamFh;
@property (assign, nonatomic) NSInteger teamFbaron;
@property (assign, nonatomic) NSInteger teamStrength;

@property (strong, nonatomic) NSArray<StrengScoreTeamPlayer> *teamPlayers;
@property (strong, nonatomic) NSArray *teamStrengths;

@end

/*
{
    Description = "<null>";
    Id = 174;
    Logo = "http://cdn.esportsmatrix.com/Content/images/uploaded/player/61aeab6b-80c2-43b2-8bd5-0f7a31937564.jpg";
    Name = GorillA;
    RoleId = 4;
}
 */
@interface StrengScoreTeamPlayer : JSONModel

@property (strong, nonatomic) NSString *playerId;
@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSString *playerImageUrl;
@property (strong, nonatomic) NSString *playerRoleId;
@property (strong, nonatomic) NSString *playerDescription;

@end
