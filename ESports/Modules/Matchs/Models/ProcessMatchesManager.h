//
//  ProcessMatchesManager.h
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class ProcessMatch;
@class ProcessMatchesContainer;

/*
@protocol ProcessMatch
@end

@protocol ProcessMatchesContainer
@end
 */

@interface ProcessMatchesManager : JSONModel

@property (strong, nonatomic) NSMutableArray<ProcessMatchesContainer *> *processMatchesContainers;

- (NSIndexPath *)addProcessMatch:(ProcessMatch *)processMatch;
- (void)addProcessMatchesContainer:(ProcessMatchesContainer *)processMatchesContainer;
- (void)removeAllObjects;

@end

@interface ProcessMatchesContainer : JSONModel

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSMutableArray<ProcessMatch *> *processMatches;

- (instancetype)initWithProcessMatch:(ProcessMatch *)processMatch;
- (void)addProcessMatch:(ProcessMatch *)processMatch;

@end

/*
 ATeamId = 54;
 ATeamName = "Team WE";
 ATeamSrc = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/79a9476c-7c9d-4da5-9c38-20db88bfa534.png";
 BTeamId = 52;
 BTeamName = "Royal Never Give Up";
 BTeamSrc = "http://cdn.esportsmatrix.com/Content/images/uploaded/team/7d4d0fe2-8a39-4fc6-bcd5-074497b7e88e.png";
 Bo = BO3;
 Date = "/Date(1469102400000)/";
 Id = 3059;
 LiveStreamPage = "";
 LiveVideoApp = "<null>";
 ScorePrediction = "0:2";
 */
@interface ProcessMatch : JSONModel

@property (strong, nonatomic) NSString *processMatchId;

@property (strong, nonatomic) NSString *aTeamId;
@property (strong, nonatomic) NSString *aTeamName;
@property (strong, nonatomic) NSString *aTeamImageUrl;

@property (strong, nonatomic) NSString *bTeamId;
@property (strong, nonatomic) NSString *bTeamName;
@property (strong, nonatomic) NSString *bTeamImageUrl;

@property (strong, nonatomic) NSString *bo;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) NSString *liveStreamPage;
@property (strong, nonatomic) NSString *liveVideoApp;
@property (strong, nonatomic) NSString *scorePrediction;

@end