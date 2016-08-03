//
//  MatchPlayerData.h
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/*
{
    BlueTeamPlayersStatsList =     (
                                    {
                                        Carry = 0;
                                        ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/11defb34-88cd-48b3-98ba-1f0a67bb996b.png";
                                        Cs15Min = 108;
                                        Kda = 14;
                                        Name = GimGoon;
                                        PlayerId = 165;
                                        Role = "\U4e0a\U5355";
                                        Troll = 0;
                                    },
                                    {
                                        Carry = 1;
                                        ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/9d9ea32d-f1df-477c-9f44-b7c23a76e844.png";
                                        Cs15Min = 145;
                                        Kda = 9;
                                        Name = Republic;
                                        PlayerId = 383;
                                        Role = "\U4e2d\U8def";
                                        Troll = 0;
                                    },
                                    {
                                        Carry = 0;
                                        ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/5b59065e-b4d3-41d2-aba3-7fff2b003cf2.png";
                                        Cs15Min = 22;
                                        Kda = "4.666";
                                        Name = Savoki;
                                        PlayerId = 401;
                                        Role = "\U8f85\U52a9";
                                        Troll = 0;
                                    },
                                    {
                                        Carry = 0;
                                        ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/848f5dc9-045b-4c7a-b514-687b8918f3b7.png";
                                        Cs15Min = 64;
                                        Kda = "1.857";
                                        Name = WuShuang;
                                        PlayerId = 538;
                                        Role = "\U6253\U91ce";
                                        Troll = 0;
                                    }
                                    );
    GameOrder = 1;
    RedTeamPlayersStatsList =     (
                                   {
                                       Carry = 0;
                                       ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/9cdfc309-face-4d68-9a83-80d8855656a6.png";
                                       Cs15Min = 133;
                                       Kda = "3.666";
                                       Name = dade;
                                       PlayerId = 99;
                                       Role = "\U4e2d\U8def";
                                       Troll = 0;
                                   },
                                   {
                                       Carry = 0;
                                       ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/2844cf15-4284-4704-bfdb-664397735102.png";
                                       Cs15Min = 61;
                                       Kda = "2.4";
                                       Name = Swift;
                                       PlayerId = 450;
                                       Role = "\U6253\U91ce";
                                       Troll = 1;
                                   },
                                   {
                                       Carry = 0;
                                       ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/d17f7506-c9e3-4b23-8a00-e431534129d6.png";
                                       Cs15Min = 15;
                                       Kda = 2;
                                       Name = Mor;
                                       PlayerId = 457;
                                       Role = "\U8f85\U52a9";
                                       Troll = 0;
                                   },
                                   {
                                       Carry = 0;
                                       ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/d9ffb234-adc2-4022-8575-583e2a8644ba.png";
                                       Cs15Min = 133;
                                       Kda = "3.333";
                                       Name = Peco;
                                       PlayerId = 461;
                                       Role = ADC;
                                       Troll = 0;
                                   },
                                   {
                                       Carry = 0;
                                       ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/383e656b-40f1-4ff1-a551-c4f409eaa926.png";
                                       Cs15Min = 87;
                                       Kda = "3.333";
                                       Name = V;
                                       PlayerId = 471;
                                       Role = "\U4e0a\U5355";
                                       Troll = 0;
                                   }
                                   );
}
*/
@class MatchPlayerDetailData;

@protocol MatchPlayerDetailData
@end

@interface MatchPlayerData : JSONModel

@property (strong, nonatomic) NSString *gameOrder;
@property (strong, nonatomic) NSArray<MatchPlayerDetailData> *bluePlayersDetailData;
@property (strong, nonatomic) NSArray<MatchPlayerDetailData> *redPlayersDetailData;
@property (strong, nonatomic) NSArray<MatchPlayerDetailData *> *playersDetailDatas;
@property (assign, nonatomic) BOOL isExtend;

@end
/*
{
    Carry = 0;
    //ChampionLogo = "http://cdn.esportsmatrix.com/Content/images/uploaded/champion/383e656b-40f1-4ff1-a551-c4f409eaa926.png";
    Cs15Min = 87;
    Kda = "3.333";
    //Name = V;
    //PlayerId = 471;
    //Role = "\U4e0a\U5355";
    Troll = 0;
}*/
@interface MatchPlayerDetailData : JSONModel

@property (strong, nonatomic) NSString *playerId;
@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSString *playerRole;
@property (strong, nonatomic) NSString *playerImageUrl;

@property (assign, nonatomic) BOOL carry;
@property (assign, nonatomic) BOOL troll;
@property (strong, nonatomic) NSString *cs15Min;
@property (strong, nonatomic) NSString *kda;


@end
