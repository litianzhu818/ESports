//
//  PlayerRole.h
//  ESports
//
//  Created by Peter Lee on 16/8/24.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PlayerRole : JSONModel

@property (strong, nonatomic) NSString *roleId;
@property (strong, nonatomic) NSString *roleName;
@property (strong, nonatomic) NSString *roleNameCn;
@property (strong, nonatomic) NSString *roleNameEn;
@property (strong, nonatomic) NSString *roleNameTw;
@property (strong, nonatomic) NSString *roleOrder;

@end
