//
//  ExtendTableViewHeaderView.m
//  Kissnapp
//
//  Created by Peter Lee on 15/7/15.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import "ExtendTableViewHeaderView.h"

static const NSString *extendTableViewHeaderViewIdentifier = @"extendTableViewHeaderViewIdentifier";
static const CGFloat extendTableViewHeaderViewHeight = 44.0f;
static const CGFloat marginWidth = 8.0;

@interface ExtendTableViewHeaderView ()

@property (nonatomic, strong) UIButton *backgroundButton;
@property (nonatomic, strong) UIImageView *accessoryImageView;
@property (nonatomic, strong) UILabel *mainTextLabel;
@property (nonatomic, strong) UILabel *subTextLabel;
@property (nonatomic, strong) UIView *divider;

@end

@implementation ExtendTableViewHeaderView
@synthesize backgroundButton;
@synthesize accessoryImageView;
@synthesize mainTextLabel;
@synthesize subTextLabel;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}



- (void)setup
{
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"team_title":@"Game %@",
                                           @"win_titie":@"Win"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"team_title":@"第%@局",
                                           @"win_titie":@"胜"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"team_title":@"第%@局",
                                           @"win_titie":@"勝"
                                           }
                                   };
    
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.contentView.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, extendTableViewHeaderViewHeight);
    
    // init backgroundImageView
    backgroundButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectZero;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addSubview:button];
        
        button;
    });
    
    NSMutableArray *BGIVConstraints = [NSMutableArray array];
    
    [BGIVConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0.0-[backgroundButton]-0.0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(backgroundButton)]];
                                                                                                                    
    [BGIVConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0.0-[backgroundButton]-0.0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(backgroundButton)]];
    
    [self.contentView addConstraints:BGIVConstraints];
    
    [backgroundButton setBackgroundColor:HexColor(0x17212e)];
    
    /*
    UIImage *norImage = [UIImage imageNamed:@"buddy_header_nor"];
    UIImage *heightedImage = [UIImage imageNamed:@"buddy_header_press"];
    
    [backgroundButton setBackgroundImage:[norImage stretchableImageWithLeftCapWidth:floorf(norImage.size.width/2) topCapHeight:floorf(norImage.size.height/2)] forState:UIControlStateNormal];
    [backgroundButton setBackgroundImage:[heightedImage stretchableImageWithLeftCapWidth:floorf(heightedImage.size.width/2) topCapHeight:floorf(heightedImage.size.height/2)] forState:UIControlStateHighlighted];
     */
    
    [backgroundButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // init accessoryView
    
    accessoryImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:imageView];
        imageView;
    });
    
    accessoryImageView.image = [UIImage imageNamed:@"match_team_data_arrow"];
    
    // init mainTextLabel
    mainTextLabel = ({
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = HexColor(0xafb2b7);
        [self.contentView addSubview:label];
        label;
        
    });
    
    // init subTextLabel
    subTextLabel = ({
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [UIFont systemFontOfSize:12.0];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = HexColor(0xafb2b7);
        [self.contentView addSubview:label];
        label;
        
    });
    
    
    NSMutableArray *Constraints = [NSMutableArray array];
    
    [Constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-MARGIN-[mainTextLabel(==80.0)]-MARGIN-[subTextLabel]-MARGIN-[accessoryImageView(==MARGIN1)]-MARGIN-|"
                                                                                 options:0
                                                                             metrics:@{
                                                                                       @"MARGIN":@(marginWidth),
                                                                                       @"MARGIN1":@(20)
                                                                                       }
                                                                                   views:NSDictionaryOfVariableBindings(accessoryImageView,mainTextLabel,subTextLabel)]];
    
    [Constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-MARGIN-[accessoryImageView]-MARGIN-|"
                                                                                 options:0
                                                                             metrics:@{
                                                                                       @"MARGIN":@(marginWidth)
                                                                                       }
                                                                                   views:NSDictionaryOfVariableBindings(accessoryImageView)]];
    
    [Constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-MARGIN-[mainTextLabel]-MARGIN-|"
                                                                             options:0
                                                                             metrics:@{
                                                                                       @"MARGIN":@(marginWidth)
                                                                                       }
                                                                               views:NSDictionaryOfVariableBindings(mainTextLabel)]];
    [Constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-MARGIN-[subTextLabel]-MARGIN-|"
                                                                             options:0
                                                                             metrics:@{
                                                                                       @"MARGIN":@(marginWidth)
                                                                                       }
                                                                               views:NSDictionaryOfVariableBindings(subTextLabel)]];
    
    [self.contentView addConstraints:Constraints];
    
//    UIView *divider = [[UIView alloc] init];
//    divider.alpha = 0.3;
//    divider.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:self.divider = divider];
}

- (void)setSectionIndex:(NSInteger)sectionIndex tapBlock:(void (^)(NSInteger sectionIndex, BOOL isExtend)) tapBlock
{
    self.sectionIndex = sectionIndex;
    self.tapBlock = tapBlock;
}

- (void)tapAction:(id)sender
{
    self.isExtend = !self.isExtend;
    
    if (self.tapBlock) {
        self.tapBlock(self.sectionIndex, self.isExtend);
    }
    
    [self setNeedsLayout];
}

- (void)setIsExtend:(BOOL)isExtend
{
    _isExtend = isExtend;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        if (_isExtend) {
            accessoryImageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }else{
            accessoryImageView.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    NSString *titleString = [NSString stringWithFormat:LTZLocalizedString(@"team_title", nil),_title];;
    [mainTextLabel setText:titleString];
}

- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    
    
    NSString *titleString = [NSString stringWithFormat:@"%@ %@",_subTitle, LTZLocalizedString(@"win_titie", nil)];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [attributedString addAttributes:@{
                                      NSForegroundColorAttributeName:HexColor(0x6ed4ff)
                                      }
                              range:[titleString rangeOfString:LTZLocalizedString(@"win_titie", nil)]];
    
    self.subTextLabel.attributedText = attributedString;
}

- (void)languageDidChanged
{
    NSString *titleString = [NSString stringWithFormat:LTZLocalizedString(@"team_title", nil),_title];;
    [mainTextLabel setText:titleString];
    
    NSString *subTitleString = [NSString stringWithFormat:@"%@ %@",self.subTitle, LTZLocalizedString(@"win_titie", nil)];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:subTitleString];
    
    [attributedString addAttributes:@{
                                      NSForegroundColorAttributeName:HexColor(0x6ed4ff)
                                      }
                              range:[subTitleString rangeOfString:LTZLocalizedString(@"win_titie", nil)]];
    
    self.subTextLabel.attributedText = attributedString;
}

+ (CGFloat)sectionHeaderViewHeight
{
    return extendTableViewHeaderViewHeight;
}

+ (NSString *)sectionHeaderViewIdentifier
{
    return [NSString stringWithFormat:@"%@",extendTableViewHeaderViewIdentifier];
}


@end

