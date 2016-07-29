//
//  MatchTeamDataBottomCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/29.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MatchTeamDataBottomCell.h"
#import "MatchPickCell.h"

@interface MatchTeamDataBottomCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *redTeamNameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *blueCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *redCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redCollectionViewHeightConstraint;

@end

@implementation MatchTeamDataBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.blueTeamNameLabel.textColor = HexColor(0xa7a8ab);
    self.redTeamNameLabel.textColor = HexColor(0xa7a8ab);
    
    self.blueCollectionView.backgroundColor = [UIColor clearColor];
    [self.blueCollectionView registerNib:[MatchPickCell nib] forCellWithReuseIdentifier:[MatchPickCell cellIdentifier]];
    
    self.redCollectionView.backgroundColor = [UIColor clearColor];
    [self.redCollectionView registerNib:[MatchPickCell nib] forCellWithReuseIdentifier:[MatchPickCell cellIdentifier]];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"picks_title":@"Picks",
                                           @"bans_title":@"Bans",
                                           @"blue_team_title":@"Blue team:",
                                           @"red_team_title":@"Red team:"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"picks_title":@"Picks",
                                           @"bans_title":@"Bans",
                                           @"blue_team_title":@"蓝队：",
                                           @"red_team_title":@"红队："
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"picks_title":@"Picks",
                                           @"bans_title":@"Bans",
                                           @"blue_team_title":@"藍隊：",
                                           @"red_team_title":@"紅隊："
                                           }
                                   };
    
    if (self.isPicks) {
        self.titleLabel.text = LTZLocalizedString(@"picks_title", nil);
    }else{
        self.titleLabel.text = LTZLocalizedString(@"bans_title", nil);
    }
    
    self.blueTeamNameLabel.text = LTZLocalizedString(@"blue_team_title", nil);
    self.redTeamNameLabel.text = LTZLocalizedString(@"red_team_title", nil);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger blueCellNumber = 0;
    NSInteger redCellNumber = 0;

    if (self.isPicks) {
        blueCellNumber = self.matchTeamData.blueTeamGameData.pickedChampions.count;
        redCellNumber = self.matchTeamData.redTeamGameData.pickedChampions.count;
    }else{
        blueCellNumber = self.matchTeamData.blueTeamGameData.bannedChampions.count;
        redCellNumber = self.matchTeamData.redTeamGameData.bannedChampions.count;
    }
    
    
    CGFloat collectionViewSectionWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 70.0 - 3*8.0;
    CGFloat cellWidth = [MatchPickCell cellSize].width;
    CGFloat cellHeight = [MatchPickCell cellSize].height;
    
    NSInteger maxColumns = floor((collectionViewSectionWidth + 8.0)/(cellWidth + 8.0));
    NSInteger bluePicksLines = ceil((blueCellNumber*1.0)/maxColumns*1.0);
    NSInteger redPicksLines = ceil((redCellNumber*1.0)/maxColumns*1.0);
    
    self.blueCollectionViewHeightConstraint.constant = bluePicksLines*cellHeight+(bluePicksLines-1)*8.0;
    [self.blueCollectionView setNeedsUpdateConstraints];
    
    self.redCollectionViewHeightConstraint.constant = redPicksLines*cellHeight+(redPicksLines-1)*8.0;
    [self.redCollectionView setNeedsUpdateConstraints];
}

- (void)setIsPicks:(BOOL)isPicks
{
    _isPicks = isPicks;
    
    if (_isPicks) {
        self.titleLabel.text = LTZLocalizedString(@"picks_title", nil);
    }else{
        self.titleLabel.text = LTZLocalizedString(@"bans_title", nil);
    }
    
    [self.blueCollectionView reloadData];
    [self.redCollectionView reloadData];
}

- (void)setMatchTeamData:(MatchTeamData *)matchTeamData
{
    _matchTeamData = matchTeamData;
    
    [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, HexColor(0x4c5157).CGColor);  //线的颜色
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 8.0, 30);  //起点坐标
    CGContextAddLineToPoint(context, rect.size.width-8.0, 30);   //终点坐标
    CGContextStrokePath(context);
}

- (void)languageDidChanged
{
    if (self.isPicks) {
        self.titleLabel.text = LTZLocalizedString(@"picks_title", nil);
    }else{
        self.titleLabel.text = LTZLocalizedString(@"bans_title", nil);
    }
    
    self.blueTeamNameLabel.text = LTZLocalizedString(@"blue_team_title", nil);
    self.redTeamNameLabel.text = LTZLocalizedString(@"red_team_title", nil);
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([MatchTeamDataBottomCell class])
                          bundle:[NSBundle bundleForClass:[MatchTeamDataBottomCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([MatchTeamDataBottomCell class]);
}

+ (CGFloat)cellHeightWithMatchTeamData:(MatchTeamData *)matchTeamData isPicks:(BOOL)isPicks
{
    CGFloat height = 0.0f;
    
    NSInteger blueCellNumber = 0;
    NSInteger redCellNumber = 0;
    
    if (isPicks) {
        blueCellNumber = matchTeamData.blueTeamGameData.pickedChampions.count;
        redCellNumber = matchTeamData.redTeamGameData.pickedChampions.count;
    }else{
        blueCellNumber = matchTeamData.blueTeamGameData.bannedChampions.count;
        redCellNumber = matchTeamData.redTeamGameData.bannedChampions.count;
    }
    
    
    CGFloat collectionViewSectionWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 70.0 - 3*8.0;
    CGFloat cellWidth = [MatchPickCell cellSize].width;
    CGFloat cellHeight = [MatchPickCell cellSize].height;
    
    NSInteger maxColumns = floor((collectionViewSectionWidth + 8.0)/(cellWidth + 8.0));
    NSInteger bluePicksLines = ceil((blueCellNumber*1.0)/maxColumns*1.0);
    NSInteger redPicksLines = ceil((redCellNumber*1.0)/maxColumns*1.0);
    
    CGFloat blueCollectionViewHeight = bluePicksLines*cellHeight+(bluePicksLines-1)*8.0;
    CGFloat redCollectionViewHeight = redPicksLines*cellHeight+(redPicksLines-1)*8.0;
    
    height = blueCollectionViewHeight + redCollectionViewHeight + 53.0f;
    
    return height;
}


#pragma mark - UICollectionViewDataSource methods
//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if ([collectionView isEqual:self.blueCollectionView]) {
        
        if (self.isPicks) {
            count = self.matchTeamData.blueTeamGameData.pickedChampions.count;
        }else{
            count = self.matchTeamData.blueTeamGameData.bannedChampions.count;
        }
        
    }else{
        if (self.isPicks) {
            count = self.matchTeamData.redTeamGameData.pickedChampions.count;
        }else{
            count = self.matchTeamData.redTeamGameData.bannedChampions.count;
        }
    }
    return  count;
}

//定义并返回每个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MatchPickCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MatchPickCell cellIdentifier] forIndexPath:indexPath];
    
    if ([collectionView isEqual:self.blueCollectionView]) {
        
        cell.isBlueTeam = YES;
        
        if (self.isPicks) {
            cell.imageUrl = self.matchTeamData.blueTeamGameData.pickedChampions[indexPath.row];
        }else{
            cell.imageUrl = self.matchTeamData.blueTeamGameData.bannedChampions[indexPath.row];
        }
        
    }else{
        cell.isBlueTeam = NO;
        
        if (self.isPicks) {
            cell.imageUrl = self.matchTeamData.redTeamGameData.pickedChampions[indexPath.row];
        }else{
            cell.imageUrl = self.matchTeamData.redTeamGameData.bannedChampions[indexPath.row];
        }
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
    return [MatchPickCell cellSize];
}

//设置每组的cell的边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0);
    return UIEdgeInsetsZero;
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8.0;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
