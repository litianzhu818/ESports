//
//  DBManager.m
//  Kissnapp
//
//  Created by Peter Lee on 14/7/28.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import "DBManager.h"

static NSString *const subscribeMatchTableName = @"SubscribeMatch";

@implementation DBManager
Single_implementation(DBManager);

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.DBPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ESPorts.sqlite"];
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:self.DBPath];
}

#pragma mark -
#pragma mark - 基础处理方法 Methods
- (void)inDatabase:(void (^)(FMDatabase *db))block
{
    [self.databaseQueue inDatabase:block];
}


- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block
{
    [self.databaseQueue inTransaction:block];
}


- (void)inDeferredTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block
{
    [self.databaseQueue inDeferredTransaction:block];
}

- (BOOL)existsTableWithName:(NSString *)tableName
{
    __block BOOL isTableExists = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        if ([db tableExists:tableName]) {
            isTableExists = YES;
        }
    }];
    
    return isTableExists;
}

- (BOOL)createSubscribeMatchTable
{
    __block BOOL result = NO;
    
    if ([self existsTableWithName:subscribeMatchTableName]) {
        return result;
    }
    
    /*
    NSString *SQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'\
                     ('%@' TEXT PRIMARY KEY AUTOINCREMENT NOT NULL, \
                     '%@' TEXT NOT NULL, \
                     '%@' TEXT NOT NULL, \
                     '%@' TEXT NOT NULL, \
                     '%@' INTEGER NOT NULL, \
                     '%@' INTEGER NOT NULL, \
                     '%@' TEXT, \
                     '%@' TEXT, \
                     '%@' REAL, \
                     '%@' TEXT, \
                     '%@' TEXT, \
                     '%@' TEXT, \
                     '%@' REAL, \
                     '%@' REAL, \
                     '%@' INTEGER  \
                     )",tableName,@"msgID",@"msgFrom",@"msgTo",@"msgTime",\
                     @"msgType",@"msgIsSend",@"msgText",\
                     @"msgFilePath",@"msgTimeLength",@"msgLongitude",@"msgLatitude",\
                     @"msgFileName",@"msgImageWidth",@"msgImageHeight",@"msgTag"];
     */
    
    NSString *createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'\
                     ('%@' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \
                      '%@' TEXT  NOT NULL, \
                      '%@' TEXT  \
                     )",subscribeMatchTableName,@"id",@"matchId",@"time"];
    
    NSString *createIndexSQL = [NSString stringWithFormat:@"CREATE INDEX IF NOT EXISTS '%@'\
                                ON '%@'('%@')",[NSString stringWithFormat:@"%@_%@",subscribeMatchTableName,@"table_index"],subscribeMatchTableName,@"matchId"];
    
    
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if([db executeUpdate:createTableSQL]){
            result = [db executeUpdate:createIndexSQL];
        }
        
        if (!result) {
            *rollback = YES;
            return;
        }
    }];

    return result;
}

- (BOOL)createDefaultTableWithName:(NSString *)tableName
{
    __block BOOL result = NO;
    if ([self existsTableWithName:tableName]) {
        return result;
    }
    
    NSString *createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'\
                     ('%@' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \
                      '%@' TEXT NOT NULL \
                     )",tableName,@"ID",@"MessageTableName"];
    
    NSString *createIndexSQL = [NSString stringWithFormat:@"CREATE INDEX IF NOT EXISTS '%@'\
                                ON '%@'('%@')",@"default_table_index",tableName,@"ID"];
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if([db executeUpdate:createTableSQL]){
            result = [db executeUpdate:createIndexSQL];
        }
        
        if (!result) {
            *rollback = YES;
            return;
        }
    }];
    return result;
}

- (BOOL)createTableWithName:(NSString *)tableName tableType:(DatabaseTableType)tableType
{
    BOOL result = NO;
    switch (tableType) {
        case DatabaseTableDefaultType:
            result = [self createDefaultTableWithName:tableName];
            break;
        case DatabaseSubscribeMatchTableType:
            result = [self createSubscribeMatchTable];
            break;
            
        default:
            break;
    }
    
    return result;
}

- (void)insertSubscribeMatchWithMatchId:(NSString *)matchId
                              time:(NSDate *)time
                        completionBlock:(void (^)(BOOL result, NSError *error))completionBlock
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"]; //@"yyyy/MM/dd HH:mm:ss Z"
    
    NSString *timeStr = [formatter stringFromDate:time];
    NSString *SQL = [NSString stringWithFormat:@"INSERT INTO '%@'('%@', '%@') VALUES('%@','%@')",subscribeMatchTableName,@"matchId",@"time",matchId,timeStr];
    
    [self createSubscribeMatchTable];
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        if ([db executeUpdate:SQL]) {
            
            if (completionBlock) {
                
                MAIN_GCD(^{
                    completionBlock(YES, nil);
                });
                
            }
        }else{
            if (completionBlock) {
                
                MAIN_GCD(^{
                    completionBlock(NO, db.lastError);
                });
                
            }
        }
    }];
}

- (BOOL)existsSubscribeMatchWithMatchId:(NSString *)matchId
{
    __block BOOL result = NO;
    
    [self createSubscribeMatchTable];

    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM SubscribeMatch WHERE matchId = '%@'",matchId];
  
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *rs = [db executeQuery:SQL];
        
        if ([rs next]) {
            result = YES;
            [rs close];
        }
    }];
    
    return result;
}

@end
