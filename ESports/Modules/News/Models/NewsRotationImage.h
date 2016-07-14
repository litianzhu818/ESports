//
//  NewsRotationImage.h
//  ESports
//
//  Created by Peter Lee on 16/7/13.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NewsRotationImage : JSONModel

@property (strong, nonatomic) NSString <Optional> *imageId;
@property (strong, nonatomic) NSString <Optional> *imageTitle;
@property (strong, nonatomic) NSString <Optional> *imageUrl;
@property (strong, nonatomic) NSString <Optional> *detailUrl;

@end
