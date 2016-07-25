//
//  DBManager.h
//  Kissnapp
//
//  Created by Peter Lee on 14/7/28.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonManager.h"
#import "FMDB.h"

typedef NS_ENUM(NSInteger,DatabaseTableType){
    DatabaseTableDefaultType = 0,
    DatabaseSubscribeMatchTableType
};

@interface DBManager : NSObject
Single_interface(DBManager);

@property (strong, nonatomic) NSString *DBName;
@property (strong, nonatomic) NSString *DBPath;

@property (strong, nonatomic) FMDatabaseQueue *databaseQueue;

- (void)inDatabase:(void (^)(FMDatabase *db))block;
- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;
- (void)inDeferredTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;

- (BOOL)existsTableWithName:(NSString *)tableName;
- (BOOL)createTableWithName:(NSString *)tableName tableType:(DatabaseTableType)tableType;


- (void)insertSubscribeMatchWithMatchId:(NSString *)matchId
                              firstTime:(NSDate *)firstTime
                             secondTime:(NSDate *)secondTime
                        completionBlock:(void (^)(BOOL result, NSError *error))completionBlock;
- (BOOL)existsSubscribeMatchWithMatchId:(NSString *)matchId;



@end
