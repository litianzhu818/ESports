//
//  ESportsTabBarController.m
//  ESports
//
//  Created by Peter Lee on 16/7/1.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "ESportsTabBarController.h"
#import "RDVTabBarItem.h"
#import "RDVTabBarController+reloadItems.h"
#import "BaseNavigationController.h"
#import "NewsController.h"
#import "MatchsController.h"
#import "RankingController.h"
#import "StrengthRatingController.h"

@interface ESportsTabBarController ()<RDVTabBarControllerDelegate>

@end

@implementation ESportsTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"news":@"News",
                                           @"matchs":@"Matches",
                                           @"ranking":@"Ranking",
                                           @"strengthrating":@"Strength"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"news":@"新闻",
                                           @"matchs":@"赛事",
                                           @"ranking":@"排行",
                                           @"strengthrating":@"实力评级"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"news":@"新聞",
                                           @"matchs":@"賽事",
                                           @"ranking":@"排行",
                                           @"strengthrating":@"實力評級"
                                           }
                                   };
    [self setupViewControolers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControolers
{
    NewsController *newsController = [[NewsController alloc] init];
    BaseNavigationController *newsNavigationController = [[BaseNavigationController alloc] initWithRootViewController:newsController];
    
    MatchsController *matchsController = [[MatchsController alloc] init];
    BaseNavigationController *matchsNavigationController = [[BaseNavigationController alloc] initWithRootViewController:matchsController];
    
    
    RankingController *rankingController = [[RankingController alloc] init];
    BaseNavigationController *rankingNavigationController = [[BaseNavigationController alloc] initWithRootViewController:rankingController];
    
    
    StrengthRatingController *strengthRatingController = [[StrengthRatingController alloc]init];
    BaseNavigationController *strengthRatingNavigationController= [[BaseNavigationController alloc] initWithRootViewController:strengthRatingController];
    
    [self setViewControllers:@[newsNavigationController,
                               matchsNavigationController,
                               rankingNavigationController,
                               strengthRatingNavigationController]];

    [self customizeTabBarForController:self];
    
    self.delegate = self;
    
    self.view.backgroundColor = HexColor(0x0e161f);
    
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController
{
    NSArray *tabBarItemImages = @[@"tabbar_news",
                                  @"tabbar_matchs",
                                  @"tabbar_ranking",
                                  @"tabbar_strengthrating"];
    
    NSArray *tabBarItemTitles = @[LTZLocalizedString(@"news", nil),
                                  LTZLocalizedString(@"matchs", nil),
                                  LTZLocalizedString(@"ranking", nil),
                                  LTZLocalizedString(@"strengthrating", nil)];
    
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in tabBarController.tabBar.items) {
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_h",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_n",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        [item setUnselectedTitleAttributes:[NSDictionary dictionaryWithObjectsAndKeys:AppNormalColor,NSForegroundColorAttributeName, nil]];
        [item setSelectedTitleAttributes:[NSDictionary dictionaryWithObjectsAndKeys:AppSelectedColor,NSForegroundColorAttributeName, nil]];
        
        index++;
    }
    
    [tabBarController reloadItems];
    [[[tabBarController tabBar] backgroundView] setBackgroundColor:HexColor(0x1b2737)];
}

#pragma mark - 防止tabbar双击
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([tabBarController.selectedViewController isEqual:viewController]) return NO;
    
    return YES;
}

#pragma mark - 切换语言响应方法
- (void)languageDidChanged
{
    [self customizeTabBarForController:self];
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
