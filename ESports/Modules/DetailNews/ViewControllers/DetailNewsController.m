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
    
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    
    [self.activityIndicatorView setHidesWhenStopped:YES];
    
}

- (void)loadData
{
    if (!self.newsId) return;
    
    NSString *baseUrl = @"http://lol.esportsmatrix.com/%@/News/Detail?id=%@";
    
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
        //localization = @"en";
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
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicatorView stopAnimating];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
}


/*
#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [DetailNewsTopCell cellHeight];
    }else if (indexPath.row == 1) {
        if (self.webviewHeight > 0) {
            return self.webviewHeight;
        }
        return 200;//[DetailNewsCenterCell cellHeight];
    }else if (indexPath.row == 2 && (self.detailNew.relNews.count > 0)) {
        
        return [DetailRelNewsBottomCell cellHeightWithRelNews:self.detailNew.relNews];
        
    }else{
        
        return [DetailHotNewsBottomCell cellHeightWithHotNews:self.detailNew.hotNews];
    }
    
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 2;
    if (self.detailNew.relNews.count > 0) {
        ++count;
    }
    
    if (self.detailNew.hotNews.count > 0) {
        ++count;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DetailNewsTopCell *cell = [tableView dequeueReusableCellWithIdentifier:[DetailNewsTopCell cellIdentifier]
                                                                      forIndexPath:indexPath];
        cell.detailNew = self.detailNew;
        return cell;
    }else if (indexPath.row == 1) {
        DetailNewsCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[DetailNewsCenterCell cellIdentifier]
                                                                  forIndexPath:indexPath];
        cell.detailNew = self.detailNew;
        cell.needRelaod = !(self.webviewHeight > 0);
        WEAK_SELF;
        [cell setCellHeightBlock:^(CGFloat cellHeight) {
            STRONG_SELF;
            strongSelf.webviewHeight = cellHeight;
            [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        return cell;
    }else if (indexPath.row == 2 && (self.detailNew.relNews.count > 0)) {
        DetailRelNewsBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:[DetailRelNewsBottomCell cellIdentifier]
                                                                     forIndexPath:indexPath];
        cell.relNews = self.detailNew.relNews;
        WEAK_SELF;
        [cell setSelectedNewsBlock:^(NSString *newsId) {
            STRONG_SELF;
            [strongSelf.navigationController pushViewController:[[DetailNewsController alloc] initWithNewsId:newsId] animated:YES];
        }];
        return cell;
    }else{
        DetailHotNewsBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:[DetailHotNewsBottomCell cellIdentifier]
                                                                        forIndexPath:indexPath];
        cell.hotNews = self.detailNew.hotNews;
        WEAK_SELF;
        [cell setSelectedNewsBlock:^(NSString *newsId) {
            STRONG_SELF;
            [strongSelf.navigationController pushViewController:[[DetailNewsController alloc] initWithNewsId:newsId] animated:YES];
        }];
        return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.detailNew) {
        return 1;
    }
    
    return 0;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
