//
//  MatchStandingCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/4.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchStandingCell.h"
#import "UIImageView+WebCache.h"

@interface MatchStandingCell ()


@property (weak, nonatomic) IBOutlet UILabel *standingTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *standingTitleLabelWidthConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *teamImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *winTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *winTitleLabelWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *equalTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *equalTitleLabelWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *defeatTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defeatTitleLabelWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *scoreTitlelabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *teamNameLeftWidthConstraint;

@end

@implementation MatchStandingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.standingTitleLabel.textColor = HexColor(0x8b8d95);
    self.teamNameTitleLabel.textColor = HexColor(0xffffff);
    self.winTitleLabel.textColor = HexColor(0x449d0f);
    self.equalTitleLabel.textColor = HexColor(0xe7e352);
    self.defeatTitleLabel.textColor = HexColor(0xf82c2d);
    self.scoreTitlelabel.textColor = HexColor(0x68c9f2);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"standing_title":@"standing"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"standing_title":@"排行"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"standing_title":@"排行"
                                           }
                                   };
    
    
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:60.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:40.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:40.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:50.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:8.0f forView:self.teamImageView];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:40.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:20.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:20.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:20.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:10.0f forView:self.teamImageView];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:40.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:20.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:20.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:20.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:10.0f forView:self.teamImageView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.teamImageView sd_setImageWithURL:[NSURL URLWithString:self.pointsTeam.pointsTeamImageUrl] placeholderImage:[UIImage imageNamed:@"占位图片"]];
    
    self.standingTitleLabel.text = self.pointsTeam.pointsRank;
    self.teamNameTitleLabel.text = self.pointsTeam.pointsTeamName;
    self.winTitleLabel.text = self.pointsTeam.pointsWin;
    self.equalTitleLabel.text = self.pointsTeam.pointsDraw;
    self.defeatTitleLabel.text = self.pointsTeam.pointsLoss;
    self.scoreTitlelabel.text = self.pointsTeam.pointsScore;
    
}

- (void)setPointsTeam:(PointsTeam *)pointsTeam
{
    _pointsTeam = pointsTeam;
    
    [self setNeedsLayout];
}

- (void)adjustWidthWidthConstraint:(NSLayoutConstraint *)widthConstraint value:(CGFloat)value forView:(UIView *)view
{
    widthConstraint.constant = value;
    [view setNeedsUpdateConstraints];
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


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchStandingCell class])
                          bundle:[NSBundle bundleForClass:[MatchStandingCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchStandingCell class]);
}

+ (CGFloat)cellHeight
{
    return 44.0f;
}

- (void)languageDidChanged
{
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:60.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:40.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:40.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:50.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:8.0f forView:self.teamImageView];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:40.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:20.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:20.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:20.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:10.0f forView:self.teamImageView];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:40.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:20.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:20.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:20.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:10.0f forView:self.teamImageView];
    }
    
}



@end
