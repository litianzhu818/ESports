//
//  NewsController.m
//  ESports
//
//  Created by Peter Lee on 16/6/30.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "NewsController.h"
#import "LTZLocalizationKit.h"
#import "DropdownMenu.h"
#import "IonIcons.h"
#import "MJRefresh.h"
#import "TMCache.h"
#import "NewsRotationImage.h"
#import "TransferNewManager.h"
#import "HotWordNewManager.h"
#import "HotFocusNew.h"
#import "NewsRotationImageCell.h"
#import "HttpSessionManager.h"
#import "HotFocusNewCell.h"
#import "NewsTableViewHeader.h"


typedef NS_ENUM(NSUInteger, NewsType) {
    NewsTypeHotFocus = 0,
    NewsTypeHotTransfer,
    NewsTypeHotWords
};

static NSString *const newsImagesCacheKey = @"news_controller_news_images_cache_key";
static NSString *const hotFocusNewsListCacheKey = @"news_controller_hot_foucs_news_cache_key";
static NSString *const transferNewsListCacheKey = @"news_controller_transfer_news_cache_key";
static NSString *const hotwordsNewsListCacheKey = @"news_controller_hot_words_news_cache_key";

@interface NewsController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *topBackgroundView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *hotfocusTableView;
@property (weak, nonatomic) IBOutlet UITableView *transferTableView;
@property (weak, nonatomic) IBOutlet UITableView *hotwordsTableView;

@property (strong, nonatomic) MJRefreshNormalHeader *hotfocusTableViewHeader;
@property (strong, nonatomic) MJRefreshAutoNormalFooter *hotfocusTableViewFooter;
@property (strong, nonatomic) MJRefreshNormalHeader *transferTableViewHeader;
@property (strong, nonatomic) MJRefreshAutoNormalFooter *transferTableViewFooter;
@property (strong, nonatomic) MJRefreshNormalHeader *hotwordsTableViewHeader;
@property (strong, nonatomic) MJRefreshAutoNormalFooter *hotwordsTableViewFooter;

@property (strong, nonatomic) DropdownMenu *dropdownMenu;
@property (strong, nonatomic) UIButton *button;

@property (assign, nonatomic) NewsType currentNewsType;
@property (assign, nonatomic) NSInteger hotfocusNewsOffset;
@property (assign, nonatomic) NSInteger transferNewsOffset;
@property (assign, nonatomic) NSInteger hotwordsNewsOffset;
@property (assign, nonatomic) NSInteger limitForRequest;
@property (assign, nonatomic) BOOL showImages;

@property (assign, nonatomic) NSInteger hotfocusNewsFirstRequest;
@property (assign, nonatomic) NSInteger transferNewsFirstRequest;
@property (assign, nonatomic) NSInteger hotwordsNewsFirstRequest;

@property (strong, nonatomic) NSMutableArray<NewsRotationImage *> *images;
@property (strong, nonatomic) NSMutableArray<HotFocusNew *> *hotFocusNews;
@property (strong, nonatomic) TransferNewManager *transferNewManager;
@property (strong, nonatomic) HotWordNewManager *hotWordNewManager;

@end

@implementation NewsController

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
                                           @"local_item_global":@"Global",
                                           @"local_item_lck":@"LCK",
                                           @"local_item_eulcs":@"EULCS",
                                           @"local_item_lpl":@"LPL",
                                           @"local_item_nalcs":@"NALCS",
                                           @"local_item_lms":@"LMS",
                                           @"local_bar_item":@"area",
                                           @"view_controller_title":@"News",
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
                                           @"view_controller_title":@"新闻",
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
                                           @"view_controller_title":@"新聞",
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showMenu)];
    
    self.dropdownMenu = [[DropdownMenu alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]))
                                                      Items:@[[[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_global", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lck", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_eulcs", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lpl", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_nalcs", nil)],
                                                              [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lms", nil)]
                                                              ]
                                               currentIndex:0
                                              selectedBlock:^(NSInteger index) {
                                                  
                                              }];
    [self.view addSubview:self.dropdownMenu];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateNormal];
    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateHighlighted];
    
    [IonIcons label:self.button.titleLabel setIcon:icon_chevron_down size:17.0f color:[UIColor whiteColor] sizeToFit:NO];
    [self.button setImage:[IonIcons imageWithIcon:icon_chevron_down size:15.0f color:[[UIColor whiteColor] colorWithAlphaComponent:0.7]] forState:UIControlStateNormal];
    [self.button setImage:[IonIcons imageWithIcon:icon_chevron_down size:15.0f color:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    
    // Set the title and icon position
    [self.button sizeToFit];
    
    self.button.titleEdgeInsets = UIEdgeInsetsMake(0, -self.button.imageView.frame.size.width-10, 0, self.button.imageView.frame.size.width);
    self.button.imageEdgeInsets = UIEdgeInsetsMake(0, self.button.titleLabel.frame.size.width-5, 0, -self.button.titleLabel.frame.size.width);
    
    // Set color to white
    [self.button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.button];
    
    // 顶部背景颜色
    self.topBackgroundView.backgroundColor = HexColor(0x16212f);
    
    // UISegmentedControl修改
    [self.segmentedControl setTintColor:HexColor(0x213954)];
    
    NSDictionary *normalAttributes = @{
                                       NSForegroundColorAttributeName:HexColor(0x6ed4ff),
                                       NSFontAttributeName:[UIFont systemFontOfSize:16.0f]
                                       };
    NSDictionary *selectedAttributes = @{
                                       NSForegroundColorAttributeName:[UIColor whiteColor],
                                       NSFontAttributeName:[UIFont systemFontOfSize:16.0f]
                                       };
    [self.segmentedControl setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    
    [self.segmentedControl setTitle:LTZLocalizedString(@"news_type_hot", nil) forSegmentAtIndex:0];
    [self.segmentedControl setTitle:LTZLocalizedString(@"news_type_transfer", nil) forSegmentAtIndex:1];
    [self.segmentedControl setTitle:LTZLocalizedString(@"news_type_headlines", nil) forSegmentAtIndex:2];
    
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    
    // 为UITableView添加上下拉
    // 添加下拉刷新
    self.hotfocusTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadHotfocusData)];
    // 隐藏时间
    self.hotfocusTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
    [self.hotfocusTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.hotfocusTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.hotfocusTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    self.hotfocusTableView.mj_header = self.hotfocusTableViewHeader;
    

    // 添加上拉加载更多数据
    self.hotfocusTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreHotfocusData)];
    self.hotfocusTableViewFooter.refreshingTitleHidden = YES;
    [self.hotfocusTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.hotfocusTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.hotfocusTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    self.hotfocusTableView.mj_footer = self.hotfocusTableViewFooter;
    
    // 添加下拉刷新
    self.transferTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTransferData)];
    // 隐藏时间
    self.transferTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
    [self.transferTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.transferTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.transferTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    self.transferTableView.mj_header = self.transferTableViewHeader;
    
    
    // 添加上拉加载更多数据
    self.transferTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTransferData)];
    self.transferTableViewFooter.refreshingTitleHidden = YES;
    [self.transferTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.transferTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.transferTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    self.transferTableView.mj_footer = self.transferTableViewFooter;
    
    // 添加下拉刷新
    self.hotwordsTableViewHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadHotwordsData)];
    // 隐藏时间
    self.hotwordsTableViewHeader.lastUpdatedTimeLabel.hidden = YES;
    [self.hotwordsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.hotwordsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.hotwordsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    self.hotwordsTableView.mj_header = self.hotwordsTableViewHeader;
    
    
    // 添加上拉加载更多数据
    self.hotwordsTableViewFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreHotwordsData)];
    self.hotwordsTableViewFooter.refreshingTitleHidden = YES;
    [self.hotwordsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.hotwordsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.hotwordsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    self.hotwordsTableView.mj_footer = self.hotwordsTableViewFooter;
    
    [self.hotfocusTableView registerNib:[NewsRotationImageCell nib] forCellReuseIdentifier:[NewsRotationImageCell cellIdentifier]];
    [self.hotfocusTableView registerNib:[HotFocusNewCell nib] forCellReuseIdentifier:[HotFocusNewCell cellIdentifier]];
    
    [self.transferTableView registerNib:[NewsTableViewHeader nib]
     forHeaderFooterViewReuseIdentifier:[NewsTableViewHeader headerReuseIdentifier]];
    
    [self.hotwordsTableView registerNib:[NewsTableViewHeader nib]
     forHeaderFooterViewReuseIdentifier:[NewsTableViewHeader headerReuseIdentifier]];
    
}

- (void)loadData
{
    self.currentNewsType = NewsTypeHotFocus;
    self.limitForRequest = 20;
    self.hotfocusNewsOffset = 0;
    self.hotwordsNewsOffset = 0;
    self.transferNewsOffset = 0;
    self.hotfocusNewsFirstRequest = YES;
    self.hotwordsNewsFirstRequest = YES;
    self.transferNewsFirstRequest = YES;
    self.showImages = NO;
    self.images = [NSMutableArray array];
    self.hotFocusNews = [NSMutableArray array];
    self.transferNewManager = [[TransferNewManager alloc] init];
    self.hotWordNewManager = [[HotWordNewManager alloc] init];
    
    // 取缓存中的轮换图片
    __weak typeof(self) weakSelf = self;
    
    [[TMCache sharedCache] objectForKey:newsImagesCacheKey
                                  block:^(TMCache *cache, NSString *key, id object) {
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      NSArray<NewsRotationImage *> *images = object;
                                      [strongSelf.images addObjectsFromArray:images];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (strongSelf.images.count > 0) {
                                              if (strongSelf.showImages) {
                                                  [strongSelf.hotfocusTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                                              }else{
                                                  [strongSelf.hotfocusTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
                                                                                      withRowAnimation:UITableViewRowAnimationFade];
                                              }
                                          }
                                        
                                      });
                                      
                                  }];
    
    [[TMCache sharedCache] objectForKey:hotFocusNewsListCacheKey
                                  block:^(TMCache *cache, NSString *key, NSArray<HotFocusNew *> *HotFocusNews) {
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      [strongSelf.hotFocusNews addObjectsFromArray:HotFocusNews];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [strongSelf.hotfocusTableView reloadData];
                                      });
                                  }];
    
    [[TMCache sharedCache] objectForKey:transferNewsListCacheKey
                                  block:^(TMCache *cache, NSString *key, NSArray<TransferNewContainer *> *TransferNewContainers) {
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      [TransferNewContainers enumerateObjectsUsingBlock:^(TransferNewContainer * _Nonnull transferNewContainer, NSUInteger idx, BOOL * _Nonnull stop) {
                                          [strongSelf.transferNewManager.transferNewContainers addObject:transferNewContainer];
                                      }];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [strongSelf.transferTableView reloadData];
                                      });
                                  }];
    
    [[TMCache sharedCache] objectForKey:hotwordsNewsListCacheKey
                                  block:^(TMCache *cache, NSString *key, NSArray<HotWordNew *> *HotWordNews) {
                                      __strong typeof(weakSelf) strongSelf = weakSelf;
                                      [HotWordNews enumerateObjectsUsingBlock:^(HotWordNew * _Nonnull hotWordNew, NSUInteger idx, BOOL * _Nonnull stop) {
                                          [strongSelf.hotWordNewManager addHotWordNew:hotWordNew];
                                      }];
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [strongSelf.hotwordsTableView reloadData];
                                      });
                                  }];
    
    // 开始网络请求数据
    [self.hotfocusTableView.mj_header beginRefreshing];
    
    self.hotfocusTableView.backgroundColor = self.view.backgroundColor;
    self.transferTableView.backgroundColor = self.view.backgroundColor;
    self.hotwordsTableView.backgroundColor = self.view.backgroundColor;
    
    
}

- (void)showMenu
{
    if (!self.dropdownMenu.isShowing) {
        [self.dropdownMenu showMenu];
    }else{
        [self.dropdownMenu hideMenu];
    }
}

- (void)setCurrentNewsType:(NewsType)currentNewsType
{
    _currentNewsType = currentNewsType;
    
    switch (_currentNewsType) {
        case NewsTypeHotFocus:
        {
            self.hotfocusTableView.hidden = NO;
            self.transferTableView.hidden = YES;
            self.hotwordsTableView.hidden = YES;
            //[self.view bringSubviewToFront:self.hotwordsTableView];
        }
            break;
        case NewsTypeHotTransfer:
        {
            self.hotfocusTableView.hidden = YES;
            self.transferTableView.hidden = NO;
            self.hotwordsTableView.hidden = YES;
            //[self.view bringSubviewToFront:self.transferTableView];
        }
            break;
        case NewsTypeHotWords:
        {
            self.hotfocusTableView.hidden = YES;
            self.transferTableView.hidden = YES;
            self.hotwordsTableView.hidden = NO;
            //[self.view bringSubviewToFront:self.hotwordsTableView];
        }
            break;
            
        default:
            break;
    }
}

- (void)reloadHotfocusData
{
    self.hotfocusNewsOffset = 0;
    self.hotfocusNewsFirstRequest = NO;
    __weak typeof(self) weakSelf = self;
    [[HttpSessionManager sharedInstance] requestNewsCarouselImagesWithOffset:0
                                                               numbersOfPage:5
                                                                       block:^(NSArray<NSDictionary *> *images, NSError *error) {
                                                                           
                                                                           __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                           
                                                                           if (!error) {
                                                                               
                                                                               [strongSelf.images removeAllObjects];
                                                                               
                                                                               [images enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                   NewsRotationImage *image = [[NewsRotationImage alloc] initWithDictionary:dic
                                                                                                                                                      error:nil];
                                                                                   if (image) {
                                                                                       [strongSelf.images addObject:image];
                                                                                   }
                                                                               }];
                                                                               
                                                                               
                                                                               if (strongSelf.showImages) {
                                                                                   [strongSelf.hotfocusTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                                                                               }else{
                                                                                   [strongSelf.hotfocusTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
                                                                                                                       withRowAnimation:UITableViewRowAnimationFade];
                                                                               }
                                                                               
                                                                               [[TMCache sharedCache] setObject:strongSelf.images
                                                                                                         forKey:newsImagesCacheKey
                                                                                                          block:NULL];
                                                                               
                                                                           }
                                                                           
                                                                       }];
    
    [[HttpSessionManager sharedInstance] requestHotfocusNewsWithOffset:self.hotfocusNewsOffset
                                                          limitsOfPage:self.limitForRequest
                                                                 block:^(NSArray<NSDictionary *> *hotfocusNews, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (hotfocusNews.count > 0) {
                                                                             [strongSelf.hotFocusNews removeAllObjects];
                                                                             NSMutableArray<HotFocusNew *> *cacheHotFocusNews = [NSMutableArray array];
                                                                             [hotfocusNews enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 HotFocusNew *hotFocusNew = [[HotFocusNew alloc] initWithDictionary:dic error:nil];
                                                                                 if (hotFocusNew) {
                                                                                     [strongSelf.hotFocusNews addObject:hotFocusNew];
                                                                                     [cacheHotFocusNews addObject:hotFocusNew];
                                                                                 }
                                                                             }];
                                                                             
                                                                             
                                                                             strongSelf.hotfocusNewsOffset += hotfocusNews.count;
                                                                             if (hotfocusNews.count < strongSelf.limitForRequest) {
                                                                                 [strongSelf.hotfocusTableView.mj_footer endRefreshingWithNoMoreData];
                                                                             }
                                                                             
                                                                             [strongSelf.hotfocusTableView reloadData];
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheHotFocusNews
                                                                                                       forKey:hotFocusNewsListCacheKey
                                                                                                        block:NULL];
      
                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                     [strongSelf.hotfocusTableView.mj_header endRefreshing];
                                                                 }];
}

- (void)loadMoreHotfocusData
{
    __weak typeof(self) weakSelf = self;
    [[HttpSessionManager sharedInstance] requestHotfocusNewsWithOffset:self.hotfocusNewsOffset
                                                          limitsOfPage:self.limitForRequest
                                                                 block:^(NSArray<NSDictionary *> *hotfocusNews, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     BOOL hasMoreData = YES;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (hotfocusNews.count > 0) {
                                                                             NSMutableArray<HotFocusNew *> *cacheHotFocusNews = [NSMutableArray array];
                                                                             
                                                                             [weakSelf.hotfocusTableView beginUpdates];
                                                                             
                                                                             [hotfocusNews enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 HotFocusNew *hotFocusNew = [[HotFocusNew alloc] initWithDictionary:dic error:nil];
                                                                                 if (hotFocusNew) {
                                                                                     [strongSelf.hotFocusNews addObject:hotFocusNew];
                                                                                     [cacheHotFocusNews addObject:hotFocusNew];
                                                                                     [strongSelf.hotfocusTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:strongSelf.hotFocusNews.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
                                                                                 }
                                                                             }];
                                                                             
                                                                             [weakSelf.hotfocusTableView endUpdates];
                                                                             
                                                                             strongSelf.hotfocusNewsOffset += hotfocusNews.count;
                                                                             if (hotfocusNews.count < strongSelf.limitForRequest) {
                                                                                 [strongSelf.hotfocusTableView.mj_footer endRefreshingWithNoMoreData];
                                                                                 hasMoreData = NO;
                                                                             }
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheHotFocusNews
                                                                                                       forKey:hotFocusNewsListCacheKey
                                                                                                        block:NULL];

                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                     if (hasMoreData) {
                                                                         [strongSelf.hotfocusTableView.mj_header endRefreshing];
                                                                     }
                                                                     
                                                                 }];
}

- (void)reloadTransferData
{
    self.transferNewsOffset = 0;
    self.transferNewsFirstRequest = NO;
    __weak typeof(self) weakSelf = self;
    [[HttpSessionManager sharedInstance] requestTransferNewsWithOffset:self.transferNewsOffset
                                                          limitsOfPage:5
                                                                 block:^(NSArray<NSDictionary *> *transferNewContainers, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (transferNewContainers.count > 0) {
                                                                             [strongSelf.transferNewManager.transferNewContainers removeAllObjects];
                                                                             NSMutableArray<TransferNewContainer *> *cacheTransferNewContainers = [NSMutableArray array];
                                                                             
                                                                             [transferNewContainers enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 TransferNewContainer *container = [[TransferNewContainer alloc] initWithDictionary:dic error:nil];
                                                                                 if (container) {
                                                                                     [strongSelf.transferNewManager.transferNewContainers addObject:container];
                                                                                     [cacheTransferNewContainers addObject:container];
                                                                                 }
                                                                             }];
                                                                             
                                                                             
                                                                             strongSelf.transferNewsOffset += transferNewContainers.count;
                                                                             if (transferNewContainers.count < 5) {
                                                                                 [strongSelf.transferTableView.mj_footer endRefreshingWithNoMoreData];
                                                                             }
                                                                             
                                                                             [strongSelf.transferTableView reloadData];
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheTransferNewContainers
                                                                                                       forKey:transferNewsListCacheKey
                                                                                                        block:NULL];
                                                                             
                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                     [strongSelf.transferTableView.mj_header endRefreshing];
                                                                 }];
}

- (void)loadMoreTransferData
{
    __weak typeof(self) weakSelf = self;
    [[HttpSessionManager sharedInstance] requestTransferNewsWithOffset:self.transferNewsOffset
                                                          limitsOfPage:5
                                                                 block:^(NSArray<NSDictionary *> *transferNewContainers, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     BOOL hasMoreData = YES;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (transferNewContainers.count > 0) {
                                                                             NSMutableArray<TransferNewContainer *> *cacheTransferNewContainers = [NSMutableArray array];
                                                                             [weakSelf.transferTableView beginUpdates];
                                                                             
                                                                             [transferNewContainers enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 TransferNewContainer *container = [[TransferNewContainer alloc] initWithDictionary:dic error:nil];
                                                                                 if (container) {
                                                                                     [strongSelf.transferNewManager.transferNewContainers addObject:container];
                                                                                     [strongSelf.transferTableView insertSections:[NSIndexSet indexSetWithIndex:strongSelf.transferNewManager.transferNewContainers.count-1] withRowAnimation:UITableViewRowAnimationBottom];
                                                                                     [cacheTransferNewContainers addObject:container];
                                                                                     
                                                                                 }
                                                                             }];
                                                                             
                                                                             [weakSelf.transferTableView endUpdates];
                                                                             
                                                                             strongSelf.transferNewsOffset += transferNewContainers.count;
                                                                             if (transferNewContainers.count < 5) {
                                                                                 [strongSelf.transferTableView.mj_footer endRefreshingWithNoMoreData];
                                                                                 hasMoreData = NO;
                                                                             }
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheTransferNewContainers
                                                                                                       forKey:transferNewsListCacheKey
                                                                                                        block:NULL];
                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                     if (hasMoreData) {
                                                                         [strongSelf.transferTableView.mj_header endRefreshing];
                                                                     }
                                                                 }];
}

- (void)reloadHotwordsData
{
    self.hotwordsNewsOffset = 0;
    self.hotwordsNewsFirstRequest = NO;
    __weak typeof(self) weakSelf = self;
    [[HttpSessionManager sharedInstance] requestTransferNewsWithOffset:self.hotwordsNewsOffset
                                                          limitsOfPage:self.limitForRequest
                                                                 block:^(NSArray<NSDictionary *> *hotwordsNews, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (hotwordsNews.count > 0) {
                                                                             NSMutableArray<HotWordNew *> *cacheHotWordNews = [NSMutableArray array];
                                                                             [strongSelf.hotWordNewManager.hotWordNewContainers removeAllObjects];
                                                                             [hotwordsNews enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 HotWordNew *hotWordNew = [[HotWordNew alloc] initWithDictionary:dic error:nil];
                                                                                 if (hotWordNew) {
                                                                                     [strongSelf.hotWordNewManager addHotWordNew:hotWordNew];
                                                                                     [cacheHotWordNews addObject:hotWordNew];
                                                                                 }
                                                                             }];
                                                                             
                                                                             
                                                                             strongSelf.hotwordsNewsOffset += hotwordsNews.count;
                                                                             if (hotwordsNews.count < strongSelf.limitForRequest) {
                                                                                 [strongSelf.hotwordsTableView.mj_footer endRefreshingWithNoMoreData];
                                                                             }
                                                                             
                                                                             [strongSelf.hotwordsTableView reloadData];
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheHotWordNews
                                                                                                       forKey:hotwordsNewsListCacheKey
                                                                                                        block:NULL];
                                                                             
                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                     [strongSelf.hotwordsTableView.mj_header endRefreshing];
                                                                 }];
}

- (void)loadMoreHotwordsData
{
    __weak typeof(self) weakSelf = self;
    [[HttpSessionManager sharedInstance] requestTransferNewsWithOffset:self.hotwordsNewsOffset
                                                          limitsOfPage:self.limitForRequest
                                                                 block:^(NSArray<NSDictionary *> *hotwordsNews, NSError *error) {
                                                                     
                                                                     __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                     
                                                                     BOOL hasMoreData = YES;
                                                                     
                                                                     if (!error) {
                                                                         
                                                                         if (hotwordsNews.count > 0) {
                                                                             NSMutableArray<HotWordNew *> *cacheHotWordNews = [NSMutableArray array];
                                                                             [weakSelf.hotwordsTableView beginUpdates];
                                                                             
                                                                             [hotwordsNews enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                                 HotWordNew *hotWordNew = [[HotWordNew alloc] initWithDictionary:dic error:nil];
                                                                                 if (hotWordNew) {
                                                                                     NSIndexPath *indexPath = [strongSelf.hotWordNewManager addHotWordNew:hotWordNew];
                                                                                     [strongSelf.hotwordsTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                                                                                     [cacheHotWordNews addObject:hotWordNew];
                                                                                 }
                                                                             }];
                                                                             
                                                                             [weakSelf.hotwordsTableView endUpdates];
                                                                             
                                                                             strongSelf.hotwordsNewsOffset += hotwordsNews.count;
                                                                             if (hotwordsNews.count < strongSelf.limitForRequest) {
                                                                                 [strongSelf.hotwordsTableView.mj_footer endRefreshingWithNoMoreData];
                                                                                 hasMoreData = NO;
                                                                             }
                                                                             
                                                                             [[TMCache sharedCache] setObject:cacheHotWordNews
                                                                                                       forKey:hotwordsNewsListCacheKey
                                                                                                        block:NULL];
                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                     if (hasMoreData) {
                                                                         [strongSelf.hotwordsTableView.mj_header endRefreshing];
                                                                     }
                                                                 }];
}

#pragma mark - 切换语言响应方法
- (void)languageDidChanged
{
    self.title = LTZLocalizedString(@"view_controller_title", nil);
    self.dropdownMenu.items = @[[[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_global", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lck", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_eulcs", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lpl", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_nalcs", nil)],
                                [[DropdownMenuItem alloc] initWithTitle:LTZLocalizedString(@"local_item_lms", nil)]
                                ];
    [self.dropdownMenu reloadItems];
    
    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateNormal];
    [self.button setTitle:LTZLocalizedString(@"local_bar_item", nil) forState:UIControlStateHighlighted];
    
    [self.segmentedControl setTitle:LTZLocalizedString(@"news_type_hot", nil) forSegmentAtIndex:0];
    [self.segmentedControl setTitle:LTZLocalizedString(@"news_type_transfer", nil) forSegmentAtIndex:1];
    [self.segmentedControl setTitle:LTZLocalizedString(@"news_type_headlines", nil) forSegmentAtIndex:2];
    
    [self.hotfocusTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.hotfocusTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.hotfocusTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    
    [self.hotfocusTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.hotfocusTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.hotfocusTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    
    [self.transferTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.transferTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.transferTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    
    [self.transferTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.transferTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.transferTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    
    [self.hotwordsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_pull_down_title", nil) forState:MJRefreshStateIdle];
    [self.hotwordsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_release_title", nil) forState:MJRefreshStatePulling];
    [self.hotwordsTableViewHeader setTitle:LTZLocalizedString(@"tableview_header_loading_title", nil) forState:MJRefreshStateRefreshing];
    
    [self.hotwordsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_normal_title", nil) forState:MJRefreshStateIdle];
    [self.hotwordsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_loading_title", nil) forState:MJRefreshStateRefreshing];
    [self.hotwordsTableViewFooter setTitle:LTZLocalizedString(@"tableview_footer_no_data_title", nil) forState:MJRefreshStateNoMoreData];
    
    [self.hotfocusTableView.mj_header beginRefreshing];
    [self.transferTableView.mj_header beginRefreshing];
    [self.hotwordsTableView.mj_header beginRefreshing];
}

#pragma mark - UISegmentedControl响应事件
-(void)segmentAction:(UISegmentedControl *)SegmentedControl
{
    NSInteger index = SegmentedControl.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            if (self.currentNewsType != NewsTypeHotFocus) {
                self.currentNewsType = NewsTypeHotFocus;
            }
        }
            break;
        case 1:
        {
            if (self.currentNewsType != NewsTypeHotTransfer) {
                self.currentNewsType = NewsTypeHotTransfer;
                if (self.transferNewsFirstRequest) {
                    // 请求转会新闻数据
                    [self.transferTableView.mj_header beginRefreshing];
                }
            }
        }
            break;
        case 2:
        {
            if (self.currentNewsType != NewsTypeHotWords) {
                self.currentNewsType = NewsTypeHotWords;
                if (self.hotwordsNewsFirstRequest) {
                    // 请求热门话题数据
                    [self.hotwordsTableView.mj_header beginRefreshing];
                }
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.hotfocusTableView]) {
        if (indexPath.row == 0 && self.images.count > 0) {
            return [NewsRotationImageCell cellHeightWithWidth:CGRectGetWidth([[UIScreen mainScreen] bounds])];
        }else{
            return [HotFocusNewCell cellHeight];
        }
    }
    return 44.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.hotfocusTableView]) {
        return 0;
    }else{
        return [NewsTableViewHeader headerHeight];
    }
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.hotfocusTableView]) {
        return nil;
    }else{
        NewsTableViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[NewsTableViewHeader headerReuseIdentifier]];
        if ([tableView isEqual:self.transferTableView]) {
            header.date = self.transferNewManager.transferNewContainers[section].date;
        }else if ([tableView isEqual:self.hotwordsTableView]){
            //header.date = self.transferNewManager.transferNewContainers[section].date;
        }
        return header;
    }
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
    if ([tableView isEqual:self.hotfocusTableView]) {
        
        NSInteger number = self.hotFocusNews.count;
        if (self.images.count > 0) {
            ++number;
            self.showImages = YES;
        }
        return number;
        
    }/*else if ([tableView isEqual:self.transferTableView]) {
        return self.transferNewManager.transferNewContainers[section].transferNews.count;
    }else if ([tableView isEqual:self.hotwordsTableView]) {
        return self.hotWordNewManager.hotWordNewContainers[section].hotWordNews.count;
    }*/
    
    return 0;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.hotfocusTableView]) {
        
        if (self.images.count > 0 && indexPath.row == 0) {
            NewsRotationImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewsRotationImageCell cellIdentifier]
                                                                          forIndexPath:indexPath];
            cell.images = self.images;
            [cell setClikedBlock:^(NSInteger index) {
                
            }];
            return cell;
        }else {
            HotFocusNewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HotFocusNewCell cellIdentifier]
                                                                    forIndexPath:indexPath];
            cell.hotFocusNew = self.showImages ? self.hotFocusNews[indexPath.row-1]:self.hotFocusNews[indexPath.row];
            return cell;
        }
        
    }else if ([tableView isEqual:self.transferTableView]) {
        
    }else if ([tableView isEqual:self.hotwordsTableView]) {
        
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.hotfocusTableView]) {
        return 1;
    }else if ([tableView isEqual:self.transferTableView]) {
        return self.transferNewManager.transferNewContainers.count;
    }/*else if ([tableView isEqual:self.hotwordsTableView]) {
        return self.hotWordNewManager.hotWordNewContainers.count;
    }*/
    return 0;
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
