//
//  DetailRelNewsBottomCell.m
//  ESports
//
//  Created by Peter Lee on 16/7/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DetailRelNewsBottomCell.h"
#import "DetailNewSubTitleCell.h"
#import "DetailNewSubRelCell.h"

@interface DetailRelNewsBottomCell ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailRelNewsBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = HexColor(0x121b27);
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.tableView.backgroundColor = HexColor(0x121b27);
    [self.tableView registerNib:[DetailNewSubTitleCell nib] forCellReuseIdentifier:[DetailNewSubTitleCell cellIdentifier]];
    [self.tableView registerNib:[DetailNewSubRelCell nib] forCellReuseIdentifier:[DetailNewSubRelCell cellIdentifier]];
    
    self.localStringDictionary = @{
                                   SYS_LANGUAGE_ENGLISH:@{
                                           @"default_title":@"related news"
                                           },
                                   SYS_LANGUAGE_S_CHINESE:@{
                                           @"default_title":@"相关新闻"
                                           },
                                   SYS_LANGUAGE_T_CHINESE:@{
                                           @"default_title":@"相關新聞"
                                           }
                                   };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRelNews:(NSArray<RelNew *> *)relNews
{
    _relNews = relNews;
    
    [self.tableView reloadData];
}

#pragma mark - class methods
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([DetailRelNewsBottomCell class])
                          bundle:[NSBundle bundleForClass:[DetailRelNewsBottomCell class]]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([DetailRelNewsBottomCell class]);
}

+ (CGFloat)cellHeightWithRelNews:(NSArray<RelNew *> *)relNews
{
    NSInteger count = relNews.count;
    return [DetailNewSubTitleCell cellHeight]+count*[DetailNewSubRelCell cellHeight];
}


#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [DetailNewSubTitleCell cellHeight];
    }else{
        return [DetailNewSubRelCell cellHeight];
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
        RelNew *news = self.relNews[indexPath.row - 1];
        if (self.selectedNewsBlock) {
            self.selectedNewsBlock(news.relNewId);
        }
    }
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.relNews.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DetailNewSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[DetailNewSubTitleCell cellIdentifier]
                                                                      forIndexPath:indexPath];
        cell.title = LTZLocalizedString(@"default_title", nil);
        return cell;
    }else{
        DetailNewSubRelCell *cell = [tableView dequeueReusableCellWithIdentifier:[DetailNewSubRelCell cellIdentifier]
                                                                    forIndexPath:indexPath];
        RelNew *news = self.relNews[indexPath.row - 1];
        cell.newsTitle = news.relNewTitle;
        cell.notShowBottomLine = (indexPath.row == self.relNews.count);
        return cell;
    }
    return nil;
}

- (void)languageDidChanged
{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

@end
