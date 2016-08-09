//
//  StrengScoreTeamCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/9.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScoreTeamCell.h"
#import "UIImageView+WebCache.h"

@interface StrengScoreTeamCell ()

@property (weak, nonatomic) IBOutlet UILabel *rankingTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *regionImageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankingTitleLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scoreTitleLabelWidthConstraint;

@end

@implementation StrengScoreTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.rankingTitleLabel.textColor = HexColor(0x8b8d95);
    self.nameTitleLabel.textColor = HexColor(0xffffff);
    self.scoreTitleLabel.textColor = HexColor(0x68c9f2);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"title":@"team"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"title":@"team"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"title":@"team"
                                           }
                                   };
    
    
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:50.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:80.0f forView:self.scoreTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:30.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:55.0f forView:self.scoreTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:30.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:55.0f forView:self.scoreTitleLabel];
    }
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
    
    CGContextSetStrokeColorWithColor(context, HexColor(0x000000).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height-2.0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-2.0);   //终点坐标
    CGContextStrokePath(context);
    
    
    
    CGContextSetStrokeColorWithColor(context, HexColor(0x182937).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height-1.0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-1.0);   //终点坐标
    CGContextStrokePath(context);
}
- (void)setTeam:(StrengScoreTeam *)team
{
    _team = team;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.rankingTitleLabel.text = self.team.teamRanking;
    [self.teamImageView sd_setImageWithURL:[NSURL URLWithString:self.team.teamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.nameTitleLabel.text = self.team.teamName;
    [self.regionImageView sd_setImageWithURL:[NSURL URLWithString:self.team.teamRegionImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.scoreTitleLabel.text = self.team.teamStrength;
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScoreTeamCell class])
                          bundle:[NSBundle bundleForClass:[StrengScoreTeamCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScoreTeamCell class]);
}

+ (CGFloat)cellHeight
{
    return 44.0f;
}

#pragma mark - tool methods
- (void)adjustWidthWidthConstraint:(NSLayoutConstraint *)widthConstraint value:(CGFloat)value forView:(UIView *)view
{
    widthConstraint.constant = value;
    [view setNeedsUpdateConstraints];
}

#pragma mark - language change action method
- (void)languageDidChanged
{
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:50.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:80.0f forView:self.scoreTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:30.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:55.0f forView:self.scoreTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.rankingTitleLabelWidthConstraint value:30.0f forView:self.rankingTitleLabel];
        [self adjustWidthWidthConstraint:self.scoreTitleLabelWidthConstraint value:55.0f forView:self.scoreTitleLabel];
    }
}

@end
