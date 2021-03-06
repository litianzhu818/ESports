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
    
    self.collectionView.backgroundColor = HexColor(0x121b27);
    [self.collectionView registerNib:[MatchTeamResultCell nib] forCellWithReuseIdentifier:[MatchTeamResultCell cellIdentifier]];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"first_blood_title":@"First Blood",
                                           @"first_tower_title":@"First Turret",
                                           @"first_dragon_title":@"First Dragon",
                                           @"first_big_dragon_title":@"First Baron",
                                           @"first_vanguard_title":@"First Herald",
                                           @"first_old_dragon_title":@"First Elder Dragon"
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

- (void)setTeamBImageUrl:(NSString *)teamBImageUrl
{
    _teamBImageUrl = teamBImageUrl;
    
    [self.collectionView reloadData];
}

- (void)setTeamAImageUrl:(NSString *)teamAImageUrl
{
    _teamAImageUrl = teamAImageUrl;
    
    [self.collectionView reloadData];
}

- (void)setGameResult:(MatchTeamGameResult *)gameResult
{
    _gameResult = gameResult;
    
    [self.collectionView reloadData];
}

- (void)setIsARedSide:(BOOL)isARedSide
{
    _isARedSide = isARedSide;
    
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
    return 4+2*[MatchTeamResultCell cellSize].height+8.0;
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
        cell.isBlueTeam = self.gameResult.firstBlood ? (self.isARedSide ? NO:YES):(self.isARedSide ? YES:NO);
        cell.imageUrl = self.gameResult.firstBlood ? self.teamAImageUrl:self.teamBImageUrl;
        cell.title = LTZLocalizedString(@"first_blood_title", nil);
    }else if (indexPath.row == 1) {
        cell.isBlueTeam = self.gameResult.firstTower ? (self.isARedSide ? NO:YES) : (self.isARedSide ? YES:NO);
        cell.imageUrl = self.gameResult.firstTower ? self.teamAImageUrl:self.teamBImageUrl;
        cell.title = LTZLocalizedString(@"first_tower_title", nil);
    }else if (indexPath.row == 2) {
        cell.isBlueTeam = self.gameResult.firstDragon ? (self.isARedSide ? NO:YES) : (self.isARedSide ? YES:NO);
        cell.imageUrl = self.gameResult.firstDragon ? self.teamAImageUrl:self.teamBImageUrl;
        cell.title = LTZLocalizedString(@"first_dragon_title", nil);
    }else if (indexPath.row == 3) {
        cell.isBlueTeam = self.gameResult.firstBigDragon ? (self.isARedSide ? NO:YES) : (self.isARedSide ? YES:NO);
        cell.imageUrl = self.gameResult.firstBigDragon ? self.teamAImageUrl:self.teamBImageUrl;
        cell.title = LTZLocalizedString(@"first_big_dragon_title", nil);
    }else if (indexPath.row == 4) {
        if (!self.gameResult.firstVanguard) {
            cell.hasTeam = NO;
        }else if ([self.gameResult.firstVanguard isEqualToString:@"1"]) {
            cell.isBlueTeam = self.isARedSide ? NO:YES;
            cell.imageUrl = self.teamAImageUrl;
        }else if ([self.gameResult.firstVanguard isEqualToString:@"0"]) {
            cell.isBlueTeam = self.isARedSide ? YES:NO;
            cell.imageUrl = self.teamBImageUrl;
        }
        cell.title = LTZLocalizedString(@"first_vanguard_title", nil);
        
    }else if (indexPath.row == 5) {
        
        if (!self.gameResult.firstAncientDragon) {
            cell.hasTeam = NO;
        }else if ([self.gameResult.firstAncientDragon isEqualToString:@"1"]) {
            cell.isBlueTeam =self.isARedSide ? NO:YES;
            cell.imageUrl = self.teamAImageUrl;
        }else if ([self.gameResult.firstAncientDragon isEqualToString:@"0"]) {
            cell.isBlueTeam = self.isARedSide ? YES:NO;
            cell.imageUrl = self.teamBImageUrl;
        }
        
        cell.title = LTZLocalizedString(@"first_old_dragon_title", nil);
        /*
        cell.isBlueTeam = self.gameResult.firstAncientDragon;
        cell.imageUrl = self.gameResult.firstAncientDragon ? self.blueTeamImageUrl:self.redTeamImageUrl;
        cell.title = LTZLocalizedString(@"first_old_dragon_title", nil);
         */
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
