//
//  EmailRegisterSuccessController.h
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "BaseViewController.h"

@interface EmailRegisterSuccessController : BaseViewController

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *pwd;

- (instancetype)initWithEmail:(NSString *)email pwd:(NSString *)pwd;

@end
