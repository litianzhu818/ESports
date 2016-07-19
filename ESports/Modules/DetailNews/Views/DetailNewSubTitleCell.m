//
//  DetailNewSubTitleCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DetailNewSubTitleCell.h"

@interface DetailNewSubTitleCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DetailNewSubTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel.textColor = HexColor(0x6ed4ff);
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
    CGContextSetStrokeColorWithColor(context, HexColor(0x213954).CGColor);  //线的颜色

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 8.0, rect.size.height-1.0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width-8.0, rect.size.height-1.0);   //终点坐标
    CGContextStrokePath(context);
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = _title;
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([DetailNewSubTitleCell class])
                          bundle:[NSBundle bundleForClass:[DetailNewSubTitleCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([DetailNewSubTitleCell class]);
}

+ (CGFloat)cellHeight
{
    return 44.0f;
}

@end
