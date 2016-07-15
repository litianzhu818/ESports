//
//  DropdownMenuItemCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/7.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DropdownMenuItemCell.h"

@interface DropdownMenuItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation DropdownMenuItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:17.0];
    self.titleLabel.textColor = HexColor(0xffffff);
    self.iconImageView.image = [UIImage imageNamed:@"location_selected"];
    self.iconImageView.hidden = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(DropdownMenuItem *)item
{
    _item = item;
    
    self.titleLabel.text = _item.title;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    if (_isSelected) {
        self.titleLabel.textColor = HexColor(0x6ed4ff);
        self.iconImageView.hidden = NO;
    }else{
        self.titleLabel.textColor = HexColor(0xffffff);
        self.iconImageView.hidden = YES;
    }
}

- (void)drawRect:(CGRect)rect
{
    if (!self.hasBottomLine) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.contentView.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0.0, rect.size.height - 3.0f, rect.size.width, 2.0));
    
    CGContextSetStrokeColorWithColor(context, HexColor(0x1b2d3d).CGColor);
    CGContextStrokeRect(context, CGRectMake(0.0, rect.size.height - 1.0f, rect.size.width, 1.0));
}


#pragma mark - class methods
+ (CGFloat)cellHeight
{
    return 44.0;
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([DropdownMenuItemCell class])
                          bundle:[NSBundle bundleForClass:[DropdownMenuItemCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([DropdownMenuItemCell class]);
}

@end
