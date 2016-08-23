//
//  DropdownMenu.h
//  ESports
//
//  Created by Peter Lee on 16/7/6.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownMenuItem.h"

@interface DropdownMenu : UIView

@property (strong, nonatomic) NSArray<DropdownMenuItem *> *items;
@property (copy, nonatomic) void (^selectedBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame
                        Items:(NSArray<DropdownMenuItem *> *) items
                 currentIndex:(NSInteger)currentIndex
                selectedBlock:(void (^)(NSInteger index))selectedBlock;

- (void) showMenu;
- (void) hideMenu;
- (BOOL) isShowing;
- (void) reloadItems;
- (void) setSelectedIndex:(NSInteger)selectedIndex;

@end
