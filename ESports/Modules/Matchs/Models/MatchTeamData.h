//
//  MatchTeamData.h
//  ESports
//
//  Created by Peter Lee on 16/7/27.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/*
{
    GameOrder = 1;
    BlueTeamLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/75803aea-ee6d-4186-bf88-75b006d43c8a.png";
    RedTeamLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/8b74263f-658d-441b-b1a2-778876ff86c6.png";
    
    GameResults =     {
        Fb = 0;
        Fbaron = 0;
        Fd = 1;
        Fh = 0;
        Ft = 0;
        Win = 0;
    };
    
    BlueTeamGameStats =     {
        
        Dragon20 = 0;
        Tower20 = 2;
        GoldDiffAt25 = "0.7";
        Kill = "<null>";
        
        BannedChampions =         (
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/c9d720b7-f4e4-480f-b388-6c31f6158a4e.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7dd6d445-d019-4cdd-8310-fff6c23a81fd.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/2844cf15-4284-4704-bfdb-664397735102.png"
                                   );
        PickedChampions =         (
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/d9ffb234-adc2-4022-8575-583e2a8644ba.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/11defb34-88cd-48b3-98ba-1f0a67bb996b.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/16922cba-c76d-467b-9329-3fe8a739e640.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/6bf703df-97cf-4b89-adc2-d4ccd3f3c46c.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/3c5586db-8ab4-4075-8643-3ace6d65f485.png"
                                   );
    };
    RedTeamGameStats =     {
        
        Tower20 = 0;
        Dragon20 = 2;
        GoldDiffAt25 = "-0.7";
        Kill = "<null>";
        BannedChampions =         (
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/848f5dc9-045b-4c7a-b514-687b8918f3b7.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/383e656b-40f1-4ff1-a551-c4f409eaa926.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/049980b2-d43e-4166-af64-2166b18fbb6c.png"
                                   );
        
        PickedChampions =         (
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/d17f7506-c9e3-4b23-8a00-e431534129d6.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/05a054ab-d141-4834-a168-897e788ca69c.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/333401c7-7c25-44ed-92d6-438233f10f79.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/5b59065e-b4d3-41d2-aba3-7fff2b003cf2.png",
                                   "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/7b753635-add1-4e55-b8cd-2da2931ae18b.png"
                                   );
    };
}
*/

@class MatchTeamGameData;
@class MatchTeamGameResult;

@interface MatchTeamData : JSONModel

@property (strong, nonatomic) NSString *gameOrder;
@property (strong, nonatomic) NSString *buleTeamImageUrl;
@property (strong, nonatomic) NSString *redTeamImageUrl;
@property (strong, nonatomic) MatchTeamGameResult *teamGameResult;
@property (strong, nonatomic) MatchTeamGameData *blueTeamGameData;
@property (strong, nonatomic) MatchTeamGameData *redTeamGameData;

@property (assign, nonatomic) BOOL isExtend;

@end

@interface MatchTeamGameData : JSONModel

@property (assign, nonatomic) NSInteger dragon20;
@property (assign, nonatomic) NSInteger tower20;
@property (assign, nonatomic) double goldDiffAt25;
@property (assign, nonatomic) NSInteger kill;
@property (strong, nonatomic) NSArray<NSString *> *bannedChampions;
@property (strong, nonatomic) NSArray<NSString *> *pickedChampions;

@end

@interface MatchTeamGameResult : JSONModel

@property (assign, nonatomic) BOOL firstBlood;
@property (assign, nonatomic) BOOL firstTower;
@property (assign, nonatomic) BOOL firstDragon;
@property (assign, nonatomic) BOOL firstBigDragon;
@property (assign, nonatomic) BOOL firstVanguard;
@property (assign, nonatomic) BOOL firstAncientDragon;

@end
