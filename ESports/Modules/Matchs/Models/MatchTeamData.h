//
//  MatchTeamData.h
//  ESports
//
//  Created by Peter Lee on 16/7/27.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/*{
    GameDetailList =     (
                          {
                              GameOrder = 1;
                              IsTeamARedSide = 0;
                              TeamAGameResult =             {
                                  Fb = 0;
                                  Fbaron = 1;
                                  Fd = 0;
                                  Fe = 1;
                                  Fh = "<null>";
                                  Ft = 1;
                                  Win = 1;
                              };
                              TeamAGameStats =             {
                                  Assist = 43;
                                  BannedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/16922cba-c76d-467b-9329-3fe8a739e640.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/049980b2-d43e-4166-af64-2166b18fbb6c.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7b753635-add1-4e55-b8cd-2da2931ae18b.png"
                                                                     );
                                  Death = 16;
                                  Dragon20 = 0;
                                  GoldDiffAt25 = "0.8";
                                  Kill = 19;
                                  PickedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/a282824c-3cb9-4ac4-8dc0-468dc6cd32ab.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7dd6d445-d019-4cdd-8310-fff6c23a81fd.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/2844cf15-4284-4704-bfdb-664397735102.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/333401c7-7c25-44ed-92d6-438233f10f79.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/aca03d26-2658-44aa-a5b4-1e72fa61c09f.png"
                                                                     );
                                  Tower20 = 2;
                              };
                              TeamBGameStats =             {
                                  Assist = 43;
                                  BannedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/c9d720b7-f4e4-480f-b388-6c31f6158a4e.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/6bf703df-97cf-4b89-adc2-d4ccd3f3c46c.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/fa53848f-6fc2-4718-bb35-50944c619311.png"
                                                                     );
                                  Death = 19;
                                  Dragon20 = 2;
                                  GoldDiffAt25 = "-0.8";
                                  Kill = 16;
                                  PickedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/d9ffb234-adc2-4022-8575-583e2a8644ba.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/9cdfc309-face-4d68-9a83-80d8855656a6.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/383e656b-40f1-4ff1-a551-c4f409eaa926.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/5b59065e-b4d3-41d2-aba3-7fff2b003cf2.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/47d84a94-3354-4e88-bd55-6ab1732265b6.png"
                                                                     );
                                  Tower20 = 1;
                              };
                          },
                          {
                              GameOrder = 2;
                              IsTeamARedSide = 1;
                              TeamAGameResult =             {
                                  Fb = 1;
                                  Fbaron = 1;
                                  Fd = 0;
                                  Fe = "<null>";
                                  Fh = "<null>";
                                  Ft = 1;
                                  Win = 1;
                              };
                              TeamAGameStats =             {
                                  Assist = 34;
                                  BannedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/16922cba-c76d-467b-9329-3fe8a739e640.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/049980b2-d43e-4166-af64-2166b18fbb6c.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7b753635-add1-4e55-b8cd-2da2931ae18b.png"
                                                                     );
                                  Death = 6;
                                  Dragon20 = 0;
                                  GoldDiffAt25 = "5.3";
                                  Kill = 20;
                                  PickedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/6a9da82a-408d-480b-ac18-cc1f39794b04.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/11defb34-88cd-48b3-98ba-1f0a67bb996b.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/a282824c-3cb9-4ac4-8dc0-468dc6cd32ab.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/2844cf15-4284-4704-bfdb-664397735102.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/333401c7-7c25-44ed-92d6-438233f10f79.png"
                                                                     );
                                  Tower20 = 3;
                              };
                              TeamBGameStats =             {
                                  Assist = 12;
                                  BannedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7dd6d445-d019-4cdd-8310-fff6c23a81fd.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/aca03d26-2658-44aa-a5b4-1e72fa61c09f.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/fa53848f-6fc2-4718-bb35-50944c619311.png"
                                                                     );
                                  Death = 20;
                                  Dragon20 = 2;
                                  GoldDiffAt25 = "-5.3";
                                  Kill = 6;
                                  PickedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/e87a89d7-2e39-4c84-be4a-5748228d6e62.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/9eaf1396-692b-44d3-aeec-e3689a9790c9.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/c9d720b7-f4e4-480f-b388-6c31f6158a4e.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/5b59065e-b4d3-41d2-aba3-7fff2b003cf2.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/47d84a94-3354-4e88-bd55-6ab1732265b6.png"
                                                                     );
                                  Tower20 = 1;
                              };
                          },
                          {
                              GameOrder = 3;
                              IsTeamARedSide = 0;
                              TeamAGameResult =             {
                                  Fb = 1;
                                  Fbaron = 1;
                                  Fd = 0;
                                  Fe = "<null>";
                                  Fh = "<null>";
                                  Ft = 1;
                                  Win = 1;
                              };
                              TeamAGameStats =             {
                                  Assist = 46;
                                  BannedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/16922cba-c76d-467b-9329-3fe8a739e640.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/049980b2-d43e-4166-af64-2166b18fbb6c.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7b753635-add1-4e55-b8cd-2da2931ae18b.png"
                                                                     );
                                  Death = 8;
                                  Dragon20 = 0;
                                  GoldDiffAt25 = "8.699999999999999";
                                  Kill = 23;
                                  PickedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/d9ffb234-adc2-4022-8575-583e2a8644ba.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/6a9da82a-408d-480b-ac18-cc1f39794b04.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/05a054ab-d141-4834-a168-897e788ca69c.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7dd6d445-d019-4cdd-8310-fff6c23a81fd.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/fa53848f-6fc2-4718-bb35-50944c619311.png"
                                                                     );
                                  Tower20 = 4;
                              };
                              TeamBGameStats =             {
                                  Assist = 8;
                                  BannedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/c9d720b7-f4e4-480f-b388-6c31f6158a4e.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7dd6d445-d019-4cdd-8310-fff6c23a81fd.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/aca03d26-2658-44aa-a5b4-1e72fa61c09f.png"
                                                                     );
                                  Death = 23;
                                  Dragon20 = 1;
                                  GoldDiffAt25 = "-8.699999999999999";
                                  Kill = 8;
                                  PickedChampions =                 (
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/a282824c-3cb9-4ac4-8dc0-468dc6cd32ab.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/c8e3c1a6-5502-4cc8-bfc7-99eb7f382124.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/6bf703df-97cf-4b89-adc2-d4ccd3f3c46c.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/9d9ea32d-f1df-477c-9f44-b7c23a76e844.png",
                                                                     "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/47d84a94-3354-4e88-bd55-6ab1732265b6.png"
                                                                     );
                                  Tower20 = 0;
                              };
                          }
                          );
    MatchId = 3138;
    TeamAInfo =     {
        Description = "<null>";
        Id = 33;
        Logo = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/70f96aaa-d138-4fed-a3d3-c1ad2af7e878.png";
        Name = "ahq e-Sports Club";
    };
    TeamAScore = 3;
    TeamBInfo =     {
        Description = "<null>";
        Id = 35;
        Logo = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/d2491852-0da7-4a8d-acd8-e6f7700811ce.png";
        Name = "Hong Kong Esports";
    };
    TeamBScore = 0;
}*/


@class MatchTeam;
@class MatchTeamGameState;
@class MatchTeamGameResult;

@protocol MatchTeamGameOrder
@end

@interface MatchTeamData : JSONModel

@property (strong, nonatomic) NSString *matchId;
@property (assign, nonatomic) NSInteger teamAScore;
@property (assign, nonatomic) NSInteger teamBScore;
@property (strong, nonatomic) MatchTeam *teamAInfo;
@property (strong, nonatomic) MatchTeam *teamBInfo;

@property (strong, nonatomic) NSArray<MatchTeamGameOrder> *gameOrders;

@end


@interface MatchTeamGameOrder : JSONModel

@property (strong, nonatomic) NSString *gameOrder;
@property (assign, nonatomic) BOOL isATeamRedSide;
@property (strong, nonatomic) MatchTeamGameState *teamAGameState;
@property (strong, nonatomic) MatchTeamGameState *teamBGameState;

@property (strong, nonatomic) MatchTeamGameResult *teamAGameResult;

@property (assign, nonatomic) BOOL isExtend;

@end


@interface MatchTeamGameResult : JSONModel

@property (assign, nonatomic) BOOL firstBlood;
@property (assign, nonatomic) BOOL firstTower;
@property (assign, nonatomic) BOOL firstDragon;
@property (assign, nonatomic) BOOL firstBigDragon;
@property (assign, nonatomic) BOOL firstVanguard;
@property (assign, nonatomic) BOOL firstAncientDragon;
@property (assign, nonatomic) BOOL win;

@end


@interface MatchTeamGameState : JSONModel

@property (strong, nonatomic) NSString *teamAssist;
@property (strong, nonatomic) NSString *teamDeath;
@property (strong, nonatomic) NSString *teamDragon20;
@property (strong, nonatomic) NSString *teamGoldDiffAt25;
@property (strong, nonatomic) NSString *teamKill;
@property (strong, nonatomic) NSString *teamTower20;
@property (strong, nonatomic) NSArray *teamBannedChampions;
@property (strong, nonatomic) NSArray *PickedChampions;

@end

@interface MatchTeam : JSONModel

@property (strong, nonatomic) NSString *teamId;
@property (strong, nonatomic) NSString *teamName;
@property (strong, nonatomic) NSString *teamImageUrl;
@property (strong, nonatomic) NSString *teamDescription;

@end
