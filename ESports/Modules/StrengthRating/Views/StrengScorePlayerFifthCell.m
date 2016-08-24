//
//  StrengScorePlayerFifthCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/17.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScorePlayerFifthCell.h"
#import "HMSegmentedControl.h"
#import "UIImageView+WebCache.h"
#import "IonIcons.h"
#import "PNChartDelegate.h"
#import "PNChart.h"

typedef NS_ENUM(NSUInteger, GamesCount) {
    GamesCount10 = 10,
    GamesCount25 = 25,
    GamesCount40 = 40
};

@interface StrengScorePlayerFifthCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) HMSegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *acturePriceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *acturePriceValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceChangeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceChangeValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *priceChangeImageView;


@property (weak, nonatomic) IBOutlet UILabel *changeRateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeRateValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *changeRateImageView;

@property (weak, nonatomic) IBOutlet UILabel *noDataTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (assign, nonatomic) GamesCount gamesCount;
@property (nonatomic) PNLineChart * lineChart;


@end
@implementation StrengScorePlayerFifthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x192535);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.gamesCount = GamesCount10;
    
    self.titleLabel.textColor = HexColor(0x6ed4fc);
    self.titleLabel.backgroundColor = HexColor(0x131b28);
    
    self.acturePriceTitleLabel.textColor = HexColor(0x6ed3ff);
    self.acturePriceValueLabel.textColor = HexColor(0xffffff);
    
    self.priceChangeTitleLabel.textColor = HexColor(0x6ed3ff);
    self.changeRateTitleLabel.textColor = HexColor(0x6ed3ff);
    
    self.priceChangeValueLabel.textColor = HexColor(0x4aa200);
    self.changeRateValueLabel.textColor = HexColor(0xfd2d2d);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"title":@"Matrix Value Trend",
                                           @"segmented_10_title":@"10 Games",
                                           @"segmented_25_title":@"25 Games",
                                           @"segmented_40_title":@"40 Games",
                                           @"acture_price_title":@"Matrix Value",
                                           @"price_change_title":@"Change",
                                           @"change_rate_title":@"Change(%)"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"title":@"Matrix价值走势",
                                           @"segmented_10_title":@"10局",
                                           @"segmented_25_title":@"25局",
                                           @"segmented_40_title":@"40局",
                                           @"acture_price_title":@"实际价值",
                                           @"price_change_title":@"价值变化",
                                           @"change_rate_title":@"百分比变化"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"title":@"Matrix價值走勢",
                                           @"segmented_10_title":@"10局",
                                           @"segmented_25_title":@"25局",
                                           @"segmented_40_title":@"40局",
                                           @"acture_price_title":@"實際價值",
                                           @"price_change_title":@"價值變化",
                                           @"change_rate_title":@"百分比變化"
                                           }
                                   };
    
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[LTZLocalizedString(@"segmented_10_title", nil),
                                                                                LTZLocalizedString(@"segmented_25_title", nil),
                                                                                LTZLocalizedString(@"segmented_40_title", nil)]];
    self.segmentedControl.frame = CGRectMake(0, 30,CGRectGetWidth([[UIScreen mainScreen] bounds]), 30);
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.titleTextAttributes = @{
                                                  NSFontAttributeName:[UIFont systemFontOfSize:15.0],
                                                  NSForegroundColorAttributeName:HexColor(0xfeffff)
                                                  };
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.backgroundColor = HexColor(0x00e1720);
    /*
     self.segmentedControl.selectedTitleTextAttributes = @{
     NSFontAttributeName:[UIFont systemFontOfSize:15.0],
     NSForegroundColorAttributeName:HexColor(0x6ed4ff)
     };
     */
    
    self.segmentedControl.selectionIndicatorColor = HexColor(0x6ed4ff);
    
    [self.contentView addSubview:self.segmentedControl];
    
    WEAK_SELF;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        STRONG_SELF;
        if (index == 0) {
            if (strongSelf.gamesCount != GamesCount10) {
                strongSelf.gamesCount = GamesCount10;
            }
        }else if (index == 1) {
            if (strongSelf.gamesCount != GamesCount25) {
                strongSelf.gamesCount = GamesCount25;
            }
        }else if (index == 2) {
            if (strongSelf.gamesCount != GamesCount40) {
                strongSelf.gamesCount = GamesCount40;
            }
        }
    }];
    
    
    self.titleLabel.text = LTZLocalizedString(@"title", nil);
    self.acturePriceTitleLabel.text = LTZLocalizedString(@"acture_price_title", nil);
    self.priceChangeTitleLabel.text = LTZLocalizedString(@"price_change_title", nil);
    self.changeRateTitleLabel.text = LTZLocalizedString(@"change_rate_title", nil);
    
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 110.0, SCREEN_WIDTH, 140)];
    self.lineChart.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    self.lineChart.showCoordinateAxis = YES;
    
    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    self.lineChart.axisColor = HexColor(0x274a68);
    self.lineChart.axisWidth = 1.0f;
    self.lineChart.xLabelColor = HexColor(0xffffff);
    self.lineChart.yLabelColor = HexColor(0xffffff);
    self.lineChart.xLabelFont = [UIFont systemFontOfSize:13.0f];
    self.lineChart.yLabelFont = [UIFont systemFontOfSize:13.0f];
    self.lineChart.yGridLinesColor = HexColor(0x047f7c);
    
    self.lineChart.showYGridLines = YES;
    self.lineChart.showSmoothLines = NO;
    self.lineChart.thousandsSeparator = YES;
    self.lineChart.showGenYLabels = YES;
    //self.lineChart.delegate = self;
    [self.contentView addSubview:self.lineChart];
    
    
    self.noDataTitleLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setGamesCount:(GamesCount)gamesCount
{
    _gamesCount = gamesCount;
    
    [self setNeedsLayout];
}

- (void)setPlayerDetail:(StrengScorePlayerDetail *)playerDetail
{
    _playerDetail = playerDetail;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.playerDetail) return;
    
    if (!self.playerDetail.playeRoleRankinge && [self.playerDetail.playeRoleRankinge isEqualToString:@"0"]) {
        self.noDataTitleLabel.hidden = NO;
        self.segmentedControl.hidden = YES;
        self.backView.hidden = YES;
        self.lineChart.hidden = YES;
        return;
    }else{
        self.noDataTitleLabel.hidden = YES;
        self.segmentedControl.hidden = NO;
        self.backView.hidden = NO;
        self.lineChart.hidden = NO;
    
    }
    
    NSInteger minPrice = [self.playerDetail.playerPriceList.firstObject integerValue];
    NSInteger maxPrice = [self.playerDetail.playerPriceList[self.gamesCount-1] integerValue];
    
    NSInteger priceChange = minPrice - maxPrice;
    
    UIImage *image = nil;
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        if (priceChange < 0) {
            self.priceChangeValueLabel.textColor = HexColor(0xff2e2a);
            self.changeRateValueLabel.textColor = HexColor(0xff2e2a);
            image = [IonIcons imageWithIcon:icon_arrow_down_c size:15.0f color:HexColor(0xff2e2a)];
        }else{
            self.priceChangeValueLabel.textColor = HexColor(0x46a201);
            self.changeRateValueLabel.textColor = HexColor(0x46a201);
            image = [IonIcons imageWithIcon:icon_arrow_up_c size:15.0f color:HexColor(0x46a201)];
        }
    }else{
        if (priceChange < 0) {
            
            self.priceChangeValueLabel.textColor = HexColor(0x46a201);
            self.changeRateValueLabel.textColor = HexColor(0x46a201);
            image = [IonIcons imageWithIcon:icon_arrow_down_c size:15.0f color:HexColor(0x46a201)];
        }else{
            
            self.priceChangeValueLabel.textColor = HexColor(0xff2e2a);
            self.changeRateValueLabel.textColor = HexColor(0xff2e2a);
            image = [IonIcons imageWithIcon:icon_arrow_up_c size:15.0f color:HexColor(0xff2e2a)];
        }
    }
    self.acturePriceValueLabel.text = [NSString stringWithFormat:@"%@",[self getStringFromStrength:minPrice]];
    self.priceChangeValueLabel.text = [NSString stringWithFormat:@"%@",[self getStringFromStrength:labs(priceChange)]];
    if (priceChange == 0) {
        self.changeRateValueLabel.text = [NSString stringWithFormat:@"%.2f%@",0.00,@"%"];
    }else{
        self.changeRateValueLabel.text = [NSString stringWithFormat:@"%.1f%@",fabs(priceChange*1.0/maxPrice)*100,@"%"];
    }
    
    self.priceChangeImageView.image = image;
    self.changeRateImageView.image = image;
    
    NSMutableArray *xDatas = [NSMutableArray array];
    NSMutableArray *yDatas = [NSMutableArray array];
    NSInteger interval = 1;
    
    if (self.gamesCount == GamesCount10) {
        interval = 1;
    }else if (self.gamesCount == GamesCount25) {
        interval = 2;
    }else if (self.gamesCount == GamesCount40) {
        interval = 3;
    }
    
    for (NSInteger index = 1 ; index <= self.gamesCount; index = index + interval) {
        [xDatas addObject:[NSString stringWithFormat:@"%ld",(unsigned long)index]];
    }
    
    for (NSInteger index = self.gamesCount ; index > 0; index = index - interval) {
        [yDatas addObject:self.playerDetail.playerPriceList[index-1]];
    }
    
    
    NSInteger line = 6;
    NSArray *sortArray = [yDatas sortedArrayUsingComparator:^NSComparisonResult(NSString * _Nonnull value1, NSString *  _Nonnull value2) {
        
        if ([value1 integerValue] > [value2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([value1 integerValue] < [value2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSInteger minValue = [sortArray.firstObject integerValue];
    NSInteger maxValue = [sortArray.lastObject integerValue];
    
    NSInteger allInterval = maxValue - minValue + 20;
    
    NSInteger eachMinInterval = (NSInteger)ceil(allInterval*1.0000 / line);
    
    self.lineChart.yFixedValueMin = minValue - 10;
    self.lineChart.yFixedValueMax = minValue - 10 + eachMinInterval * line;
    
    NSMutableArray *yLabelValues = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 6; ++index) {
        [yLabelValues addObject:[self getStringFromStrength:(self.lineChart.yFixedValueMin + index * eachMinInterval)]];
    }
    
    [self.lineChart setXLabels:xDatas];
    [self.lineChart setYLabels:yLabelValues];
    
    PNLineChartData *data = [PNLineChartData new];
    data.dataTitle = @"strength";
    data.color = HexColor(0x02fffd);
    data.lineWidth = 1.0f;
    data.itemCount = yDatas.count;
    data.inflexionPointColor = HexColor(0x02fffd);
    data.inflexionPointStyle = PNLineChartPointStyleCircle;
    data.inflexionPointWidth = 4.0f;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [(NSString *)yDatas[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    if (self.lineChart.chartData) {
        [self.lineChart updateChartData:@[data]];
    }else{
        self.lineChart.chartData = @[data];
    }
    
    [self.lineChart strokeChart];
}

- (NSString *)getStringFromStrength:(NSInteger)strength
{
    NSString *strengthStr = nil;
    if (strength < 1000) {
        strengthStr = [NSString stringWithFormat:@"%ld",(unsigned long)strength];
    }else if (strength >= 1000 && strength < 1000000) {
        strengthStr = [NSString stringWithFormat:@"%.1fK",strength/1000.0f];
    }else if (strength >= 1000000) {
        strengthStr = [NSString stringWithFormat:@"%.1fM",strength/1000000.0f];
    }
    
    return strengthStr;
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScorePlayerFifthCell class])
                          bundle:[NSBundle bundleForClass:[StrengScorePlayerFifthCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScorePlayerFifthCell class]);
}

+ (CGFloat)cellHeight
{
    return 250;
}

#pragma mark - language change action
- (void)languageDidChanged
{
    self.titleLabel.text = LTZLocalizedString(@"title", nil);
    self.acturePriceTitleLabel.text = LTZLocalizedString(@"acture_price_title", nil);
    self.priceChangeTitleLabel.text = LTZLocalizedString(@"price_change_title", nil);
    self.changeRateTitleLabel.text = LTZLocalizedString(@"change_rate_title", nil);
    
    self.segmentedControl.sectionTitles = @[LTZLocalizedString(@"segmented_10_title", nil),
                                            LTZLocalizedString(@"segmented_25_title", nil),
                                            LTZLocalizedString(@"segmented_40_title", nil)];
}


@end
