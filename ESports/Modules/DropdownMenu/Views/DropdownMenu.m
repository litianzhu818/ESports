//
//  DropdownMenu.m
//  ESports
//
//  Created by Peter Lee on 16/7/6.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DropdownMenu.h"
#import "DropdownMenuItemCell.h"

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

@interface DropdownMenu ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *container;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@property (assign, nonatomic) NSInteger currentIndex;

@property (assign, nonatomic) CGFloat menuHeight;

@property (assign, nonatomic) BOOL isShowing;

@end

@implementation DropdownMenu

- (void)dealloc
{
    [self.container removeGestureRecognizer:self.tapGestureRecognizer];
}

- (void) setSelectedIndex:(NSInteger)selectedIndex
{
    self.currentIndex = selectedIndex;
    [self reloadItems];
}

- (instancetype)initWithFrame:(CGRect)frame
                        Items:(NSArray<DropdownMenuItem *> *) items
                 currentIndex:(NSInteger)currentIndex
                selectedBlock:(void (^)(NSInteger index))selectedBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = items;
        self.currentIndex = currentIndex;
        self.selectedBlock = selectedBlock;
        //self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        
        self.container = ({
            UIView *view = [[UIView alloc] initWithFrame:self.bounds];
            [self addSubview:view];
            view;
        });
        
        self.menuHeight = [items count]*[DropdownMenuItemCell cellHeight];
        
        self.tableView = ({
        
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                   -self.menuHeight,
                                                                                   self.frame.size.width,
                                                                                   self.menuHeight)
                                                                  style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self addSubview:tableView];
            tableView.scrollEnabled = NO;
            tableView.hidden = YES;
            tableView.backgroundColor = HexColor(0x0e161f);
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tableView registerNib:[DropdownMenuItemCell nib]
            forCellReuseIdentifier:[DropdownMenuItemCell cellIdentifier]];
            tableView;
        });
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)];
        [self.container addGestureRecognizer:self.tapGestureRecognizer];
        
        self.hidden = YES;
        self.isShowing = NO;
    }
    return self;
}

- (void) reloadItems
{
    [self.tableView reloadData];
}

- (void) showMenu
{
    if (self.isShowing) return;
    
    self.hidden = NO;
    self.tableView.hidden = NO;
    self.isShowing = YES;
    
    CGRect menuFrame = self.tableView.frame;
    menuFrame.origin.y = 0.0f;
    
    // Set new alpha of Container View (to get fade effect)
    float containerAlpha = 0.5;
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.tableView.frame = menuFrame;
        [self.container setAlpha:containerAlpha];
        [UIView commitAnimations];
    } else {
        [UIView animateWithDuration:0.4
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:4.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.tableView.frame = menuFrame;
                             [self.container setAlpha: containerAlpha];
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

- (void) hideMenu
{
    if (!self.isShowing) return;
    
    // Set new origin of menu
    CGRect menuFrame = self.tableView.frame;
    menuFrame.origin.y =  - self.menuHeight;
    
    // Set new alpha of Container View (to get fade effect)
    float containerAlpha = 1.0f;
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(iOS6_hideMenuCompleted)];
        
        self.tableView.frame = menuFrame;
        [self.container setAlpha:containerAlpha];
        
        [UIView commitAnimations];
    } else {
        [UIView animateWithDuration:0.3f
                              delay:0.05f
             usingSpringWithDamping:1.0
              initialSpringVelocity:4.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.tableView.frame = menuFrame;
                             [self.container setAlpha: containerAlpha];
                         }
                         completion:^(BOOL finished){
                             self.hidden = YES;
                             self.tableView.hidden = YES;
                             self.isShowing = NO;
                         }];
    }
    
    
}

- (void)iOS6_hideMenuCompleted {
    //self.hidden = YES;
    self.tableView.hidden = YES;
}


#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DropdownMenuItemCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.currentIndex) return;
    
    DropdownMenuItemCell *oldCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex
                                                                                        inSection:0]];
    oldCell.isSelected = NO;
    
    DropdownMenuItemCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    newCell.isSelected = YES;
    
    
    self.currentIndex = indexPath.row;
    
    [self hideMenu];
    
    if (self.selectedBlock) {
        self.selectedBlock(self.currentIndex);
    }
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DropdownMenuItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[DropdownMenuItemCell cellIdentifier]
                                                                      forIndexPath:indexPath];
    
    cell.item = self.items[indexPath.row];
    cell.hasBottomLine = !(indexPath.row == self.items.count - 1);
    cell.isSelected = (indexPath.row == self.currentIndex);
    return cell;
}
@end
