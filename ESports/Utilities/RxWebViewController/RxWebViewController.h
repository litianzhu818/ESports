//
//  RxWebViewController.h
//  RxWebViewController
//
//  Created by roxasora on 15/10/23.
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RxWebViewController : UIViewController

/**
 *  origin url
 */
@property (strong, nonatomic)NSURL* url;

/**
 *  embed webView
 */
@property (strong, nonatomic)UIWebView* webView;

/**
 *  tint color of progress view
 */
@property (strong, nonatomic)UIColor* progressViewColor;

@property (copy, nonatomic) void (^backBlock)(void);

/**
 *  get instance with url
 *
 *  @param url url
 *
 *  @return instance
 */
-(instancetype)initWithUrl:(NSURL*)url;

-(instancetype)initWithUrl:(NSURL*)url backBlock:(void (^)(void))backBlock;

-(void)reloadWebView;

@end



