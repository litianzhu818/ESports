//
//  HotWordNewCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "HotWordNewCell.h"
#import "UIButton+WebCache.h"
#import "NSObject+Custom.h"

@interface HotWordNewCell ()

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeightConstraint;

@end

@implementation HotWordNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.titleLabel.textColor = HexColor(0xcdcdce);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:self.hotWordNew.newsImageUrl]
                                         forState:UIControlStateNormal
                                 placeholderImage:[UIImage imageNamed:@"占位图"]];
    [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:self.hotWordNew.newsImageUrl]
                                         forState:UIControlStateHighlighted
                                 placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.titleLabel.text = self.hotWordNew.newsTitle;
    
    CGFloat height = [self sizeOfLabelWithString:self.hotWordNew.newsTitle
                                            font:self.titleLabel.font
                                           width:CGRectGetWidth([[UIScreen mainScreen] bounds])-72.0f].height;
    if (height >= 48.0) {
        height = 48.0;
    }
    self.titleLabelHeightConstraint.constant = height;
    [self.titleLabel setNeedsUpdateConstraints];

}

- (void)setHotWordNew:(HotWordNew *)hotWordNew
{
    _hotWordNew = hotWordNew;
    
    [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 4);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, HexColor(0x16212f).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height-2.0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-2.0);   //终点坐标
    CGContextStrokePath(context);
}

- (IBAction)tapOnTeamLogonAction:(id)sender
{
    if (self.tapOnTeamBlock) {
        self.tapOnTeamBlock(self.hotWordNew.teamId);
    }
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([HotWordNewCell class])
                          bundle:[NSBundle bundleForClass:[HotWordNewCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([HotWordNewCell class]);
}

+ (CGFloat)cellHeight
{
    return 65;
}


@end
