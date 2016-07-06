//
//  PopMenuStyle.h
//  Kissnapp
//
//  Created by Peter Lee on 16/2/29.
//  Copyright © 2016年 AFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopMenuStyle : NSObject

@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) CGFloat borderWidth;
@property (assign, nonatomic) CGFloat cornerRadius;

@property (strong, nonatomic) UIColor *titleTextColor;
@property (strong, nonatomic) UIFont *titleTextFont;
@property (strong, nonatomic) UIColor *cellBackgroundColor;
@property (strong, nonatomic) UIColor *cellSelectedBackgroundColor;
@property (strong, nonatomic) UIImage *cellBottomLineImage;
@property (strong, nonatomic) UIImage *cellSectionBottomLineImage;

@property (assign, nonatomic) NSInteger numberOfCellsInSection;
@property (assign, nonatomic) NSInteger numberOfCellSections;

+ (PopMenuStyle *)defaultMenuStyle;

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor
                            borderColor:(UIColor *)borderColor
                            borderWidth:(CGFloat)borderWidth
                           cornerRadius:(CGFloat)cornerRadius
                         titleTextColor:(UIColor *)titleTextColor
                          titleTextFont:(UIFont *)titleTextFont
                    cellBackgroundColor:(UIColor *)cellBackgroundColor
            cellSelectedBackgroundColor:(UIColor *)cellSelectedBackgroundColor
                    cellBottomLineImage:(UIImage *)cellBottomLineImage
             cellSectionBottomLineImage:(UIImage *)cellSectionBottomLineImage
                 numberOfCellsInSection:(NSInteger)numberOfCellsInSection
                   numberOfCellSections:(NSInteger)numberOfCellSections;

@end
