//
//  MatchVideoDataCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/3.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchVideoDataCell.h"

@interface MatchVideoDataCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasVideoTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@end

@implementation MatchVideoDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x17212e);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.titleLabel.textColor = HexColor(0xbabdc1);
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"main_title":@"The %@ game",
                                           @"sub_has_video_title":@"Have video",
                                           @"sub_has_no_video_title":@"It's coming"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"main_title":@"第 %@ 局",
                                           @"sub_has_video_title":@"已有重播",
                                           @"sub_has_no_video_title":@"正在准备"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"main_title":@"第 %@ 局",
                                           @"sub_has_video_title":@"已有重播",
                                           @"sub_has_no_video_title":@"正在準備"
                                           }
                                   };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMatchVideoData:(MatchVideoData *)matchVideoData
{
    _matchVideoData = matchVideoData;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.text= [NSString stringWithFormat:LTZLocalizedString(@"main_title", nil), self.matchVideoData.gameOrder];
    
    if (self.matchVideoData.videoUrlApp.length > 0) {
        self.hasVideoTitleLabel.textColor = HexColor(0xd1d3d5);
        self.hasVideoTitleLabel.text = [NSString stringWithFormat:@"(%@)",LTZLocalizedString(@"sub_has_video_title", nil)];
        self.videoImageView.image = [UIImage imageNamed:@"match_video_data_n"];
    }else{
        self.hasVideoTitleLabel.textColor = HexColor(0x747a82);
        self.hasVideoTitleLabel.text = [NSString stringWithFormat:@"(%@)",LTZLocalizedString(@"sub_has_no_video_title", nil)];
        self.videoImageView.image = [UIImage imageNamed:@"match_video_data_h"];
    }
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 4);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, HexColor(0x121b27).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height-1.0);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-1.0);   //终点坐标
    CGContextStrokePath(context);
}

- (void)languageDidChanged
{
    self.titleLabel.text= [NSString stringWithFormat:LTZLocalizedString(@"main_title", nil), self.matchVideoData.gameOrder];
    
    if (self.matchVideoData.videoUrlApp.length > 0) {
        self.hasVideoTitleLabel.text = [NSString stringWithFormat:@"(%@)",LTZLocalizedString(@"sub_has_video_title", nil)];
    }else{
        self.hasVideoTitleLabel.text = [NSString stringWithFormat:@"(%@)",LTZLocalizedString(@"sub_has_no_video_title", nil)];
    }
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchVideoDataCell class])
                          bundle:[NSBundle bundleForClass:[MatchVideoDataCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchVideoDataCell class]);
}

+ (CGFloat)cellHeight
{
    return 46.0f;
}



@end
