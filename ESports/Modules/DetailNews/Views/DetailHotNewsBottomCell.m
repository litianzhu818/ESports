//
//  DetailHotNewsBottomCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DetailHotNewsBottomCell.h"
#import "DetailNewSubTitleCell.h"
#import "DetailNewSubNewCell.h"

@interface DetailHotNewsBottomCell ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailHotNewsBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.tableView.backgroundColor = HexColor(0x121b27);
    [self.tableView registerNib:[DetailNewSubTitleCell nib] forCellReuseIdentifier:[DetailNewSubTitleCell cellIdentifier]];
    [self.tableView registerNib:[DetailNewSubNewCell nib] forCellReuseIdentifier:[DetailNewSubNewCell cellIdentifier]];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"default_title":@"hot news"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"default_title":@"热点新闻"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"default_title":@"熱點新聞"
                                           }
                                   };
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHotNews:(NSArray<HotNew *> *)hotNews
{
    _hotNews = hotNews;
    
    [self.tableView reloadData];
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([DetailHotNewsBottomCell class])
                          bundle:[NSBundle bundleForClass:[DetailHotNewsBottomCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([DetailHotNewsBottomCell class]);
}

+ (CGFloat)cellHeightWithHotNews:(NSArray<HotNew *> *)hotNews
{
    NSInteger count = hotNews.count;
    return [DetailNewSubTitleCell cellHeight]+count*[DetailNewSubNewCell cellHeight];
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [DetailNewSubTitleCell cellHeight];
    }else{
        return [DetailNewSubNewCell cellHeight];
    }
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row >= 1) {
        HotNew *news = self.hotNews[indexPath.row - 1];
        if (self.selectedNewsBlock) {
            self.selectedNewsBlock(news.hotNewId);
        }
    }
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hotNews.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DetailNewSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[DetailNewSubTitleCell cellIdentifier]
                                                                      forIndexPath:indexPath];
        cell.title = LTZLocalizedString(@"default_title", nil);
        return cell;
    }else{
        DetailNewSubNewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DetailNewSubNewCell cellIdentifier]
                                                                      forIndexPath:indexPath];
        HotNew *news = self.hotNews[indexPath.row - 1];
        cell.newsId = news.hotNewId;
        cell.newsTitle = news.hotNewTitle;
        cell.newsImageUrl = news.hotNewImageUrl;
        cell.notShowBottomLine = (indexPath.row == self.hotNews.count);
        return cell;
    }
    return nil;
}

- (void)languageDidChanged
{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

@end
