//
//  ResultMatchesManager.h
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class ResultMatch;
@class ResultMatchesContainer;

@interface ResultMatchesManager : JSONModel

@property (strong, nonatomic) NSMutableArray<ResultMatchesContainer *> *resultMatchesContainers;

- (NSIndexPath *)addResultMatch:(ResultMatch *)resultMatch;
- (void)addResultMatchesContainer:(ResultMatchesContainer *)resultMatchesContainer;
- (void)removeAllObjects;

@end

@interface ResultMatchesContainer : JSONModel

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSMutableArray<ResultMatch *> *resultMatches;

- (instancetype)initWithResultMatch:(ResultMatch *)resultMatch;
- (void)addResultMatch:(ResultMatch *)resultMatch;

@end

/*
 AScore = 1;
 ATeamId = 38;
 ATeamName = "Machi eSports";
 ATeamSrc = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/1e1d41a4-d307-430c-a793-09717be74499.png";
 BScore = 1;
 BTeamId = 37;
 BTeamName = "Midnight Sun eSports";
 BTeamSrc = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/22efc02f-b249-4dab-bd55-7965d0e799c3.png";
 Date = "/Date(1468668600000)/";
 MatchId = 3002;
 */
@interface ResultMatch : JSONModel

@property (strong, nonatomic) NSString *resultMatchId;

@property (strong, nonatomic) NSString *aTeamId;
@property (strong, nonatomic) NSString *aTeamName;
@property (strong, nonatomic) NSString *aTeamImageUrl;
@property (strong, nonatomic) NSString *aScore;

@property (strong, nonatomic) NSString *bTeamId;
@property (strong, nonatomic) NSString *bTeamName;
@property (strong, nonatomic) NSString *bTeamImageUrl;
@property (strong, nonatomic) NSString *bScore;

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *dateString;

@end
