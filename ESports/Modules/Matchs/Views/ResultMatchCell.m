//
//  ResultMatchCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "ResultMatchCell.h"

@implementation ResultMatchCell

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
    return [UINib nibWithNibName:NSStringFromClass([ResultMatchCell class])
                          bundle:[NSBundle bundleForClass:[ResultMatchCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([ResultMatchCell class]);
}

+ (CGFloat)cellHeight
{
    return 73;
}


@end
