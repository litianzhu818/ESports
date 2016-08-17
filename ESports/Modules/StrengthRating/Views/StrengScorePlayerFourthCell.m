//
//  StrengScorePlayerFourthCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/17.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScorePlayerFourthCell.h"

@interface StrengScorePlayerFourthCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noDataTitleLabel;

@end

@implementation StrengScorePlayerFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"win_rate_title":@"personal game data"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"win_rate_title":@"个人比赛数据"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"win_rate_title":@"個人比賽數據"
                                           }
                                   };
    
    self.titleLabel.textColor = HexColor(0x5ed2f7);
    self.titleLabel.text = LTZLocalizedString(@"win_rate_title", nil);
    self.noDataTitleLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    
    CGContextSetStrokeColorWithColor(context, HexColor(0x1f262e).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 30);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, 30);   //终点坐标
    
    CGContextStrokePath(context);
}

- (void)setPlayerDetail:(StrengScorePlayerDetail *)playerDetail
{
    _playerDetail = playerDetail;
    
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.playerDetail.playerGlobalRanking == 0) {
        self.noDataTitleLabel.hidden = NO;
    }else{
        self.noDataTitleLabel.hidden = YES;
    }
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScorePlayerFourthCell class])
                          bundle:[NSBundle bundleForClass:[StrengScorePlayerFourthCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScorePlayerFourthCell class]);
}

+ (CGFloat)cellHeight
{
    return 180;
}

#pragma mark - language change action
- (void)languageDidChanged
{
    self.titleLabel.text = LTZLocalizedString(@"win_rate_title", nil);
}


@end
