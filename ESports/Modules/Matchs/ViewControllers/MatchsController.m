//
//  MatchsController.m
//  ESports
//
//  Created by Peter Lee on 16/6/30.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchsController.h"

@interface MatchsController ()

@end

@implementation MatchsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"title":@"News",
                                           @"matchs":@"Matchs",
                                           @"ranking":@"Ranking",
                                           @"strengthrating":@"Strength"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"title":@"新闻",
                                           @"matchs":@"赛事",
                                           @"ranking":@"排行",
                                           @"strengthrating":@"实力评级"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"title":@"新聞",
                                           @"matchs":@"賽事",
                                           @"ranking":@"排行",
                                           @"strengthrating":@"實力評級"
                                           }
                                   };
    self.title = LTZLocalizedString(@"title", nil);
    [LTZLocalizationManager setLanguage:SYS_LANGUAGE_ENGLISH];

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
