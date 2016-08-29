//
//  DetailNewsController.m
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DetailNewsController.h"
#import "DetailNewsTopCell.h"
#import "DetailNewsCenterCell.h"
#import "HttpSessionManager.h"
#import "MBProgressHUD.h"
#import "DetailRelNewsBottomCell.h"
#import "DetailHotNewsBottomCell.h"

@interface DetailNewsController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation DetailNewsController

- (instancetype)initWithNewsId:(NSString *)newsId
{
    self = [super init];
    if (self) {
        self.newsId = newsId;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.rdv_tabBarController setTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadViews];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadViews
{
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"view_controller_title":@"News detail"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"view_controller_title":@"新闻详情"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"view_controller_title":@"新聞詳情"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    //[self.webView setUserInteractionEnabled:NO];
    //[self.webView.scrollView setScrollEnabled:NO];
    [self.webView.scrollView setShowsVerticalScrollIndicator:NO];
    [self.webView.scrollView setShowsHorizontalScrollIndicator:NO];
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.bounces = NO;
    //self.webView.allowsLinkPreview = YES;
    
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    
    [self.activityIndicatorView setHidesWhenStopped:YES];
    
}

- (void)loadData
{
    if (!self.newsId) return;
    
    NSString *baseUrl = @"http://lol.esportsmatrix.com/%@/News/DetailForApp?id=%@";
    
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:baseUrl,[self locationPath],self.newsId]];
    
    if (requestUrl) {
        [self.activityIndicatorView startAnimating];
        [self.webView loadRequest:[NSURLRequest requestWithURL:requestUrl]];
    }
}

- (NSString *)locationPath
{
    NSString *localization = @"en";// 默认英文
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {//简体中文
        localization = @"zh-CN";
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]){//繁体中文
        localization = @"zh-TW";
    }else{
        localization = @"en";
    }
    return localization;
}



#pragma mark - 切换语言响应方法
- (void)languageDidChanged
{
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    [self loadData];
}

#pragma mark -  UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //[self.activityIndicatorView stopAnimating];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
}
@end
