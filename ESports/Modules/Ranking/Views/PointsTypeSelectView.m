//
//  PointsTypeSelectView.m
//  ESports
//
//  Created by Peter Lee on 16/8/4.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "PointsTypeSelectView.h"

@interface PointsTypeSelectView ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UIButton *backgroundButton;

@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *standingTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *standingTitleLabelWidthConstraint;

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

@implementation PointsTypeSelectView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PointsTypeSelectView class]) owner:nil options:nil] lastObject];
        [self setUp];
    }
    return self;
}

+ (instancetype)instanceFromNib
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PointsTypeSelectView class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUp];
}

- (void)setUp
{
    self.backgroundColor = HexColor(0x121b27);
    
    [self.backgroundView bringSubviewToFront:self.backgroundButton];
    
    self.teamNameLabel.textColor = HexColor(0xa7a8ab);
    
    self.standingTitleLabel.textColor = HexColor(0x8b8d95);
    self.teamNameTitleLabel.textColor = HexColor(0x8b8d95);
    self.winTitleLabel.textColor = HexColor(0x8b8d95);
    self.equalTitleLabel.textColor = HexColor(0x8b8d95);
    self.defeatTitleLabel.textColor = HexColor(0x8b8d95);
    self.scoreTitlelabel.textColor = HexColor(0x8b8d95);
    
    // 拉伸图片
    UIImage *image = [UIImage imageNamed:@"match_points_type_bg"];
    /*
     // 左端盖宽度
     NSInteger leftCapWidth = image.size.width * 0.5f;
     // 顶端盖高度
     NSInteger topCapHeight = image.size.height * 0.5f;
     // 重新赋值
     image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
     */
    CGFloat top = 0; // 顶端盖高度
    CGFloat bottom = 0 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 100; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    [self.backgroundButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.backgroundButton setBackgroundImage:image forState:UIControlStateHighlighted];
    
    //[self.backgroundButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"standing_title":@"Rank",
                                           @"team_title":@"Team",
                                           @"win_title":@"Win",
                                           @"equal_title":@"Draw",
                                           @"defeat_title":@"Loss",
                                           @"score_title":@"Point"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"standing_title":@"排行",
                                           @"team_title":@"战队",
                                           @"win_title":@"胜",
                                           @"equal_title":@"平",
                                           @"defeat_title":@"负",
                                           @"score_title":@"积分"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"standing_title":@"排行",
                                           @"team_title":@"戰隊",
                                           @"win_title":@"勝",
                                           @"equal_title":@"平",
                                           @"defeat_title":@"負",
                                           @"score_title":@"積分"
                                           }
    
                                   };
    
    self.standingTitleLabel.text = LTZLocalizedString(@"standing_title", nil);
    self.teamNameTitleLabel.text = LTZLocalizedString(@"team_title", nil);
    self.winTitleLabel.text = LTZLocalizedString(@"win_title", nil);
    self.equalTitleLabel.text = LTZLocalizedString(@"equal_title", nil);
    self.defeatTitleLabel.text = LTZLocalizedString(@"defeat_title", nil);
    self.scoreTitlelabel.text = LTZLocalizedString(@"score_title", nil);
    
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:60.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:40.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:40.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:50.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:8.0f forView:self.teamNameTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:40.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:20.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:20.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:20.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:10.0f forView:self.teamNameTitleLabel];
    
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:40.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:20.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:20.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:20.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:10.0f forView:self.teamNameTitleLabel];
    }
    
}

- (void)setTeamName:(NSString *)teamName
{
    _teamName = teamName;
    
    self.teamNameLabel.text = _teamName;
}

- (void)languageDidChanged
{
    self.standingTitleLabel.text = LTZLocalizedString(@"standing_title", nil);
    self.teamNameTitleLabel.text = LTZLocalizedString(@"team_title", nil);
    self.winTitleLabel.text = LTZLocalizedString(@"win_title", nil);
    self.equalTitleLabel.text = LTZLocalizedString(@"equal_title", nil);
    self.defeatTitleLabel.text = LTZLocalizedString(@"defeat_title", nil);
    self.scoreTitlelabel.text = LTZLocalizedString(@"score_title", nil);
    
    if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_ENGLISH]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:60.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:40.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:40.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:50.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:8.0f forView:self.teamNameTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_S_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:40.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:20.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:20.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:20.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:10.0f forView:self.teamNameTitleLabel];
        
    }else if ([[LTZLocalizationManager language] isEqualToString:SYS_LANGUAGE_T_CHINESE]) {
        
        [self adjustWidthWidthConstraint:self.standingTitleLabelWidthConstraint value:40.0f forView:self.standingTitleLabel];
        [self adjustWidthWidthConstraint:self.winTitleLabelWidthConstraint value:20.0f forView:self.winTitleLabel];
        [self adjustWidthWidthConstraint:self.equalTitleLabelWidthConstraint value:20.0f forView:self.equalTitleLabel];
        [self adjustWidthWidthConstraint:self.defeatTitleLabelWidthConstraint value:20.0f forView:self.defeatTitleLabel];
        [self adjustWidthWidthConstraint:self.teamNameLeftWidthConstraint value:10.0f forView:self.teamNameTitleLabel];
    }

}

- (IBAction)tapAction:(id)sender
{
    if (self.tapActionBlock) {
        self.tapActionBlock();
    }
}

- (void)adjustWidthWidthConstraint:(NSLayoutConstraint *)widthConstraint value:(CGFloat)value forView:(UIView *)view
{
    widthConstraint.constant = value;
    [view setNeedsUpdateConstraints];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //your code here
//    
//    [super touchesBegan:touches withEvent:event];
//}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //your code here
//    
//    // check touch up inside
//    if ([self superview]) {
//        UITouch *touch = [touches anyObject];
//        CGPoint point = [touch locationInView:[self superview]];
//        //TODO:这里可以将触摸范围扩大，便于操作，例如：
//        CGRect validTouchArea = CGRectMake((self.frame.origin.x - 10),
//                                           (self.frame.origin.y - 10),
//                                           (self.frame.size.width + 10),
//                                           (self.frame.size.height + 10));
//        if (CGRectContainsPoint(validTouchArea, point)) {
//            //your code here
//            [self tapAction:nil];
//        }
//    }
//    
//    [super touchesEnded:touches withEvent:event];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
