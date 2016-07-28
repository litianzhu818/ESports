//
//  MatchReplayController.h
//  ESports
//
//  Created by Peter Lee on 16/7/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "BaseViewController.h"
#import "ResultMatchesManager.h"

@interface MatchReplayController : BaseViewController

@property (strong, nonatomic) ResultMatch *resultMatch;

- (instancetype)initWithResultMatch:(ResultMatch *)resultMatch;

@end
