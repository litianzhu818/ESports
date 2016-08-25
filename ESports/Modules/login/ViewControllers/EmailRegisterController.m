//
//  EmailRegisterController.m
//  ESports
//
//  Created by Peter Lee on 16/8/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "EmailRegisterController.h"

@interface EmailRegisterController ()

@end

@implementation EmailRegisterController

- (instancetype)initWithEmail:(NSString *)email
{
    self = [super init];
    if (self) {
        self.email = email;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
