//
//  ResultMatchCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "ResultMatchCell.h"
#import "UIImageView+WebCache.h"

@interface ResultMatchCell ()

@property (weak, nonatomic) IBOutlet UIImageView *aTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *aTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *bTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *centerLineImageView;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (weak, nonatomic) IBOutlet UILabel *aScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bScoreLabel;

@end

@implementation ResultMatchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.aTeamNameLabel.textColor = HexColor(0xfbfbfb);
    self.bTeamNameLabel.textColor = HexColor(0xfbfbfb);
    self.centerLineImageView.backgroundColor = HexColor(0x000000);
    self.aScoreLabel.backgroundColor = HexColor(0x19293e);
    self.aScoreLabel.textColor = HexColor(0xfbfbfb);
    self.bScoreLabel.backgroundColor = HexColor(0x19293e);
    self.bScoreLabel.textColor = HexColor(0xfbfbfb);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"watch_title":@"Game result"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"watch_title":@"比赛结果"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"watch_title":@"比賽結果"
                                           }
                                   };
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 4);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, HexColor(0x121b27).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height-4.0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-4.0);   //终点坐标
    CGContextStrokePath(context);
}

- (void)setResultMatch:(ResultMatch *)resultMatch
{
    _resultMatch = resultMatch;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.aTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.resultMatch.aTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    [self.bTeamImageView sd_setImageWithURL:[NSURL URLWithString:self.resultMatch.bTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.aTeamNameLabel.text = self.resultMatch.aTeamName;
    self.bTeamNameLabel.text = self.resultMatch.bTeamName;
    
    NSInteger aScore = [self.resultMatch.aScore integerValue];
    NSInteger bScore = [self.resultMatch.bScore integerValue];
    
    if (aScore == bScore) {
        self.aScoreLabel.textColor = HexColor(0xc1c1c1);
        self.bScoreLabel.textColor = HexColor(0xc1c1c1);
    }else if (aScore > bScore) {
        self.aScoreLabel.textColor = HexColor(0x449d0f);
        self.bScoreLabel.textColor = HexColor(0xfe2d2d);
    }else if (aScore < bScore) {
        self.aScoreLabel.textColor = HexColor(0xfe2d2d);
        self.bScoreLabel.textColor = HexColor(0x449d0f);
    }
    
    self.aScoreLabel.text = self.resultMatch.aScore;
    self.bScoreLabel.text = self.resultMatch.bScore;
    
    self.stateButton.clipsToBounds = YES;
    self.stateButton.layer.cornerRadius = 4.0f;
    self.stateButton.layer.borderColor = HexColor(0x1e66b7).CGColor;
    self.stateButton.layer.borderWidth = 1.0f;
    [self.stateButton setBackgroundColor:HexColor(0x1e66b7)];
    [self.stateButton setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
    [self.stateButton setTitleColor:[HexColor(0xffffff) colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    [self.stateButton setTitle:LTZLocalizedString(@"watch_title", nil) forState:UIControlStateNormal];
    [self.stateButton setTitle:LTZLocalizedString(@"watch_title", nil) forState:UIControlStateHighlighted];
}

- (IBAction)replayButtonAction:(id)sender
{
    if (self.replayBlock) {
        self.replayBlock(self.resultMatch);
    }
}

- (void)languageDidChanged
{
    [self setNeedsLayout];
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([ResultMatchCell class])
                          bundle:[NSBundle bundleForClass:[ResultMatchCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([ResultMatchCell class]);
}

+ (CGFloat)cellHeight
{
    return 89;
}

@end
