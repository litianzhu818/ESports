//
//  NewsTableViewHeader.m
//  ESports
//
//  Created by Peter Lee on 16/7/15.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "NewsTableViewHeader.h"

@interface NewsTableViewHeader ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NewsTableViewHeader

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([NewsTableViewHeader class])
                          bundle:[NSBundle bundleForClass:[NewsTableViewHeader class]]];
}

+ (NSString *)headerReuseIdentifier
{
    return NSStringFromClass([NewsTableViewHeader class]);
}

+ (CGFloat)headerHeight
{
    return 40.0f;
}

#pragma mark - Initialization
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = HexColor(0x16212f);
    self.backgroundView = backgroundView;
    
    self.titleLabel.textColor = HexColor(0xa7a9ac);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"2":@"Monday",
                                           @"3":@"Tuesday",
                                           @"4":@"Wednesday",
                                           @"5":@"Thursday",
                                           @"6":@"Friday",
                                           @"7":@"Saturday",
                                           @"1":@"Sunday"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"2":@"星期一",
                                           @"3":@"星期二",
                                           @"4":@"星期三",
                                           @"5":@"星期四",
                                           @"6":@"星期五",
                                           @"7":@"星期六",
                                           @"1":@"星期日"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"2":@"星期一",
                                           @"3":@"星期二",
                                           @"4":@"星期三",
                                           @"5":@"星期四",
                                           @"6":@"星期五",
                                           @"7":@"星期六",
                                           @"1":@"星期日"
                                           }
                                   };
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.date) return;
    
    NSString *dateString = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    dateString = [formatter stringFromDate:self.date];
    NSString *weekString = nil;
    NSCalendar* calendar = nil;
    NSDateComponents* components = nil;
    if (IOS_VERSION_ABOVE(8.0)) {
        calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        components = [calendar components:NSCalendarUnitWeekday fromDate:self.date];
    }else{
        calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        components = [calendar components:NSWeekdayCalendarUnit fromDate:self.date];
    }
    
    weekString = [NSString stringWithFormat:@"%ld",(long)components.weekday];

    weekString = [NSString stringWithFormat:@"%@%@",dateString, LTZLocalizedString(weekString, nil)];
    
    self.titleLabel.text = weekString;
    
}

- (void)languageDidChanged
{
    [self setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
