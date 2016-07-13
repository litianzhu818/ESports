//
//  TransferNew.h
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TransferNew : JSONModel

@property (strong, nonatomic) NSString *newsId;

@property (strong, nonatomic) NSString *playerId;
@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSString *playerCountry;
@property (strong, nonatomic) NSString *playerImageUrl;

@property (strong, nonatomic) NSString *joinTeamName;
@property (strong, nonatomic) NSString *joinTeamImageUrl;
@property (strong, nonatomic) NSDate *joinTeamDate;

@property (strong, nonatomic) NSString *fromTeamName;
@property (strong, nonatomic) NSString *fromTeamImageUrl;
@property (strong, nonatomic) NSDate *fromTeamDate;

- (NSString *)joinTeamDateString;
- (NSString *)fromTeamDateString;

@end
