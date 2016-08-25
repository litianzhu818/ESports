//
//  NetworkAPIs.h
//  ESports
//
//  Created by Peter Lee on 15/3/20.
//  Copyright (c) 2015年 Peter Lee. All rights reserved.
//

#ifndef ESports_NetworkAPIs_h
#define ESports_NetworkAPIs_h

static NSString *const BaseURL = @"http://lol.esportsmatrix.com/";
static NSString *const newsCarouselImagsURL = @"News/NewsHdp";
static NSString *const hotfocusNewsURL = @"News/NewFocus";
static NSString *const transferNewsURL = @"News/NewsTransfer";
static NSString *const hotwordsNewsURL = @"News/NewsHeadlines";
static NSString *const detailNewsURL = @"News/NewsDetail";
static NSString *const matchProcessURL = @"Match/MatchFixtures";
static NSString *const matchResultURL = @"Match/Results";
static NSString *const matchTeamDataURL = @"Match/GetTeamGameResults";
static NSString *const matchPlayerDataURL = @"Match/GetPlayerGameResults";
static NSString *const matchReplayVideoURL = @"Match/GetGameVideoUrls";
static NSString *const matchPointsTypeListURL = @"Match/PointsType";
static NSString *const matchStandingListURL = @"Match/PointsList";
static NSString *const strengthScoreTeamsListURL = @"Team/GetRankings";
static NSString *const strengthScorePlayersListURL = @"Player/GetRankings";
static NSString *const strengthScoreTeamsDetailURL = @"Team/GetTeamDetails";
static NSString *const strengthScorePlayersDetailURL = @"Player/GetPlayerDetails";
static NSString *const strengthScorePlayerRoleListURL = @"Player/GetRoleList";
static NSString *const LoginURL = @"Account/Login";

#endif
