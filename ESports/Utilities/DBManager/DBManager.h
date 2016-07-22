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
    DatabaseMessageTableType,
    DatabaseUserInfoTableType,
    DatabaseLoginUserInfoTableType,
    
};

@interface DBManager : NSObject
Single_interface(DBManager);

@property (strong, nonatomic) NSString *DBName;
@property (strong, nonatomic) NSString *DBPath;

@property (strong, nonatomic) FMDatabaseQueue *databaseQueue;

- (BOOL)setDatabasePath:(NSString *)path;
- (void)inDatabase:(void (^)(FMDatabase *db))block;
- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;
- (void)inDeferredTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;

- (BOOL)existsTableWithName:(NSString *)tableName;
- (BOOL)createTableWithName:(NSString *)tableName tableType:(DatabaseTableType)tableType;

/*
- (void)insertMessageValues:(Message *)message toTable:(NSString *)tableName;
- (void)updateMessageInfo:(Message *)newMessage tableName:(NSString *)tableName;
- (NSMutableArray *)messagesfrom:(NSString *)userID withCount:(NSInteger)count offset:(NSInteger)offset;
 */



@end
