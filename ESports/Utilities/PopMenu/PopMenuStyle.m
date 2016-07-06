//
//  PopMenuStyle.m
//  Kissnapp
//
//  Created by Peter Lee on 16/2/29.
//  Copyright © 2016年 AFT. All rights reserved.
//

#import "PopMenuStyle.h"
#import "DefineValues.h"

@implementation PopMenuStyle

+ (PopMenuStyle *)defaultMenuStyle
{
    return [[PopMenuStyle alloc] initWithBackgroundColor:HexColor(0x1b2737)
                                             borderColor:HexColor(0x1b2737)
                                             borderWidth:0.0
                                            cornerRadius:2.0
                                          titleTextColor:[UIColor whiteColor]
                                           titleTextFont:[UIFont systemFontOfSize:15.0]
                                     cellBackgroundColor:[UIColor clearColor]
                             cellSelectedBackgroundColor:HexColor(0x1b2737)
                                     cellBottomLineImage:[UIImage imageNamed:@"cell_line"]
                              cellSectionBottomLineImage:nil
                                  numberOfCellsInSection:0
                                    numberOfCellSections:0];
}

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
                   numberOfCellSections:(NSInteger)numberOfCellSections
{
    self = [super init];
    if (self) {
        self.backgroundColor = backgroundColor;
        self.borderColor = borderColor;
        self.borderWidth = borderWidth;
        self.cornerRadius = cornerRadius;
        self.titleTextColor = titleTextColor;
        self.titleTextFont = titleTextFont;
        self.cellBackgroundColor = cellBackgroundColor;
        self.cellSelectedBackgroundColor = cellSelectedBackgroundColor;
        self.cellBottomLineImage = cellBottomLineImage;
        self.cellSectionBottomLineImage = cellSectionBottomLineImage;
        self.numberOfCellSections = numberOfCellSections;
        self.numberOfCellsInSection = numberOfCellsInSection;
    }
    return self;
}

@end
