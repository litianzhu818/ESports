//
//  BaseNavigationController.m
//  Kissnapp
//
//  Created by Peter Lee on 14/10/16.
//  Copyright (c) 2014年 AFT. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UINavigationController+RxWebViewNavigation.h"
#import "LTZLocalizationKit.h"
#import "PopMenuModel.h"
#import "PopMenu.h"



#define navigation_bar_text_font [UIFont systemFontOfSize:17]
#define navigation_bar_normal_color [[UIColor whiteColor] colorWithAlphaComponent:0.7]
#define navigation_bar_highlighted_color [UIColor whiteColor]
#define navigation_bar_disabled_color [UIColor lightGrayColor]

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray<PopMenuModel *> *items;
@property (nonatomic, strong) PopMenu *popMenu;

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
                                            NSForegroundColorAttributeName:navigation_bar_normal_color
                                            }];
    navigationBar.tintColor = [UIColor whiteColor];
    
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        navigationBar.translucent = NO;
    }
    
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = navigation_bar_normal_color;
    itemAttrs[NSFontAttributeName] = navigation_bar_text_font;
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    // UIControlStateHighlighted
    NSMutableDictionary *itemHighlightedAttrs = [NSMutableDictionary dictionary];
    itemHighlightedAttrs[NSForegroundColorAttributeName] = navigation_bar_highlighted_color;
    itemHighlightedAttrs[NSFontAttributeName] = navigation_bar_text_font;
    [item setTitleTextAttributes:itemHighlightedAttrs forState:UIControlStateHighlighted];
    
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = navigation_bar_disabled_color;
    itemDisabledAttrs[NSFontAttributeName] = navigation_bar_text_font;
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

-(void)initializationParameters
{
    //Here initialization your parameters
    [self initializationData];
    [self initializationUI];
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
    
    self.items = @[[[PopMenuModel alloc] initWithImage:[UIImage imageNamed:@"sys_language_english"] title:@"English"],
                   [[PopMenuModel alloc] initWithImage:[UIImage imageNamed:@"sys_language_s_chinese"] title:@"简体中文"],
                   [[PopMenuModel alloc] initWithImage:[UIImage imageNamed:@"sys_language_t_chinese"] title:@"繁體中文"]];
    
    self.popMenu = [[PopMenu alloc] initWithImages:[self.items valueForKeyPath:@"image"]
                                            titles:[self.items valueForKeyPath:@"title"]
                                       selectBlock:^(NSUInteger index) {
                                           if (index == 0 && ![[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
                                               [LTZLocalizationManager setLanguage:SYS_LANGUAGE_ENGLISH];
                                           }else if(index == 1 && ![[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]){
                                               [LTZLocalizationManager setLanguage:SYS_LANGUAGE_S_CHINESE];
                                           }else if(index == 2 && ![[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]){
                                               [LTZLocalizationManager setLanguage:SYS_LANGUAGE_T_CHINESE];
                                           }
                                       }];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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

- (void)showLanguageView:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self.popMenu showAtView:button inView:[[UIApplication sharedApplication] keyWindow] animated:YES];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        
         UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        /*
         [button setTitle:NSLocalizedStringFromTable(@"left_back_bar_title", NSStringFromClass([self class]), nil)
         forState:UIControlStateNormal];
         [button setTitle:NSLocalizedStringFromTable(@"left_back_bar_title", NSStringFromClass([self class]), nil)
         forState:UIControlStateHighlighted];
         */
         
         UIImage* backItemImage = [[UIImage imageNamed:@"backItemImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         UIImage* backItemHlImage = [[UIImage imageNamed:@"backItemImage-hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         
         [button setImage:backItemImage forState:UIControlStateNormal];
         [button setImage:backItemHlImage forState:UIControlStateHighlighted];
        
         button.titleLabel.font = navigation_bar_text_font;
         [button sizeToFit];
         
         // 让按钮内部的所有内容左对齐
         button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
         
         // 让按钮的内容往左边偏移2
         button.contentEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
        
         [button setTitleColor:navigation_bar_normal_color forState:UIControlStateNormal];
         [button setTitleColor:navigation_bar_highlighted_color forState:UIControlStateHighlighted];
        
         [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
         
         // 修改导航栏左边的item
         viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }//else if (self.childViewControllers.count == 0){
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setFrame:CGRectMake(0, 0, 20, 40)];
        
        UIImage *itemImage = [[UIImage imageNamed:@"nav_change_language_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *itemHImage = [[UIImage imageNamed:@"nav_change_language_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [button setImage:itemImage forState:UIControlStateNormal];
        [button setImage:itemHImage forState:UIControlStateHighlighted];
        
        [button setTitleColor:navigation_bar_normal_color forState:UIControlStateNormal];
        [button setTitleColor:navigation_bar_highlighted_color forState:UIControlStateHighlighted];
        
        button.titleLabel.font = navigation_bar_text_font;
        //[button sizeToFit];
        
        [button addTarget:self action:@selector(showLanguageView:) forControlEvents:UIControlEventTouchUpInside];
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        // 修改导航栏左边的item
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];;
    //}
    
    [super pushViewController:viewController animated:animated];
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
