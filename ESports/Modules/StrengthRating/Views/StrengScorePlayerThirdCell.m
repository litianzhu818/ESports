//
//  StrengScorePlayerThirdCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/17.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScorePlayerThirdCell.h"
#import "PickerCollectionViewCell.h"

@interface StrengScorePlayerThirdCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;

@end

@implementation StrengScorePlayerThirdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e161f);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"win_rate_title":@"common hero winrate"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"win_rate_title":@"常用英雄胜率"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"win_rate_title":@"常用英雄勝率"
                                           }
                                   };
    
    self.titleLabel.textColor = HexColor(0x5ed2f7);
    self.titleLabel.text = LTZLocalizedString(@"win_rate_title", nil);
    
    self.collectionView.backgroundColor = HexColor(0x0e1720);
    [self.collectionView registerNib:[PickerCollectionViewCell nib] forCellWithReuseIdentifier:[PickerCollectionViewCell cellIdentifier]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    
    CGContextSetStrokeColorWithColor(context, HexColor(0x1f262e).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 30);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, 30);   //终点坐标
    
    CGContextMoveToPoint(context, 0, rect.size.height);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);   //终点坐标
    
    CGContextStrokePath(context);
}

- (void)setPlayerDetail:(StrengScorePlayerDetail *)playerDetail
{
    _playerDetail = playerDetail;
    
    [self.collectionView reloadData];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat numberOfLine = 5.0;
    NSInteger pickCount = self.playerDetail.pickChampions.count;
    NSInteger line = ceil(pickCount/numberOfLine);
    
    if (line == 1) {
        self.collectionViewWidthConstraint.constant = pickCount * [PickerCollectionViewCell cellSize].width;
    }else{
        self.collectionViewWidthConstraint.constant = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    }
    
    self.collectionViewHeightConstraint.constant = line * [PickerCollectionViewCell cellSize].height;
    
    [self.collectionView setNeedsUpdateConstraints];
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScorePlayerThirdCell class])
                          bundle:[NSBundle bundleForClass:[StrengScorePlayerThirdCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScorePlayerThirdCell class]);
}

+ (CGFloat)cellHeightWithPlayerDetail:(StrengScorePlayerDetail *)playerDetail
{
    
    CGFloat numberOfLine = 5.0;
    NSInteger pickCount = playerDetail.pickChampions.count;
    NSInteger line = ceil(pickCount/numberOfLine);
    
    return [PickerCollectionViewCell cellSize].height*line+31.0f+2;
}

#pragma mark - language change action
- (void)languageDidChanged
{
    self.titleLabel.text = LTZLocalizedString(@"win_rate_title", nil);
}


#pragma mark - UICollectionViewDataSource methods
//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.playerDetail.pickChampions.count;
}

//定义并返回每个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PickerCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    cell.pick = self.playerDetail.pickChampions[indexPath.item];
    return cell;
}

//collectionView里有多少个组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义并返回每个headerView或footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate methods
//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [PickerCollectionViewCell cellSize];
}

//设置每组的cell的边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
