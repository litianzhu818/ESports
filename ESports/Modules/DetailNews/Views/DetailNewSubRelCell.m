//
//  DetailNewSubRelCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DetailNewSubRelCell.h"
#import "NSObject+Custom.h"

@interface DetailNewSubRelCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeightConstraint;

@end

@implementation DetailNewSubRelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    self.titleLabel.textColor = HexColor(0xcdcecf);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    if (self.notShowBottomLine) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, HexColor(0x213954).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 8.0, rect.size.height-1.0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width-8.0, rect.size.height-1.0);   //终点坐标
    CGContextStrokePath(context);
}

- (void)setNewsTitle:(NSString *)newsTitle
{
    _newsTitle = newsTitle;
    
    self.titleLabel.text = self.newsTitle;
    
    CGFloat titleLabelHeight = [self sizeOfLabelWithString:self.titleLabel.text
                                                      font:self.titleLabel.font
                                                     width:CGRectGetWidth([[UIScreen mainScreen] bounds])-16.0f].height+5.0;
    if (titleLabelHeight >= 40.0) {
        titleLabelHeight = 40.0;
    }
    self.titleLabelHeightConstraint.constant = titleLabelHeight;
    [self.titleLabel setNeedsUpdateConstraints];
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([DetailNewSubRelCell class])
                          bundle:[NSBundle bundleForClass:[DetailNewSubRelCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([DetailNewSubRelCell class]);
}

+ (CGFloat)cellHeight
{
    
    return 57.0f;
}


@end
