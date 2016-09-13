//
//  BaseViewController.m
//  ESports
//
//  Created by Peter Lee on 16/6/27.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "BaseViewController.h"
#import "NSObject+Custom.h"

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 从属性列表里取出存入的图片Str
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *itemImageStr = [user objectForKey:@"languageImgStrN"];
    NSString *itemHImageStr = [user objectForKey:@"languageImgStrH"];
    UIButton *button = self.navigationItem.rightBarButtonItem.customView;
    if (itemImageStr.length == 0 | itemHImageStr.length == 0) {
        UIImage *itemImage = [[UIImage imageNamed:@"ic_language_en"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *itemHImage = [[UIImage imageNamed:@"ic_language_en_press"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:itemImage forState:UIControlStateNormal];
        [button setImage:itemHImage forState:UIControlStateHighlighted];
    } else {
        UIImage *itemImage = [[UIImage imageNamed:itemImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *itemHImage = [[UIImage imageNamed:itemHImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [button setImage:itemImage forState:UIControlStateNormal];
        [button setImage:itemHImage forState:UIControlStateHighlighted];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(languageDidChanged)
                                                 name:LTZLocalizationKitLanguageDidChangedKey
                                               object:nil];
    
    
    self.view.backgroundColor = [UIColor blackColor];//HexColor(0x0e161f);
  
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:LTZLocalizationKitLanguageDidChangedKey
                                                  object:nil];
}

- (void)languageDidChanged
{
    // TODO:you should overwrite this method for updating ui after the system had been changed
}

@end
