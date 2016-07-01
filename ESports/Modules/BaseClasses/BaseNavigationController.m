//
//  BaseNavigationController.m
//  Kissnapp
//
//  Created by Peter Lee on 14/10/16.
//  Copyright (c) 2014年 AFT. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UINavigationController+RxWebViewNavigation.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@property(readonly, nonatomic) UIViewController *activeViewController;
@property(readonly, nonatomic) UIViewController *destinationViewController;

@end

@implementation BaseNavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */

+ (void)initialize
{
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:HexColor(0x1b2737)];
    //[navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar"] forBarMetrics:UIBarMetricsDefault];
    //[navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarWithPrompt"] forBarMetrics:UIBarMetricsDefaultPrompt];
    [navigationBar setTitleTextAttributes:@{
                                            NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0],
                                            NSForegroundColorAttributeName:[UIColor whiteColor]
                                            }];
    navigationBar.tintColor = [UIColor whiteColor];
    
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        navigationBar.translucent = NO;
    }
    
    
    
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    // UIControlStateHighlighted
    NSMutableDictionary *itemHighlightedAttrs = [NSMutableDictionary dictionary];
    itemHighlightedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemHighlightedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17.0f];
    [item setTitleTextAttributes:itemHighlightedAttrs forState:UIControlStateHighlighted];
    
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    itemDisabledAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17.0f];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    
    
    //[item setBackgroundImage:[UIImage imageNamed:@"barButtonItem"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //[item setBackgroundImage:[UIImage imageNamed:@"barButtonItem"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializationParameters];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializationParameters
{
    //Here initialization your parameters
    [self initializationUI];
    [self initializationData];
}

-(void)initializationUI
{
    //Here initialization your UI parameters
    //设置导航栏的字体颜色和背景图片
    
    if([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        self.navigationBar.translucent = NO;
    }
}

-(void)initializationData
{
    //Here initialization your data parameters
    
    self.interactivePopGestureRecognizer.delegate = self;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UIViewController *)activeViewController
{
    return [super topViewController];
}

-(UIViewController *)destinationViewController
{
    return ([super.viewControllers count] > 2) ? (UIViewController *)([super.viewControllers objectAtIndex:([super.viewControllers count] - 2)]):nil;
}

-(void)setViewControllers:(NSArray *)viewControllers
{
    [self setViewControllers:viewControllers animated:NO];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    if ([viewControllers isEqualToArray:super.viewControllers]) return;
    
    if (viewControllers.count < 1) return;
    
    [super setViewControllers:viewControllers animated:YES];
}

- (void)back
{
    UIViewController *topVC = self.topViewController;
    
    if ([topVC isKindOfClass:[RxWebViewController class]]) {
        RxWebViewController *webVC = (RxWebViewController*)topVC;
        if (webVC.backBlock != NULL) {
            webVC.backBlock();
        }
    }
    
    [self popViewControllerAnimated:YES];
}

- (void)showLanguageView
{

}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"The Current ViewController:%@\nThe Destination ViewController:%@",NSStringFromClass([self.topViewController class]),NSStringFromClass([viewController class]));
    
    if (self.activeViewController){
        
        if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
            
            
            //if (![viewController isKindOfClass:[RxWebViewController class]]) {
            /*
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setTitle:NSLocalizedStringFromTable(@"left_back_bar_title", NSStringFromClass([self class]), nil)
                    forState:UIControlStateNormal];
            [button setTitle:NSLocalizedStringFromTable(@"left_back_bar_title", NSStringFromClass([self class]), nil)
                    forState:UIControlStateHighlighted];
            
            UIImage* backItemImage = [[UIImage imageNamed:@"backItemImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImage* backItemHlImage = [[UIImage imageNamed:@"backItemImage-hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            [button setImage:backItemImage forState:UIControlStateNormal];
            [button setImage:backItemHlImage forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
            [button sizeToFit];
            
            // 让按钮内部的所有内容左对齐
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            // 让按钮的内容往左边偏移10
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            [button setTitleColor:self.navigationBar.tintColor forState:UIControlStateNormal];
            [button setTitleColor:[self.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
             
             // 修改导航栏左边的item
             viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
            */
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backItemImage"]
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(back)];
            
            // 修改导航栏左边的item
            viewController.navigationItem.leftBarButtonItem = backItem;
            
            //}
        
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = YES;
            
        }else if (self.childViewControllers.count == 0){
            
            UIBarButtonItem *changeLanguageItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_change_language"]
                                                                                   style:UIBarButtonItemStylePlain
                                                                                  target:self
                                                                                  action:@selector(showLanguageView)];
            
            // 修改导航栏左边的item
            viewController.navigationItem.rightBarButtonItem = changeLanguageItem;
        }

        [super pushViewController:viewController animated:animated];
    }
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.activeViewController){
        return [super popToViewController:viewController animated:animated];
    }
    
    return @[];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.activeViewController){
        return [super popViewControllerAnimated:animated];
    }
    
    return nil;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (self.activeViewController){
        return [super popToRootViewControllerAnimated:animated];
    }
    
    return @[];
}

#pragma mark - UIGestureRecognizerDelegate methods
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return (self.childViewControllers.count > 1);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
