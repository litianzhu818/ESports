//
//  PointsTeam.h
//  ESports
//
//  Created by Peter Lee on 16/8/8.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/*
{
    TeamId:7,
    TeamSrc: http://content/images /News Images 7/stix1.jpg,
    TeamName:J Gaming,
    Rank:01,
    Win:2,
    Draw:0,
    Loss:1
    Points:6
}
 */

@interface PointsTeam : JSONModel

@property (strong, nonatomic) NSString *pointsTeamId;
@property (strong, nonatomic) NSString *pointsTeamName;
@property (strong, nonatomic) NSString *pointsTeamImageUrl;
@property (strong, nonatomic) NSString *pointsRank;
@property (strong, nonatomic) NSString *pointsWin;
@property (strong, nonatomic) NSString *pointsDraw;
@property (strong, nonatomic) NSString *pointsLoss;
@property (strong, nonatomic) NSString *pointsScore;

@end
