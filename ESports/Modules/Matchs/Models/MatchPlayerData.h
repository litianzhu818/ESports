//
//  MatchPlayerData.h
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MatchTeamData.h"
/*
{
    MatchId = 3129;
    PlayerPerformanceList =     (
                                 {
                                     GameOrder = 1;
                                     IsTeamARedSide = 0;
                                     TeamAPlayersStatsList =             (
                                                                          {
                                                                              Assist = 2;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/11defb34-88cd-48b3-98ba-1f0a67bb996b.png";
                                                                              Cs15Min = 121;
                                                                              Death = 6;
                                                                              Kda = "0.666";
                                                                              Kill = 2;
                                                                              Name = Morning;
                                                                              PlayerId = 311;
                                                                              Role = "\U4e0a\U5355";
                                                                              RoleOrder = 1;
                                                                              TeamName = "J Team";
                                                                              Troll = 1;
                                                                          },
                                                                          {
                                                                              Assist = 1;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/16922cba-c76d-467b-9329-3fe8a739e640.png";
                                                                              Cs15Min = 86;
                                                                              Death = 4;
                                                                              Kda = 1;
                                                                              Kill = 3;
                                                                              Name = REFRA1N;
                                                                              PlayerId = 379;
                                                                              Role = "\U6253\U91ce";
                                                                              RoleOrder = 2;
                                                                              TeamName = "J Team";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 5;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/e7d16e4a-e595-4898-aa3d-a24a76bb19e5.png";
                                                                              Cs15Min = 131;
                                                                              Death = 2;
                                                                              Kda = 4;
                                                                              Kill = 3;
                                                                              Name = FoFo;
                                                                              PlayerId = 1608;
                                                                              Role = "\U4e2d\U8def";
                                                                              RoleOrder = 3;
                                                                              TeamName = "J Team";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 4;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/8d404ce3-5ef9-409d-9ba3-9f81eabe3506.png";
                                                                              Cs15Min = 109;
                                                                              Death = 5;
                                                                              Kda = 1;
                                                                              Kill = 1;
                                                                              Name = BeBe;
                                                                              PlayerId = 44;
                                                                              Role = ADC;
                                                                              RoleOrder = 4;
                                                                              TeamName = "J Team";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 6;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/d17f7506-c9e3-4b23-8a00-e431534129d6.png";
                                                                              Cs15Min = 22;
                                                                              Death = 6;
                                                                              Kda = 1;
                                                                              Kill = 0;
                                                                              Name = Jay;
                                                                              PlayerId = 212;
                                                                              Role = "\U8f85\U52a9";
                                                                              RoleOrder = 5;
                                                                              TeamName = "J Team";
                                                                              Troll = 1;
                                                                          }
                                                                          );
                                     TeamAWin = 0;
                                     TeamBPlayersStatsList =             (
                                                                          {
                                                                              Assist = 13;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/383e656b-40f1-4ff1-a551-c4f409eaa926.png";
                                                                              Cs15Min = 122;
                                                                              Death = 2;
                                                                              Kda = 7;
                                                                              Kill = 1;
                                                                              Name = MapleSnow;
                                                                              PlayerId = 287;
                                                                              Role = "\U4e0a\U5355";
                                                                              RoleOrder = 1;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 11;
                                                                              Carry = 1;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/848f5dc9-045b-4c7a-b514-687b8918f3b7.png";
                                                                              Cs15Min = 53;
                                                                              Death = 4;
                                                                              Kda = "4.25";
                                                                              Kill = 6;
                                                                              Name = WIND;
                                                                              PlayerId = 2762;
                                                                              Role = "\U6253\U91ce";
                                                                              RoleOrder = 2;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 19;
                                                                              Carry = 1;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/9d9ea32d-f1df-477c-9f44-b7c23a76e844.png";
                                                                              Cs15Min = 126;
                                                                              Death = 2;
                                                                              Kda = 12;
                                                                              Kill = 5;
                                                                              Name = MarS;
                                                                              PlayerId = 1587;
                                                                              Role = "\U4e2d\U8def";
                                                                              RoleOrder = 3;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 11;
                                                                              Carry = 1;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/0557fcd1-7631-4d46-ab11-4714a02c2220.png";
                                                                              Cs15Min = 138;
                                                                              Death = 1;
                                                                              Kda = 21;
                                                                              Kill = 10;
                                                                              Name = Raison;
                                                                              PlayerId = 375;
                                                                              Role = ADC;
                                                                              RoleOrder = 4;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 20;
                                                                              Carry = 1;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/6a9da82a-408d-480b-ac18-cc1f39794b04.png";
                                                                              Cs15Min = 23;
                                                                              Death = 0;
                                                                              Kda = 20;
                                                                              Kill = 0;
                                                                              Name = Olleh;
                                                                              PlayerId = 341;
                                                                              Role = "\U8f85\U52a9";
                                                                              RoleOrder = 5;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 0;
                                                                          }
                                                                          );
                                 },
                                 {
                                     GameOrder = 2;
                                     IsTeamARedSide = 1;
                                     TeamAPlayersStatsList =             (
                                                                          {
                                                                              Assist = 10;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7dd6d445-d019-4cdd-8310-fff6c23a81fd.png";
                                                                              Cs15Min = 128;
                                                                              Death = 0;
                                                                              Kda = 22;
                                                                              Kill = 1;
                                                                              Name = Morning;
                                                                              PlayerId = 311;
                                                                              Role = "\U4e0a\U5355";
                                                                              RoleOrder = 1;
                                                                              TeamName = "J Team";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 8;
                                                                              Carry = 1;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/4dda61a9-c1b3-4dd9-8cec-97a7b3f4f959.png";
                                                                              Cs15Min = 73;
                                                                              Death = 1;
                                                                              Kda = 13;
                                                                              Kill = 5;
                                                                              Name = REFRA1N;
                                                                              PlayerId = 379;
                                                                              Role = "\U6253\U91ce";
                                                                              RoleOrder = 2;
                                                                              TeamName = "J Team";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 9;
                                                                              Carry = 1;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/1ff09876-6cb7-4509-bc58-2cdd7ada846e.png";
                                                                              Cs15Min = 139;
                                                                              Death = 0;
                                                                              Kda = 40;
                                                                              Kill = 11;
                                                                              Name = FoFo;
                                                                              PlayerId = 1608;
                                                                              Role = "\U4e2d\U8def";
                                                                              RoleOrder = 3;
                                                                              TeamName = "J Team";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 10;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/8d404ce3-5ef9-409d-9ba3-9f81eabe3506.png";
                                                                              Cs15Min = 133;
                                                                              Death = 3;
                                                                              Kda = 5;
                                                                              Kill = 5;
                                                                              Name = BeBe;
                                                                              PlayerId = 44;
                                                                              Role = ADC;
                                                                              RoleOrder = 4;
                                                                              TeamName = "J Team";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 17;
                                                                              Carry = 1;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/6a9da82a-408d-480b-ac18-cc1f39794b04.png";
                                                                              Cs15Min = 21;
                                                                              Death = 2;
                                                                              Kda = "8.5";
                                                                              Kill = 0;
                                                                              Name = Jay;
                                                                              PlayerId = 212;
                                                                              Role = "\U8f85\U52a9";
                                                                              RoleOrder = 5;
                                                                              TeamName = "J Team";
                                                                              Troll = 0;
                                                                          }
                                                                          );
                                     TeamAWin = 1;
                                     TeamBPlayersStatsList =             (
                                                                          {
                                                                              Assist = 1;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/11defb34-88cd-48b3-98ba-1f0a67bb996b.png";
                                                                              Cs15Min = 103;
                                                                              Death = 3;
                                                                              Kda = "1.333";
                                                                              Kill = 3;
                                                                              Name = XiaoLiang;
                                                                              PlayerId = 2772;
                                                                              Role = "\U4e0a\U5355";
                                                                              RoleOrder = 1;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 2;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/16922cba-c76d-467b-9329-3fe8a739e640.png";
                                                                              Cs15Min = 57;
                                                                              Death = 5;
                                                                              Kda = "0.6";
                                                                              Kill = 1;
                                                                              Name = WIND;
                                                                              PlayerId = 2762;
                                                                              Role = "\U6253\U91ce";
                                                                              RoleOrder = 2;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 1;
                                                                          },
                                                                          {
                                                                              Assist = 1;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/e7d16e4a-e595-4898-aa3d-a24a76bb19e5.png";
                                                                              Cs15Min = 117;
                                                                              Death = 3;
                                                                              Kda = 1;
                                                                              Kill = 2;
                                                                              Name = MarS;
                                                                              PlayerId = 1587;
                                                                              Role = "\U4e2d\U8def";
                                                                              RoleOrder = 3;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 0;
                                                                          },
                                                                          {
                                                                              Assist = 4;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/0557fcd1-7631-4d46-ab11-4714a02c2220.png";
                                                                              Cs15Min = 122;
                                                                              Death = 6;
                                                                              Kda = "0.666";
                                                                              Kill = 0;
                                                                              Name = Raison;
                                                                              PlayerId = 375;
                                                                              Role = ADC;
                                                                              RoleOrder = 4;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 1;
                                                                          },
                                                                          {
                                                                              Assist = 5;
                                                                              Carry = 0;
                                                                              ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/e65c43f8-f4f8-4544-8a03-8e51b6435cc0.png";
                                                                              Cs15Min = 9;
                                                                              Death = 5;
                                                                              Kda = 1;
                                                                              Kill = 0;
                                                                              Name = Olleh;
                                                                              PlayerId = 341;
                                                                              Role = "\U8f85\U52a9";
                                                                              RoleOrder = 5;
                                                                              TeamName = "Hong Kong Esports";
                                                                              Troll = 1;
                                                                          }
                                                                          );
                                 }
                                 );
    TeamAInfo =     {
        Description = "<null>";
        Id = 36;
        Logo = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/8df62dd8-79fa-46fd-ae86-27264cea8a7e.png";
        Name = "J Team";
    };
    TeamAScore = 1;
    TeamBInfo =     {
        Description = "<null>";
        Id = 35;
        Logo = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/d2491852-0da7-4a8d-acd8-e6f7700811ce.png";
        Name = "Hong Kong Esports";
    };
    TeamBScore = 1;
}*/
@class MatchPlayerDetailData;
@protocol MatchPlayerDetailData
@end

@protocol MatchPlayerGameOrder
@end

@interface MatchPlayerData : JSONModel

@property (strong, nonatomic) NSString *matchId;
@property (strong, nonatomic) MatchTeam *teamAInfo;
@property (strong, nonatomic) MatchTeam *teamBInfo;
@property (strong, nonatomic) NSString *teamAScore;
@property (strong, nonatomic) NSString *teamBScore;
@property (strong, nonatomic) NSArray<MatchPlayerGameOrder> *gameOrders;

@end

@interface MatchPlayerGameOrder : JSONModel

@property (strong, nonatomic) NSString *gameOrder;
@property (assign, nonatomic) BOOL isTeamARedSide;
@property (assign, nonatomic) BOOL isTeamAWin;
@property (strong, nonatomic) NSArray<MatchPlayerDetailData> *teamAPlayerDetailDatas;
@property (strong, nonatomic) NSArray<MatchPlayerDetailData> *teamBPlayerDetailDatas;

@property (strong, nonatomic) NSArray<MatchPlayerDetailData *> *teamAllPlayerDetailDatas;

@property (assign, nonatomic) BOOL isExtend;

@end

@interface MatchPlayerDetailData : JSONModel

@property (strong, nonatomic) NSString *playerId;
@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSString *playerRole;
@property (strong, nonatomic) NSString *playerRoleOrder;
@property (strong, nonatomic) NSString *playerTeamName;

@property (assign, nonatomic) BOOL carry;
@property (assign, nonatomic) BOOL troll;
@property (strong, nonatomic) NSString *cs15Min;
@property (strong, nonatomic) NSString *kda;
@property (strong, nonatomic) NSString *kill;
@property (strong, nonatomic) NSString *death;
@property (strong, nonatomic) NSString *assist;
@property (strong, nonatomic) NSString *championImageUrl;

@end
