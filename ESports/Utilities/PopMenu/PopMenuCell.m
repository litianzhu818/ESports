//
//  PopMenuCell.m
//  Kissnapp
//
//  Created by Peter Lee on 15/4/3.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import "PopMenuCell.h"
#import "PopMenuModel.h"
#import "PopMenuStyle.h"

static const NSString *popMenuCellIdentifier = @"popMenuCellIdentifier";
static const CGFloat popMenuCellHeight = 36.0;
static const CGFloat marginWidth = 6.0;

@interface PopMenuCell ()

@property (strong ,nonatomic) UIImageView *mainImageView;
@property (strong ,nonatomic) UILabel *mainTitleLabel;
@property (strong ,nonatomic) UIImageView *lineImageView;

@end

@implementation PopMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.mainImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mainImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    // setting ImageView to cryle
    self.mainImageView.layer.masksToBounds = YES;
    self.mainImageView.layer.cornerRadius = 2.0;
    
    [self.contentView addSubview:_mainImageView];
    
    self.mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.mainTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:_mainTitleLabel];
    
    
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.lineImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.lineImageView setContentMode:UIViewContentModeScaleToFill];
    [self.contentView addSubview:_lineImageView];
    
    NSMutableArray *Constraints = [NSMutableArray array];
    [Constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-MARGIN-[_mainImageView(==MARGIN1)]-MARGIN-[_mainTitleLabel]-MARGIN-|"
                                                                             options:0
                                                                             metrics:@{@"MARGIN":[NSNumber numberWithFloat:2*marginWidth],
                                                                                       @"MARGIN1":[NSNumber numberWithFloat:(popMenuCellHeight - 2*10)]
                                                                                       }
                                                                               views:NSDictionaryOfVariableBindings(_mainImageView, _mainTitleLabel)]];
    
    [Constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0.0-[_lineImageView]-0.0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_lineImageView)]];
    
    [Constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-MARGIN-[_mainImageView]-MARGIN-|"
                                                                             options:0
                                                                             metrics:@{
                                                                                       @"MARGIN":[NSNumber numberWithFloat:10]
                                                                                       }
                                                                               views:NSDictionaryOfVariableBindings(_mainImageView)]];
    
    [Constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-MARGIN-[_mainTitleLabel]-MARGIN-|"
                                                                             options:0
                                                                             metrics:@{
                                                                                       @"MARGIN":[NSNumber numberWithFloat:marginWidth]
                                                                                       }
                                                                               views:NSDictionaryOfVariableBindings(_mainTitleLabel)]];
    
    [Constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineImageView(==MARGIN)]-0.0-|"
                                                                             options:0
                                                                             metrics:@{
                                                                                       @"MARGIN":[NSNumber numberWithFloat:1]
                                                                                       }
                                                                               views:NSDictionaryOfVariableBindings(_lineImageView)]];
    
    [self.contentView addConstraints:Constraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.mainImageView setImage:self.model.image];
    self.mainTitleLabel.text = self.model.title;
}

- (void)setShowBottomLine:(BOOL)showLine
{
    _showBottomLine = showLine;
    
    self.lineImageView.hidden = !_showBottomLine;
}

- (void)setModel:(PopMenuModel *)model
{
    if ([_model isEqual:model])  return;
    
    _model = model;
    
    self.showBottomLine = YES;
    
    [self setNeedsLayout];
}

- (void)setMenuSytle:(PopMenuStyle *)menuSytle
{
    _menuSytle = menuSytle;
    
    self.backgroundColor = _menuSytle.cellBackgroundColor;
    self.contentView.backgroundColor = _menuSytle.cellBackgroundColor;
    
    self.mainTitleLabel.font = _menuSytle.titleTextFont;
    self.mainTitleLabel.textColor = _menuSytle.titleTextColor;
    
    [self.lineImageView setImage:_menuSytle.cellBottomLineImage];
    
    self.selectedBackgroundView = nil;
    
    UIView *cellSelectedBackgroundView = [[UIView alloc] init];
    cellSelectedBackgroundView.backgroundColor = _menuSytle.cellSelectedBackgroundColor;
    self.selectedBackgroundView = cellSelectedBackgroundView;
    
}

- (void)setBottomLineImage:(UIImage *)bottomLineImage
{
    _bottomLineImage = bottomLineImage;
    
    [self.lineImageView setImage:_bottomLineImage];
}

+ (CGFloat)cellHeight
{
    return popMenuCellHeight;
}

+ (NSString *)cellIdentifier
{
    return [NSString stringWithFormat:@"%@",popMenuCellIdentifier];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
