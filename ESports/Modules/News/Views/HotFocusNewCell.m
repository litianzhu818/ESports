//
//  HotFocusNewCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/14.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "HotFocusNewCell.h"
#import "UIImageView+WebCache.h"
#import "NSObject+Custom.h"

@interface HotFocusNewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaLabelWidthConstraint;

@end

@implementation HotFocusNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = HexColor(0x16212f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.dateLabel.textColor = HexColor(0xffffff);
    self.areaLabel.textColor = HexColor(0xcccfd3);
    self.areaLabel.layer.cornerRadius = 2.0f;
    self.areaLabel.clipsToBounds = YES;
    self.areaLabel.backgroundColor = HexColor(0x042946);
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    self.titleLabel.numberOfLines = 0;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHotFocusNew:(HotFocusNew *)hotFocusNew
{
    _hotFocusNew = hotFocusNew;
    
    self.titleLabel.text = _hotFocusNew.newsTitle;
    self.areaLabel.text = _hotFocusNew.newsArea;
    self.dateLabel.text = [_hotFocusNew newsDateString];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_hotFocusNew.newsImageUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    CGFloat height = [self sizeOfLabelWithString:_hotFocusNew.newsTitle
                                            font:self.titleLabel.font
                                           width:CGRectGetWidth([[UIScreen mainScreen] bounds])-118.0f].height;
    if (height >= 37.0) {
        height = 37.0;
    }
    self.titleLabelHeightConstraint.constant = height;
    [self.titleLabel setNeedsUpdateConstraints];
    
    CGFloat width = [self sizeOfLabelWithString:_hotFocusNew.newsArea
                                           font:self.areaLabel.font
                                          height:14.0f].width+10.0f;
    self.areaLabelWidthConstraint.constant = width;
    [self.areaLabel setNeedsUpdateConstraints];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 2);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, HexColor(0x1c2d42).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height-2.0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-2.0);   //终点坐标
    CGContextStrokePath(context);
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([HotFocusNewCell class])
                          bundle:[NSBundle bundleForClass:[HotFocusNewCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([HotFocusNewCell class]);
}

+ (CGFloat)cellHeight
{
    return 73;
}

@end
