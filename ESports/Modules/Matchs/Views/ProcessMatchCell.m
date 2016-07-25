//
//  ProcessMatchCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "ProcessMatchCell.h"
#import "UIImageView+WebCache.h"
#import "NSObject+locale.h"
#import "IonIcons.h"
#import "DBManager.h"
#import <EventKit/EventKit.h>
#import "NSObject+Custom.h"

typedef struct CountDownTimeModel{
    long day;
    long hour;
    long minute;
    long second;
} CDTM;

@interface ProcessMatchCell ()

@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UILabel *topTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *topBoLabel;
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topAteamImageView;
@property (weak, nonatomic) IBOutlet UILabel *topScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topBteamImageView;
@property (weak, nonatomic) IBOutlet UIImageView *aTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *aTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *bTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *centerLineImageView;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subscribeButtonWidthConstraint;

@end

@implementation ProcessMatchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.topContainer.backgroundColor = HexColor(0x19293e);
    self.topTimeLabel.textColor = HexColor(0x84dbff);
    self.topBoLabel.textColor = HexColor(0xbacf57);
    self.aTeamNameLabel.textColor = HexColor(0xfbfbfb);
    self.bTeamNameLabel.textColor = HexColor(0xfbfbfb);
    self.centerLineImageView.backgroundColor = HexColor(0x000000);
    [self.subscribeButton setImage:[IonIcons imageWithIcon:icon_ios7_alarm size:16.0f color:HexColor(0x84dbff)] forState:UIControlStateNormal];
    [self.subscribeButton setImage:[IonIcons imageWithIcon:icon_ios7_alarm size:16.0f color:HexColor(0x84dbff)] forState:UIControlStateHighlighted];
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"top_title":@"expected:",
                                           @"subscribe_title":@"subscribe",
                                           @"subscribed_title":@"subscribed",
                                           @"watch_title":@"live",
                                           @"time_title":@"remaining %ld h %ld m",
                                           @"event_notice_title":@"At %@,There is a match for %@ and %@",
                                           @"create_event_success_title":@"creating event success"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"top_title":@"预计比分:",
                                           @"subscribe_title":@"订阅",
                                           @"subscribed_title":@"已订阅",
                                           @"watch_title":@"查看直播",
                                           @"time_title":@"剩%ld小时%ld分",
                                           @"event_notice_title":@"你在%@有%@和%@的比赛，请不要忘记观看",
                                           @"create_event_success_title":@"已订阅提醒通知"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"top_title":@"預計比分:",
                                           @"subscribe_title":@"訂閱",
                                           @"subscribed_title":@"已訂閱",
                                           @"watch_title":@"查看直播",
                                           @"time_title":@"剩%ld小時%ld分",
                                           @"event_notice_title":@"你在%@有%@和%@的比賽，請不要忘記觀看",
                                           @"create_event_success_title":@"已訂閱提醒通知"
                                           }
                                   };
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProcessMatch:(ProcessMatch *)processMatch
{
    _processMatch = processMatch;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm aa"];
    [formatter setLocale:[self currentLocale]];
    self.topTimeLabel.text = [formatter stringFromDate:self.processMatch.date];
    
    self.topBoLabel.text = self.processMatch.bo;
    self.topTitleLabel.text = LTZLocalizedString(@"top_title", nil);
    [self.topAteamImageView sd_setImageWithURL:[NSURL URLWithString:self.processMatch.aTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    [self.topBteamImageView sd_setImageWithURL:[NSURL URLWithString:self.processMatch.bTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    [self.aTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.processMatch.aTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    [self.bTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.processMatch.bTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.topScoreLabel.text = self.processMatch.scorePrediction;
    self.aTeamNameLabel.text = self.processMatch.aTeamName;
    self.bTeamNameLabel.text = self.processMatch.bTeamName;
    
    if (self.processMatch.liveStreamPage.length > 0) { // 正在直播
        self.stateButton.clipsToBounds = YES;
        self.stateButton.layer.cornerRadius = 4.0f;
        self.stateButton.layer.borderColor = HexColor(0xff3b3b).CGColor;
        self.stateButton.layer.borderWidth = 1.0f;
        [self.stateButton setBackgroundColor:HexColor(0xff3b3b)];
        [self.stateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.stateButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
        [self.stateButton setTitle:LTZLocalizedString(@"watch_title", nil) forState:UIControlStateNormal];
        [self.stateButton setTitle:LTZLocalizedString(@"watch_title", nil) forState:UIControlStateHighlighted];
        [self.stateButton setEnabled:YES];
        
        self.subscribeButton.hidden = YES;
        self.subscribeButtonWidthConstraint.constant = 0;
        [self.subscribeButton setNeedsUpdateConstraints];
        [self.centerLineImageView setNeedsUpdateConstraints];
        //[self.aTeamNameLabel setNeedsUpdateConstraints];
        //[self.bTeamNameLabel setNeedsUpdateConstraints];
        
    }else{
        self.stateButton.clipsToBounds = YES;
        self.stateButton.layer.cornerRadius = 4.0f;
        self.stateButton.layer.borderColor = HexColor(0x213954).CGColor;
        self.stateButton.layer.borderWidth = 1.0f;
        [self.stateButton setBackgroundColor:HexColor(0x080e16)];
        [self.stateButton setTitleColor:HexColor(0x478aa7) forState:UIControlStateNormal];
        [self.stateButton setTitleColor:HexColor(0x478aa7) forState:UIControlStateHighlighted];
        NSString *stateButtonTitle = [self timeString];
        [self.stateButton setTitle:stateButtonTitle forState:UIControlStateNormal];
        [self.stateButton setTitle:stateButtonTitle forState:UIControlStateHighlighted];
        [self.stateButton setEnabled:NO];
        
        
        self.subscribeButton.hidden = NO;
        self.subscribeButtonWidthConstraint.constant = 78.0f;
        [self.subscribeButton setNeedsUpdateConstraints];
        [self.centerLineImageView setNeedsUpdateConstraints];
        //[self.aTeamNameLabel setNeedsUpdateConstraints];
        //[self.bTeamNameLabel setNeedsUpdateConstraints];
        
        if ([[DBManager sharedInstance] existsSubscribeMatchWithMatchId:self.processMatch.processMatchId]) {
            [self.subscribeButton setTitle:LTZLocalizedString(@"subscribed_title", nil) forState:UIControlStateNormal];
            [self.subscribeButton setTitle:LTZLocalizedString(@"subscribed_title", nil) forState:UIControlStateHighlighted];
            self.subscribeButton.enabled = NO;
        }else{
            [self.subscribeButton setTitle:LTZLocalizedString(@"subscribe_title", nil) forState:UIControlStateNormal];
            [self.subscribeButton setTitle:LTZLocalizedString(@"subscribe_title", nil) forState:UIControlStateHighlighted];
            self.subscribeButton.enabled = YES;
        }
    }
    
    
}

- (void)languageDidChanged
{
    [self setNeedsLayout];
}

- (IBAction)touchOnLiveButtonAction:(id)sender
{
    if (self.liveVideoBlock) {
        self.liveVideoBlock(self.processMatch.liveVideoApp);
    }
}

- (IBAction)touchOnSubscribeButtonAction:(id)sender
{
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        // handle access here
        if (granted) {
            
            NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
            [tempFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            
            //创建事件
            EKEvent *event  = [EKEvent eventWithEventStore:store];
            event.title     = [NSString stringWithFormat:LTZLocalizedString(@"event_notice_title", nil),[tempFormatter stringFromDate:self.processMatch.date],self.processMatch.aTeamName,self.processMatch.bTeamName];
            //event.location = @"test";
            
            event.startDate = [NSDate date];
            event.endDate   = self.processMatch.date;
            event.allDay = NO;
            
            //添加提醒
            [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -10.0f]]; //前十分钟
            [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -30.0f]];//前一天(60.0f * -60.0f * 24)

            
            [event setCalendar:[store defaultCalendarForNewEvents]];
            
            NSError *err;
            [store saveEvent:event span:EKSpanThisEvent error:&err];
            
            [[DBManager sharedInstance] insertSubscribeMatchWithMatchId:self.processMatch.processMatchId
                                                              firstTime:[NSDate dateWithTimeInterval:30.0f sinceDate:event.endDate]
                                                             secondTime:[NSDate dateWithTimeInterval:10.0f sinceDate:event.endDate] completionBlock:^(BOOL result, NSError *error) {
                                                                 if (result) {
                                                                     [self showHudMessage:LTZLocalizedString(@"create_event_success_title", nil)];
                                                                     [self.subscribeButton setTitle:LTZLocalizedString(@"subscribed_title", nil) forState:UIControlStateNormal];
                                                                     [self.subscribeButton setTitle:LTZLocalizedString(@"subscribed_title", nil) forState:UIControlStateHighlighted];
                                                                     self.subscribeButton.enabled = NO;
                                                                 }
                                                            }];
        }else{
            [self showAlertTitle:@"提示" message:@"您没有获取日历事件的权限，请再设置中开启它" cancelButtonTitle:@"知道了" cancelBlock:^{}];
        }
    }];
}

- (NSString *)timeString
{
    //定义一个NSCalendar对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //得到当前时间
    NSDate *currentDate = [NSDate date];
    
    //用来得到具体的时差
    unsigned int unitFlags =  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:currentDate toDate:self.processMatch.date options:0];
    
    CDTM countDownTimeModel = {.day=0,.hour=0,.minute=0,.second=0};
    
    if ([currentDate compare:self.processMatch.date] <= NSOrderedSame) {
        countDownTimeModel.day = [dateComponents day];
        countDownTimeModel.hour = [dateComponents hour];
        countDownTimeModel.minute = [dateComponents minute];
        countDownTimeModel.second = [dateComponents second];
    }
    
    
    return [NSString stringWithFormat:LTZLocalizedString(@"time_title", nil),countDownTimeModel.hour+(countDownTimeModel.day*24),countDownTimeModel.minute];
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([ProcessMatchCell class])
                          bundle:[NSBundle bundleForClass:[ProcessMatchCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([ProcessMatchCell class]);
}

+ (CGFloat)cellHeight
{
    return 110;
}


@end
