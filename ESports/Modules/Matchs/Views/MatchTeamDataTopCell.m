//
//  MatchTeamDataTopCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/28.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchTeamDataTopCell.h"
#import "MatchTeamResultCell.h"

@interface MatchTeamDataTopCell ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MatchTeamDataTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.backgroundColor = HexColor(0x17212e);
    [self.collectionView registerNib:[MatchTeamResultCell nib] forCellWithReuseIdentifier:[MatchTeamResultCell cellIdentifier]];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"first_blood_title":@"first boold",
                                           @"first_tower_title":@"first tower",
                                           @"first_dragon_title":@"first dragon",
                                           @"first_big_dragon_title":@"first big dragon",
                                           @"first_vanguard_title":@"first vanguard",
                                           @"first_old_dragon_title":@"first old dragon"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"first_blood_title":@"一血",
                                           @"first_tower_title":@"一塔",
                                           @"first_dragon_title":@"一龙",
                                           @"first_big_dragon_title":@"首大龙",
                                           @"first_vanguard_title":@"首先锋",
                                           @"first_old_dragon_title":@"首远古龙"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"first_blood_title":@"一血",
                                           @"first_tower_title":@"一塔",
                                           @"first_dragon_title":@"一龍",
                                           @"first_big_dragon_title":@"首大龍",
                                           @"first_vanguard_title":@"首先鋒",
                                           @"first_old_dragon_title":@"首遠古龍"
                                           }
                                   };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBlueTeamImageUrl:(NSString *)blueTeamImageUrl
{
    _blueTeamImageUrl = blueTeamImageUrl;
    
    [self.collectionView reloadData];
}

- (void)setRedTeamImageUrl:(NSString *)redTeamImageUrl
{
    _redTeamImageUrl = redTeamImageUrl;
    
    [self.collectionView reloadData];
}

- (void)setGameResult:(MatchTeamGameResult *)gameResult
{
    _gameResult = gameResult;
    
    [self.collectionView reloadData];
}

- (void)languageDidChanged
{
    [self.collectionView reloadData];
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchTeamDataTopCell class])
                          bundle:[NSBundle bundleForClass:[MatchTeamDataTopCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchTeamDataTopCell class]);
}

+ (CGFloat)cellHeight
{
    return 4+2*[MatchTeamResultCell cellSize].height;
}

#pragma mark - UICollectionViewDataSource methods
//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  6;
}

//定义并返回每个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MatchTeamResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MatchTeamResultCell cellIdentifier] forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.isBlueTeam = self.gameResult.firstBlood;
        cell.imageUrl = self.gameResult.firstBlood ? self.blueTeamImageUrl:self.redTeamImageUrl;
        cell.title = LTZLocalizedString(@"first_blood_title", nil);
    }else if (indexPath.row == 1) {
        cell.isBlueTeam = self.gameResult.firstTower;
        cell.imageUrl = self.gameResult.firstTower ? self.blueTeamImageUrl:self.redTeamImageUrl;
        cell.title = LTZLocalizedString(@"first_tower_title", nil);
    }else if (indexPath.row == 2) {
        cell.isBlueTeam = self.gameResult.firstDragon;
        cell.imageUrl = self.gameResult.firstDragon ? self.blueTeamImageUrl:self.redTeamImageUrl;
        cell.title = LTZLocalizedString(@"first_dragon_title", nil);
    }else if (indexPath.row == 3) {
        cell.isBlueTeam = self.gameResult.firstBigDragon;
        cell.imageUrl = self.gameResult.firstBigDragon ? self.blueTeamImageUrl:self.redTeamImageUrl;
        cell.title = LTZLocalizedString(@"first_big_dragon_title", nil);
    }else if (indexPath.row == 4) {
        cell.isBlueTeam = self.gameResult.firstVanguard;
        cell.imageUrl = self.gameResult.firstVanguard ? self.blueTeamImageUrl:self.redTeamImageUrl;
        cell.title = LTZLocalizedString(@"first_vanguard_title", nil);
    }else if (indexPath.row == 5) {
        cell.isBlueTeam = self.gameResult.firstAncientDragon;
        cell.imageUrl = self.gameResult.firstAncientDragon ? self.blueTeamImageUrl:self.redTeamImageUrl;
        cell.title = LTZLocalizedString(@"first_old_dragon_title", nil);
    }
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
    return [MatchTeamResultCell cellSize];
}

//设置每组的cell的边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0);
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8.0;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (CGRectGetWidth([[UIScreen mainScreen] bounds])-16.0f-3*[MatchTeamResultCell cellSize].width)/2;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}



@end
