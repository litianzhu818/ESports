//
//  EmailRegisterController.h
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "BaseViewController.h"

@interface EmailRegisterController : BaseViewController

@property (strong, nonatomic) NSString *email;

- (instancetype)initWithEmail:(NSString *)email;

@end
