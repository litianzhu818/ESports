//
//  PopMenu.h
//  Kissnapp
//
//  Created by Peter Lee on 15/4/3.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import "CMPopTipView.h"
#import "PopMenuStyle.h"

@interface PopMenu : CMPopTipView

// The selected action block call back with the index you selected
@property (copy, nonatomic) void (^selectBlock)(NSUInteger index);

// The Class you have set for selectting action
@property (copy, nonatomic) void (^classBlock)(__unsafe_unretained Class currentClass);

// The image object array for displaying,you can put UIImage object or its name
@property (strong, nonatomic) NSArray *images;

// The title for displaying
@property (strong, nonatomic) NSArray *titles;

// The Class that you setted for selectting action
@property (strong, nonatomic) NSArray *classes;

@property (assign, nonatomic) BOOL scrollEnabled;

@property (strong, nonatomic) PopMenuStyle *menuStyle;

/**
 *  Init a object with the image array and title array,
 *      you will get the index when you selectting a cell
 *
 *  @param images image object or name for displaying
 *  @param titles title for displaying
 *  @param block  the selected index call back block
 *
 *  @return a PopMenu object
 */
- (id)initWithImages:(NSArray *)images
              titles:(NSArray *)titles
         selectBlock:(void (^)(NSUInteger index)) block;

/**
 *  Init a object with the image array and title array、class array,
 *      you will get the class when you selectting a cell
 *
 *  @param images  image object or name for displaying
 *  @param titles  title for displaying
 *  @param classes The Classes that you setted for selectting action
 *  @param block   the selected Class call back block
 *
 *  @return a PopMenu object
 */
- (id)initWithImages:(NSArray *)images
              titles:(NSArray *)titles
             classes:(NSArray *)classes
          classBlock:(void (^)(__unsafe_unretained Class currentClass)) block;

/**
 *  Init a object with the image array and title array、class array,
 *      you will get the class and index when you selectting a cell
 *
 *  @param images      image object or name for displaying
 *  @param titles      title for displaying
 *  @param classes     The Classes that you setted for selectting action
 *  @param selectBlock the selected index call back block
 *  @param classBlock  the selected Class call back block
 *
 *  @return a PopMenu object
 */
- (id)initWithImages:(NSArray *)images
              titles:(NSArray *)titles
             classes:(NSArray *)classes
         selectBlock:(void (^)(NSUInteger index)) selectBlock
          classBlock:(void (^)(__unsafe_unretained Class currentClass)) classBlock;


- (id)initWithImages:(NSArray *)images
              titles:(NSArray *)titles
             classes:(NSArray *)classes
       scrollEnabled:(BOOL)scrollEnabled
           menuStyle:(PopMenuStyle *)menuStyle
         selectBlock:(void (^)(NSUInteger index)) selectBlock
          classBlock:(void (^)(__unsafe_unretained Class currentClass)) classBlock;

// Show view at a UIBarButtonItem
- (void)showAtBarButtonItem:(UIBarButtonItem *)barButtonItem animated:(BOOL)animated;

// Show view at a view with containerView
- (void)showAtView:(UIView *)targetView inView:(UIView *)containerView animated:(BOOL)animated;

//Dismiss the view
- (void)dismissAnimated:(BOOL)animated;

@end
