//
//  StrengthRankingPlayerController.h
//  ESports
//
//  Created by Peter Lee on 16/8/11.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "BaseViewController.h"

@interface StrengthRankingPlayerController : BaseViewController

@property (strong, nonatomic) NSString *playerId;
@property (strong, nonatomic) NSString *playerRole;

- (instancetype)initWithPlayerId:(NSString *)playerId role:(NSString *)role;

@end
