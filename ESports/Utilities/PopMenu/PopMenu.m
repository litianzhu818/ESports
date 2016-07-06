//
//  PopMenu.m
//  Kissnapp
//
//  Created by Peter Lee on 15/4/3.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import "PopMenu.h"
#import "PopMenuCell.h"
#import "PopMenuModel.h"

static const CGFloat tableViewWidth = 120.0f;

@interface PopMenu () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation PopMenu

- (id)initWithImages:(NSArray *)images
              titles:(NSArray *)titles
         selectBlock:(void (^)(NSUInteger index)) block
{
    return [self initWithImages:images
                         titles:titles
                        classes:nil
                    selectBlock:block
                     classBlock:NULL];
}

- (id)initWithImages:(NSArray *)images
              titles:(NSArray *)titles
             classes:(NSArray *)classes
          classBlock:(void (^)(__unsafe_unretained Class currentClass)) block
{
    return [self initWithImages:images
                         titles:titles
                        classes:classes
                    selectBlock:NULL
                     classBlock:block];
}

- (id)initWithImages:(NSArray *)images
              titles:(NSArray *)titles
             classes:(NSArray *)classes
         selectBlock:(void (^)(NSUInteger index)) selectBlock
          classBlock:(void (^)(__unsafe_unretained Class currentClass)) classBlock
{
    return [self initWithImages:images
                         titles:titles
                        classes:classes
                  scrollEnabled:NO
                      menuStyle:nil
                    selectBlock:selectBlock
                     classBlock:classBlock];
}

- (id)initWithImages:(NSArray *)images
              titles:(NSArray *)titles
             classes:(NSArray *)classes
       scrollEnabled:(BOOL)scrollEnabled
           menuStyle:(PopMenuStyle *)menuStyle
         selectBlock:(void (^)(NSUInteger index)) selectBlock
          classBlock:(void (^)(__unsafe_unretained Class currentClass)) classBlock
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.images = images;
        self.titles = titles;
        self.classes = classes;
        self.selectBlock = selectBlock;
        self.classBlock = classBlock;
        self.scrollEnabled = scrollEnabled;
        self.menuStyle = menuStyle ? :[PopMenuStyle defaultMenuStyle];
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tableViewWidth, [self.images count]*[PopMenuCell cellHeight]) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.backgroundColor = self.menuStyle.backgroundColor;
    self.tableView.backgroundColor = self.menuStyle.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PopMenuCell class] forCellReuseIdentifier:[PopMenuCell cellIdentifier]];
    
    self.customView = self.tableView;
    [self addSubview:self.customView];
    
    
    self.hasGradientBackground = NO;
    self.backgroundColor = self.tableView.backgroundColor;
    self.textColor = [UIColor whiteColor];
    self.animation = CMPopTipAnimationPop;
    self.has3DStyle = NO;
    self.dismissTapAnywhere = YES;
    
    
    self.borderWidth = self.menuStyle.borderWidth;
    self.borderColor = self.menuStyle.borderColor;
    self.cornerRadius = self.menuStyle.cornerRadius;
    
}

- (void)showAtBarButtonItem:(UIBarButtonItem *)barButtonItem animated:(BOOL)animated
{
    [self presentPointingAtBarButtonItem:barButtonItem animated:animated];
}

- (void)showAtView:(UIView *)targetView inView:(UIView *)containerView animated:(BOOL)animated
{
    [self presentPointingAtView:targetView inView:containerView animated:animated];
}

- (void)dismissAnimated:(BOOL)animated
{
    [super dismissAnimated:animated];
}

- (void)setImages:(NSArray *)images
{
    _images = [images copy];
    
    [self.tableView reloadData];
}

- (void)setTitles:(NSArray *)titles
{
    _titles = [titles copy];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PopMenuCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectBlock) {
        self.selectBlock(indexPath.row);
    }
    if (self.classBlock && (indexPath.row <= self.classes.count -1) && [self.classes objectAtIndex:indexPath.row]) {
        Class currentClass = NULL;
        id object = [self.classes objectAtIndex:indexPath.row];
        if ([object isKindOfClass:[NSString class]]) {
            currentClass = NSClassFromString(object);
        }else{
            currentClass = object;
        }
        self.classBlock(currentClass);
    }
    [self dismissAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSAssert(([self.images count] == [self.titles count]), @"The count of images is not equal to the count of titles !");
    return [self.images count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:[PopMenuCell cellIdentifier] forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    PopMenuModel *model = [[PopMenuModel alloc] initWithImage:([[self.images objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]] ?  [self.images objectAtIndex:indexPath.row]:[UIImage imageNamed:[self.images objectAtIndex:indexPath.row]]) title:[self.titles objectAtIndex:indexPath.row]];
    
    cell.model = model;
    cell.menuSytle = self.menuStyle;
    
    if (self.menuStyle.numberOfCellSections == 0) {
        cell.bottomLineImage = self.menuStyle.cellBottomLineImage;
    }else{
        if ((indexPath.row +1)%self.menuStyle.numberOfCellsInSection == 0) {
            cell.bottomLineImage = self.menuStyle.cellSectionBottomLineImage ? :self.menuStyle.cellBottomLineImage;
        }else{
            cell.bottomLineImage = self.menuStyle.cellBottomLineImage;
        }
    }
    
    // we should hide the low line for the last cell
    if (indexPath.row == ([self.images count] - 1)) {
        cell.showBottomLine = NO;
    }
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
