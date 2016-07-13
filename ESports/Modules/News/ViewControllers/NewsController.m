//
//  NewsController.m
//  ESports
//
//  Created by Peter Lee on 16/6/30.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "NewsController.h"
#import "DropdownMenu.h"
#import "IonIcons.h"
#import "MJRefresh.h"
#import "TMCache.h"
#import "NewsRotationImage.h"
#import "TransferNewManager.h"
#import "HotWordNewManager.h"
#import "HotFocusNew.h"

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


@property (strong, nonatomic) DropdownMenu *dropdownMenu;
@property (strong, nonatomic) UIButton *button;

@property (assign, nonatomic) NewsType currentNewsType;
@property (assign, nonatomic) NSInteger hotfocusNewsOffset;
@property (assign, nonatomic) NSInteger transferNewsOffset;
@property (assign, nonatomic) NSInteger hotwordsNewsOffset;
@property (assign, nonatomic) NSInteger limitForRequest;

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
                                           @"news_type_headlines":@"Hot words"
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
                                           @"news_type_headlines":@"头条热话"
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
                                           @"news_type_headlines":@"頭條熱話"
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
    self.images = [NSMutableArray array];
    self.hotFocusNews = [NSMutableArray array];
    self.transferNewManager = [[TransferNewManager alloc] init];
    self.hotWordNewManager = [[HotWordNewManager alloc] init];
    
    
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
            [self.view bringSubviewToFront:self.hotwordsTableView];
        }
            break;
        case NewsTypeHotTransfer:
        {
            self.hotfocusTableView.hidden = YES;
            self.transferTableView.hidden = NO;
            self.hotwordsTableView.hidden = YES;
            [self.view bringSubviewToFront:self.transferTableView];
        }
            break;
        case NewsTypeHotWords:
        {
            self.hotfocusTableView.hidden = YES;
            self.transferTableView.hidden = YES;
            self.hotwordsTableView.hidden = NO;
            [self.view bringSubviewToFront:self.hotwordsTableView];
        }
            break;
            
        default:
            break;
    }
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
                }
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate methods

#pragma mark - UITableViewDataSource methods

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
