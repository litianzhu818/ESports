//
//  TransferNewCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/15.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "TransferNewCell.h"

@implementation TransferNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([TransferNewCell class])
                          bundle:[NSBundle bundleForClass:[TransferNewCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([TransferNewCell class]);
}

+ (CGFloat)cellHeight
{
    return 73;
}


@end
