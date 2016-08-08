//
//  PointsType.h
//  ESports
//
//  Created by Peter Lee on 16/8/4.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PointsType : JSONModel

@property (strong, nonatomic) NSString *pointsTypeId;
@property (strong, nonatomic) NSString *pointsTypeName;

@end
