//
//  LoginController.m
//  ESports
//
//  Created by Peter Lee on 16/8/22.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "LoginController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *pwdImageView;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *findPwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *otherLoginWayTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomBackView;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *faceBookBtn;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self loadViews];
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

//- (void)loadViews
//{
//    self.localStringDictionary = @{
//                                   SYS_LANGUAGE_ENGLISH:@{
//                                           @"local_item_global":@"Global",
//                                           @"local_item_lck":@"LCK",
//                                           @"local_item_eulcs":@"EULCS",
//                                           @"local_item_lpl":@"LPL",
//                                           @"local_item_nalcs":@"NALCS",
//                                           @"local_item_lms":@"LMS",
//                                           @"local_bar_item":@"area",
//                                           @"view_controller_title":@"News",
//                                           @"news_type_hot":@"Hot focus",
//                                           @"news_type_transfer":@"Transfer",
//                                           @"news_type_headlines":@"Hot words",
//                                           @"tableview_header_pull_down_title":@"Pull down to refresh",
//                                           @"tableview_header_release_title":@"Release to refresh",
//                                           @"tableview_header_loading_title":@"Loading...",
//                                           @"tableview_footer_normal_title":@"Clicking to get more data",
//                                           @"tableview_footer_loading_title":@"Loading more...",
//                                           @"tableview_footer_no_data_title":@"There is no more data"
//                                           },
//                                   SYS_LANGUAGE_S_CHINESE:@{
//                                           @"local_item_global":@"全球",
//                                           @"local_item_lck":@"LCK",
//                                           @"local_item_eulcs":@"EULCS",
//                                           @"local_item_lpl":@"LPL",
//                                           @"local_item_nalcs":@"NALCS",
//                                           @"local_item_lms":@"LMS",
//                                           @"local_bar_item":@"地区",
//                                           @"view_controller_title":@"新闻",
//                                           @"news_type_hot":@"热门焦点",
//                                           @"news_type_transfer":@"转会新闻",
//                                           @"news_type_headlines":@"头条热话",
//                                           @"tableview_header_pull_down_title":@"下拉刷新",
//                                           @"tableview_header_release_title":@"松开刷新",
//                                           @"tableview_header_loading_title":@"获取数据中...",
//                                           @"tableview_footer_normal_title":@"点击加载更多数据",
//                                           @"tableview_footer_loading_title":@"正在加载数据...",
//                                           @"tableview_footer_no_data_title":@"没有更多数据了"
//                                           },
//                                   SYS_LANGUAGE_T_CHINESE:@{
//                                           @"local_item_global":@"全球",
//                                           @"local_item_lck":@"LCK",
//                                           @"local_item_eulcs":@"EULCS",
//                                           @"local_item_lpl":@"LPL",
//                                           @"local_item_nalcs":@"NALCS",
//                                           @"local_item_lms":@"LMS",
//                                           @"local_bar_item":@"地區",
//                                           @"view_controller_title":@"新聞",
//                                           @"news_type_hot":@"熱門焦點",
//                                           @"news_type_transfer":@"轉會新聞",
//                                           @"news_type_headlines":@"頭條熱話",
//                                           @"tableview_header_pull_down_title":@"下拉刷新",
//                                           @"tableview_header_release_title":@"鬆開刷新",
//                                           @"tableview_header_loading_title":@"獲取數據中...",
//                                           @"tableview_footer_normal_title":@"點擊加載更多數據",
//                                           @"tableview_footer_loading_title":@"正在加載數據...",
//                                           @"tableview_footer_no_data_title":@"沒有更多數據了"
//                                           }
//                                   };
//    
//    self.title = LTZLocalizedString(@"view_controller_title", nil);
//    
//    self.dropdownMenu = [[DropdownMenu alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]))
//                                                      Items:@[[[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_global", nil)],
//                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lck", nil)],
//                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_eulcs", nil)],
//                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lpl", nil)],
//                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_nalcs", nil)],
//                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lms", nil)]
//                                                              ]
//                                               currentIndex:0
//                                              selectedBlock:^(NSInteger index) {
//                                                  
//                                              }];
//    [self.view addSubview:self.dropdownMenu];
//    
//    
//    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateNormal];
//    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateHighlighted];
//    
//    [IonIcons label:self.button.titleLabel setIcon:icon_chevron_down size:17.0f color:[UIColor whiteColor] sizeToFit:NO];
//    [self.button setImage:[IonIcons imageWithIcon:icon_chevron_down size:15.0f color:[[UIColor whiteColor] colorWithAlphaComponent:0.7]] forState:UIControlStateNormal];
//    [self.button setImage:[IonIcons imageWithIcon:icon_chevron_down size:15.0f color:[UIColor whiteColor]] forState:UIControlStateHighlighted];
//    
//    // Set the title and icon position
//    [self.button sizeToFit];
//    
//    self.button.titleEdgeInsets = UIEdgeInsetsMake(0, -self.button.imageView.frame.size.width-10, 0, self.button.imageView.frame.size.width);
//    self.button.imageEdgeInsets = UIEdgeInsetsMake(0, self.button.titleLabel.frame.size.width-5, 0, -self.button.titleLabel.frame.size.width);
//    
//    // Set color to white
//    [self.button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
//    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    
//    [self.button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
//    
//    // 修改导航栏左边的item
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.button];
//    
//    // 顶部背景颜色
//    self.topBackgroundView.backgroundColor = HexColor(0x16212f);
//    
//    // UISegmentedControl修改
//    [self.segmentedControl setTintColor:HexColor(0x213954)];
//    
//    NSDictionary *normalAttributes = @{
//                                       NSForegroundColorAttributeName:HexColor(0x6ed4ff),
//                                       NSFontAttributeName:[UIFont systemFontOfSize:16.0f]
//                                       };
//    NSDictionary *selectedAttributes = @{
//                                         NSForegroundColorAttributeName:[UIColor whiteColor],
//                                         NSFontAttributeName:[UIFont systemFontOfSize:16.0f]
//                                         };
//    [self.segmentedControl setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
//    [self.segmentedControl setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
//    
//    [self.segmentedControl setTitle:LTZLocalizedString(@"news_type_hot", nil) forSegmentAtIndex:0];
//    [self.segmentedControl setTitle:LTZLocalizedString(@"news_type_transfer", nil) forSegmentAtIndex:1];
//    [self.segmentedControl setTitle:LTZLocalizedString(@"news_type_headlines", nil) forSegmentAtIndex:2];
//    
//    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
//    
//    
//    // 为UITableView添加上下拉
//    // 添加下拉刷新
//    self.hotfocusTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadHotfocusData)];
//    // 隐藏时间
//    self.hotfocusTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
//    [self.hotfocusTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
//    [self.hotfocusTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
//    [self.hotfocusTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
//    self.hotfocusTableView.mj_header = self.hotfocusTableViewHeader;
//    
//    
//    // 添加上拉加载更多数据
//    self.hotfocusTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreHotfocusData)];
//    self.hotfocusTableViewFooter.refreshingTitleHidden = YES;
//    [self.hotfocusTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
//    [self.hotfocusTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
//    [self.hotfocusTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
//    self.hotfocusTableView.mj_footer = self.hotfocusTableViewFooter;
//    
//    // 添加下拉刷新
//    self.transferTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTransferData)];
//    // 隐藏时间
//    self.transferTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
//    [self.transferTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
//    [self.transferTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
//    [self.transferTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
//    self.transferTableView.mj_header = self.transferTableViewHeader;
//    
//    
//    // 添加上拉加载更多数据
//    self.transferTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTransferData)];
//    self.transferTableViewFooter.refreshingTitleHidden = YES;
//    [self.transferTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
//    [self.transferTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
//    [self.transferTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
//    self.transferTableView.mj_footer = self.transferTableViewFooter;
//    
//    // 添加下拉刷新
//    self.hotwordsTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadHotwordsData)];
//    // 隐藏时间
//    self.hotwordsTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
//    [self.hotwordsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
//    [self.hotwordsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
//    [self.hotwordsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
//    self.hotwordsTableView.mj_header = self.hotwordsTableViewHeader;
//    
//    
//    // 添加上拉加载更多数据
//    self.hotwordsTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreHotwordsData)];
//    self.hotwordsTableViewFooter.refreshingTitleHidden = YES;
//    [self.hotwordsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
//    [self.hotwordsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
//    [self.hotwordsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
//    self.hotwordsTableView.mj_footer = self.hotwordsTableViewFooter;
//    
//    [self.hotfocusTableView registerNib:[NewsRotationImageCell nib] forCellReuseIdentifier:[NewsRotationImageCell cellIdentifier]];
//    [self.hotfocusTableView registerNib:[HotFocusNewCell nib] forCellReuseIdentifier:[HotFocusNewCell cellIdentifier]];
//    
//    [self.transferTableView registerNib:[NewsTableViewHeader nib]
//     forHeaderFooterViewReuseIdentifier:[NewsTableViewHeader headerReuseIdentifier]];
//    
//    [self.hotwordsTableView registerNib:[NewsTableViewHeader nib]
//     forHeaderFooterViewReuseIdentifier:[NewsTableViewHeader headerReuseIdentifier]];
//    
//    [self.transferTableView registerNib:[TransferNewCell nib] forCellReuseIdentifier:[TransferNewCell cellIdentifier]];
//    [self.hotwordsTableView registerNib:[HotWordNewCell nib] forCellReuseIdentifier:[HotWordNewCell cellIdentifier]];
//    
//}
//
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
