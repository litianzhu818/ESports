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
