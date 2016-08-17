//
//  StrengScoreTeamThirdCell.m
//  ESports
//
//  Created by Peter Lee on 16/8/11.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "StrengScoreTeamThirdCell.h"
#import "PlayerCollectionViewCell.h"

@interface StrengScoreTeamThirdCell ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation StrengScoreTeamThirdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x0e1720);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.backgroundColor = HexColor(0x0e1720);
    [self.collectionView registerNib:[PlayerCollectionViewCell nib] forCellWithReuseIdentifier:[PlayerCollectionViewCell cellIdentifier]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPlayers:(NSArray<StrengScoreTeamPlayer *> *)players
{
    _players = players;
    
    [self.collectionView reloadData];
}


#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([StrengScoreTeamThirdCell class])
                          bundle:[NSBundle bundleForClass:[StrengScoreTeamThirdCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([StrengScoreTeamThirdCell class]);
}

+ (CGFloat)cellHeight
{
    return [PlayerCollectionViewCell cellSize].height;
}


#pragma mark - UICollectionViewDataSource methods
//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.players.count;
}

//定义并返回每个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PlayerCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    cell.player = self.players[indexPath.item];
    
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
    return [PlayerCollectionViewCell cellSize];
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
    if (self.selectedBlock) {
        StrengScoreTeamPlayer *player = self.players[indexPath.item];
        self.selectedBlock(player.playerId, player.playerRoleId);
    }
}



@end
