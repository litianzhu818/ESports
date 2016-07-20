//
//  ProcessMatchCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "ProcessMatchCell.h"

@implementation ProcessMatchCell

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
    return [UINib nibWithNibName:NSStringFromClass([ProcessMatchCell class])
                          bundle:[NSBundle bundleForClass:[ProcessMatchCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([ProcessMatchCell class]);
}

+ (CGFloat)cellHeight
{
    return 73;
}


@end
