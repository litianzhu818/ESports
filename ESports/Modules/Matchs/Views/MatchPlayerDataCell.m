//
//  MatchPlayerDataCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchPlayerDataCell.h"

@interface MatchPlayerDataCell ()

@end

@implementation MatchPlayerDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchPlayerDataCell class])
                          bundle:[NSBundle bundleForClass:[MatchPlayerDataCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchPlayerDataCell class]);
}

+ (CGFloat)cellHeight
{
    return 105;
}


@end
