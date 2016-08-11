//
//  StrengthRankingTeamController.h
//  ESports
//
//  Created by Peter Lee on 16/8/10.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "BaseViewController.h"

@interface StrengthRankingTeamController : BaseViewController

@property (strong, nonatomic) NSString *teamId;

- (instancetype)initWithTeamId:(NSString *)teamId;

@end
