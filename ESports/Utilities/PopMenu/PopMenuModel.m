//
//  PopMenuModel.m
//  Kissnapp
//
//  Created by Peter Lee on 15/4/3.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import "PopMenuModel.h"

@implementation PopMenuModel

- (id)initWithImage:(UIImage *)image title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
    }
    
    return self;
}

#pragma mark - NSCopying Methods
- (id)copyWithZone:(NSZone *)zone
{
    PopMenuModel *newObject = [[[self class] allocWithZone:zone] init];
    //Here is a sample for using the NScoding method
    //Add your code here
    [newObject setImage:self.image];
    [newObject setTitle:self.title];
    
    return newObject;
}


#pragma mark - NSCoding Methods
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //Here is a sample for using the NScoding method
    //Add your code here
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.title forKey:@"title"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        //Here is a sample for using the NScoding method
        //Add your code here
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    return  self;
}


@end
