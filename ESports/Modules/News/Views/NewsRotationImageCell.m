//
//  NewsRotationImageCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/14.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "NewsRotationImageCell.h"
#import "SDCycleScrollView.h"

static const CGFloat cellHeight = 640.0f;
static const CGFloat cellWidth = 1240.0f;

@interface NewsRotationImageCell ()

@property (weak, nonatomic) IBOutlet SDCycleScrollView *scrollView;

@end

@implementation NewsRotationImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupScrollView];
}

- (void)setupScrollView
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.scrollView.showPageControl = NO;
    self.scrollView.placeholderImage = [UIImage imageNamed:@"占位图片"];
    [self.scrollView setClickItemOperationBlock:^(NSInteger index) {
        if (self.clikedBlock) {
            self.clikedBlock(index);
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImages:(NSArray<NewsRotationImage *> *)images
{
    _images = images;
    
    self.scrollView.imageURLStringsGroup = [_images valueForKeyPath:@"imageUrl"];
    self.scrollView.titlesGroup = [_images valueForKeyPath:@"imageTitle"];
    
    [self setupScrollView];
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([NewsRotationImageCell class])
                          bundle:[NSBundle bundleForClass:[NewsRotationImageCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([NewsRotationImageCell class]);
}

+ (CGFloat)cellHeightWithWidth:(CGFloat)width
{
    return (cellHeight * width) / cellWidth;
}

@end
