//
//  StrengScoreTeam.h
//  ESports
//
//  Created by Peter Lee on 16/8/9.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/*
{
    GlobalRanking: 1/2/3/4,
    Name: “Team Name”,
    Ranking: 1/2/3,
    RegionLogo: “http://cdn....../region/dafdsfsdf.png”,
    Strength: 1931,
    TeamId: 1,
    TeamLogo: “http://cdn...../team/dsfasdf.png”
}
 */

@interface StrengScoreTeam : JSONModel

@property (strong, nonatomic) NSString *teamId;
@property (strong, nonatomic) NSString *teamName;
@property (strong, nonatomic) NSString *teamImageUrl;
@property (strong, nonatomic) NSString *teamRanking;
@property (strong, nonatomic) NSString *teamGlobalRanking;
@property (strong, nonatomic) NSString *teamRegionImageUrl;
@property (strong, nonatomic) NSString *teamStrength;

@end
