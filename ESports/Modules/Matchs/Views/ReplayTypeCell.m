//
//  ReplayTypeCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/26.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "ReplayTypeCell.h"
#import "HMSegmentedControl.h"

@interface ReplayTypeCell ()

@property (strong, nonatomic) HMSegmentedControl *segmentedControl;

@end

@implementation ReplayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"team_title":@"team data",
                                           @"player_title":@"players",
                                           @"video_title":@"replay"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"team_title":@"队伍数据",
                                           @"player_title":@"选手数据",
                                           @"video_title":@"重播"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"team_title":@"隊伍數據",
                                           @"player_title":@"選手數據",
                                           @"video_title":@"重播"
                                           }
                                   };
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[LTZLocalizedString(@"team_title", nil),LTZLocalizedString(@"player_title", nil),LTZLocalizedString(@"video_title", nil)]];
    self.segmentedControl.frame = CGRectMake(0, 0,CGRectGetWidth([[UIScreen mainScreen] bounds]), 44);
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    //self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.titleTextAttributes = @{
                                                  NSFontAttributeName:[UIFont systemFontOfSize:15.0],
                                                  NSForegroundColorAttributeName:HexColor(0xfeffff)
                                                  };
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.backgroundColor = [UIColor clearColor];
    self.segmentedControl.selectedTitleTextAttributes = @{
                                                          NSFontAttributeName:[UIFont systemFontOfSize:15.0], 
                                                          NSForegroundColorAttributeName:HexColor(0x6ed4ff)
                                                          };
 
    self.segmentedControl.selectionIndicatorColor = HexColor(0x6ed4ff);
    
    [self.contentView addSubview:self.segmentedControl];
    
    WEAK_SELF;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        STRONG_SELF;
        if (strongSelf.selectedIndexBlock) {
            strongSelf.selectedIndexBlock(index);
        }
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)languageDidChanged
{
    self.segmentedControl.sectionTitles = @[LTZLocalizedString(@"team_title", nil),LTZLocalizedString(@"player_title", nil),LTZLocalizedString(@"video_title", nil)];
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([ReplayTypeCell class])
                          bundle:[NSBundle bundleForClass:[ReplayTypeCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([ReplayTypeCell class]);
}

+ (CGFloat)cellHeight
{
    return 44.0f;
}

@end
