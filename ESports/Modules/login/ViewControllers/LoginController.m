//
//  LoginController.m
//  ESports
//
//  Created by Peter Lee on 16/8/22.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "LoginController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "AppDelegate.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nameBottomImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *pwdImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pwdBottomImageView;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *findPwdBtn;
@property (weak, nonatomic) IBOutlet UIImageView *findPwdImageView;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *otherLoginWayTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIView *logoNamebackView;

@property (weak, nonatomic) IBOutlet UIView *bottomBackView;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *faceBookBtn;

@property (strong, nonatomic) UIButton *closeButton;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadViews];
//    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender
{

}

- (IBAction)findPwdAction:(id)sender
{
    
}

- (IBAction)registerAction:(id)sender
{
    
}

- (IBAction)qqAction:(id)sender
{
    
}
- (IBAction)weiboAction:(id)sender
{
    
}
- (IBAction)weChatAction:(id)sender
{
    
}
- (IBAction)facebookAction:(id)sender
{
    
}

- (void)loadViews
{
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"local_item_global":@"Global",
                                           @"local_item_lck":@"LCK",
                                           @"local_item_eulcs":@"EULCS",
                                           @"local_item_lpl":@"LPL",
                                           @"local_item_nalcs":@"NALCS",
                                           @"local_item_lms":@"LMS",
                                           @"local_bar_item":@"area",
                                           @"view_controller_title":@"Login",
                                           @"news_type_hot":@"Hot focus",
                                           @"news_type_transfer":@"Transfer",
                                           @"news_type_headlines":@"Hot words",
                                           @"tableview_header_pull_down_title":@"Pull down to refresh",
                                           @"tableview_header_release_title":@"Release to refresh",
                                           @"tableview_header_loading_title":@"Loading...",
                                           @"tableview_footer_normal_title":@"Clicking to get more data",
                                           @"tableview_footer_loading_title":@"Loading more...",
                                           @"tableview_footer_no_data_title":@"There is no more data"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"local_item_global":@"全球",
                                           @"local_item_lck":@"LCK",
                                           @"local_item_eulcs":@"EULCS",
                                           @"local_item_lpl":@"LPL",
                                           @"local_item_nalcs":@"NALCS",
                                           @"local_item_lms":@"LMS",
                                           @"local_bar_item":@"地区",
                                           @"view_controller_title":@"登录",
                                           @"news_type_hot":@"热门焦点",
                                           @"news_type_transfer":@"转会新闻",
                                           @"news_type_headlines":@"头条热话",
                                           @"tableview_header_pull_down_title":@"下拉刷新",
                                           @"tableview_header_release_title":@"松开刷新",
                                           @"tableview_header_loading_title":@"获取数据中...",
                                           @"tableview_footer_normal_title":@"点击加载更多数据",
                                           @"tableview_footer_loading_title":@"正在加载数据...",
                                           @"tableview_footer_no_data_title":@"没有更多数据了"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"local_item_global":@"全球",
                                           @"local_item_lck":@"LCK",
                                           @"local_item_eulcs":@"EULCS",
                                           @"local_item_lpl":@"LPL",
                                           @"local_item_nalcs":@"NALCS",
                                           @"local_item_lms":@"LMS",
                                           @"local_bar_item":@"地區",
                                           @"view_controller_title":@"登入",
                                           @"news_type_hot":@"熱門焦點",
                                           @"news_type_transfer":@"轉會新聞",
                                           @"news_type_headlines":@"頭條熱話",
                                           @"tableview_header_pull_down_title":@"下拉刷新",
                                           @"tableview_header_release_title":@"鬆開刷新",
                                           @"tableview_header_loading_title":@"獲取數據中...",
                                           @"tableview_footer_normal_title":@"點擊加載更多數據",
                                           @"tableview_footer_loading_title":@"正在加載數據...",
                                           @"tableview_footer_no_data_title":@"沒有更多數據了"
                                           }
                                   };
    
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"login_close_btn"] forState:UIControlStateNormal];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"login_close_btn"] forState:UIControlStateHighlighted];
    [self.closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
    
    // 调整UIScrollView contentSize
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
    self.widthLayoutConstraint.constant =  screenWidth-72;
    [self.logoNamebackView setNeedsUpdateConstraints];
    
    self.scrollView.contentSize = CGSizeMake(screenWidth, screenHeight);
    [self.scrollView setContentInset:UIEdgeInsetsZero];
    
    self.backImageView.clipsToBounds = YES;
    
    self.nameBottomImageView.backgroundColor = HexColor(0x70767d);
    self.pwdBottomImageView.backgroundColor = HexColor(0x70767d);
    self.findPwdImageView.backgroundColor = HexColor(0xbabbbd);
    
}

//- (void)loadData
//{
//    self.currentNewsType = NewsTypeHotFocus;
//    self.limitForRequest = 20;
//    self.hotfocusNewsOffset = 0;
//    self.hotwordsNewsOffset = 0;
//    self.transferNewsOffset = 0;
//    self.hotwordsNewsFirstRequest = YES;
//    self.transferNewsFirstRequest = YES;
//    self.images = [NSMutableArray array];
//    self.hotFocusNews = [NSMutableArray array];
//    self.transferNewManager = [[TransferNewManager alloc] init];
//    self.hotWordNewManager = [[HotWordNewManager alloc] init];
//    
//    // 取缓存中的轮换图片
//    __weak typeof(self) weakSelf = self;
//    
//    [[TMCache sharedCache] objectForKey:newsImagesCacheKey
//                                  block:^(TMCache *cache, NSString *key, id object) {
//                                      __strong typeof(weakSelf) strongSelf = weakSelf;
//                                      NSArray<NewsRotationImage *> *images = object;
//                                      [strongSelf.images addObjectsFromArray:images];
//                                      dispatch_async(dispatch_get_main_queue(), ^{
//                                          if (strongSelf.images.count > 0) {
//                                              
//                                              [strongSelf.hotfocusTableView reloadData];
//                                          }
//                                          
//                                      });
//                                      
//                                  }];
//    
//    [[TMCache sharedCache] objectForKey:hotFocusNewsListCacheKey
//                                  block:^(TMCache *cache, NSString *key, NSArray<HotFocusNew *> *HotFocusNews) {
//                                      __strong typeof(weakSelf) strongSelf = weakSelf;
//                                      [strongSelf.hotFocusNews addObjectsFromArray:HotFocusNews];
//                                      dispatch_async(dispatch_get_main_queue(), ^{
//                                          [strongSelf.hotfocusTableView reloadData];
//                                      });
//                                  }];
//    
//    [[TMCache sharedCache] objectForKey:transferNewsListCacheKey
//                                  block:^(TMCache *cache, NSString *key, NSArray<TransferNewContainer *> *TransferNewContainers) {
//                                      __strong typeof(weakSelf) strongSelf = weakSelf;
//                                      [TransferNewContainers enumerateObjectsUsingBlock:^(TransferNewContainer * _Nonnull transferNewContainer, NSUInteger idx, BOOL * _Nonnull stop) {
//                                          [strongSelf.transferNewManager addTransferNewContainer:transferNewContainer];
//                                      }];
//                                      dispatch_async(dispatch_get_main_queue(), ^{
//                                          [strongSelf.transferTableView reloadData];
//                                      });
//                                  }];
//    
//    [[TMCache sharedCache] objectForKey:hotwordsNewsListCacheKey
//                                  block:^(TMCache *cache, NSString *key, NSArray<HotWordNewContainer *> *HotWordNewContainers) {
//                                      __strong typeof(weakSelf) strongSelf = weakSelf;
//                                      [HotWordNewContainers enumerateObjectsUsingBlock:^(HotWordNewContainer * _Nonnull hotWordNewContainer, NSUInteger idx, BOOL * _Nonnull stop) {
//                                          [strongSelf.hotWordNewManager addHotWordNewContainer:hotWordNewContainer];
//                                      }];
//                                      
//                                      dispatch_async(dispatch_get_main_queue(), ^{
//                                          [strongSelf.hotwordsTableView reloadData];
//                                      });
//                                  }];
//    
//    // 开始网络请求数据
//    [self.hotfocusTableView.mj_header beginRefreshing];
//    
//    self.hotfocusTableView.backgroundColor = self.view.backgroundColor;
//    self.transferTableView.backgroundColor = self.view.backgroundColor;
//    self.hotwordsTableView.backgroundColor = self.view.backgroundColor;
//    
//    
//}

- (void)closeAction:(id)sender
{
    [myAppDelegate switchToTabbarViewController];
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
