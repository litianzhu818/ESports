//
//  DetailNewsTopCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/18.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DetailNewsTopCell.h"
#import "NSObject+Custom.h"

@interface DetailNewsTopCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaLabelWdithConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fromLabelWidthConstraint;

@end

@implementation DetailNewsTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.areaLabel.textColor = HexColor(0xcccfd3);
    self.areaLabel.layer.cornerRadius = 2.0f;
    self.areaLabel.clipsToBounds = YES;
    self.areaLabel.backgroundColor = HexColor(0x042946);
    
    self.dateLabel.textColor = HexColor(0xa7a8ab);
    self.fromLabel.textColor = HexColor(0xa7a8ab);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.text = self.detailNew.newsTitle;
    self.areaLabel.text = self.detailNew.newsArea;
    self.fromLabel.text = self.detailNew.newsFrom;
    self.dateLabel.text = self.detailNew.dateString;
    
    
    CGFloat titleLabelHeight = [self sizeOfLabelWithString:self.titleLabel.text
                                                      font:self.titleLabel.font
                                                     width:CGRectGetWidth([[UIScreen mainScreen] bounds])-16.0f].height+5.0;
    if (titleLabelHeight >= 43.0) {
        titleLabelHeight = 43.0;
    }
    self.titleLabelHeightConstraint.constant = titleLabelHeight;
    [self.titleLabel setNeedsUpdateConstraints];
    
    CGFloat areaLabelWidth = [self sizeOfLabelWithString:self.areaLabel.text
                                                      font:self.areaLabel.font
                                                     height:14.0f].width+10;
    self.areaLabelWdithConstraint.constant = areaLabelWidth;
    [self.areaLabel setNeedsUpdateConstraints];
    
    CGFloat fromLabelWidth = [self sizeOfLabelWithString:self.fromLabel.text
                                                    font:self.fromLabel.font
                                                  height:14.0f].width+5;
    self.fromLabelWidthConstraint.constant = fromLabelWidth;
    [self.fromLabel setNeedsUpdateConstraints];
    
}

- (void)setDetailNew:(DetailNew *)detailNew
{
    _detailNew = detailNew;
    
    [self setNeedsLayout];
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

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([DetailNewsTopCell class])
                          bundle:[NSBundle bundleForClass:[DetailNewsTopCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([DetailNewsTopCell class]);
}

+ (CGFloat)cellHeight
{
    return 84;
}



@end
