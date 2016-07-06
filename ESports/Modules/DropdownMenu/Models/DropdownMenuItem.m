//
//  DropdownMenuItem.m
//  ESports
//
//  Created by Peter Lee on 16/7/6.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DropdownMenuItem.h"

@implementation DropdownMenuItem

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title image:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
{
    return [self initWithTitle:title
                         image:image
                    isSelected:NO];
}

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                   isSelected:(BOOL)isSelected
{
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        self.isSelected = isSelected;
    }
    return self;
}

#pragma mark - NSCopying nethods
- (id)copyWithZone:(nullable NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithTitle:self.title
                                                      image:self.image
                                                 isSelected:self.isSelected];
}

#pragma mark - NSCoding nethods
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(title))];
        self.image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
        self.isSelected = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isSelected))];
    }
    return  self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:NSStringFromSelector(@selector(title))];
    [aCoder encodeObject:self.image forKey:NSStringFromSelector(@selector(image))];
    [aCoder encodeBool:self.isSelected forKey:NSStringFromSelector(@selector(isSelected))];
}


@end
