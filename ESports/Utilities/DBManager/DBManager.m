//
//  DBManager.m
//  Kissnapp
//
//  Created by Peter Lee on 14/7/28.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
Single_implementation(DBManager);

-(BOOL)setDatabasePath:(NSString *)path
{
    self.DBPath = path;
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:self.DBPath];
    if (self.databaseQueue) {
        return [self createTableWithName:@"DefaultTable" tableType:DatabaseTableDefaultType];
    }
    
    return NO;
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

- (BOOL)createMessageTableWithName:(NSString *)tableName
{
    __block BOOL result = NO;
    if ([self existsTableWithName:tableName]) {
        return result;
    }
    
//    NSString *SQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'\
//                     ('%@' TEXT PRIMARY KEY AUTOINCREMENT NOT NULL, \
//                     '%@' TEXT NOT NULL, \
//                     '%@' TEXT NOT NULL, \
//                     '%@' TEXT NOT NULL, \
//                     '%@' INTEGER NOT NULL, \
//                     '%@' INTEGER NOT NULL, \
//                     '%@' TEXT, \
//                     '%@' TEXT, \
//                     '%@' REAL, \
//                     '%@' TEXT, \
//                     '%@' TEXT, \
//                     '%@' TEXT, \
//                     '%@' REAL, \
//                     '%@' REAL, \
//                     '%@' INTEGER  \
//                     )",tableName,@"msgID",@"msgFrom",@"msgTo",@"msgTime",\
//                     @"msgType",@"msgIsSend",@"msgText",\
//                     @"msgFilePath",@"msgTimeLength",@"msgLongitude",@"msgLatitude",\
//                     @"msgFileName",@"msgImageWidth",@"msgImageHeight",@"msgTag"];
    
    NSString *createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'\
                     ('%@' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \
                      '%@' TEXT  NOT NULL, \
                      '%@' INTEGER NOT NULL, \
                      '%@' TEXT NOT NULL \
                     )",tableName,@"ID",@"msgID",@"private",@"msgJsonStr"];
    
    NSString *createIndexSQL = [NSString stringWithFormat:@"CREATE INDEX IF NOT EXISTS '%@'\
                                ON '%@'('%@')",[NSString stringWithFormat:@"%@_%@",tableName,@"table_index"],tableName,@"msgID"];
    
    
    NSString *insertValueSQL = [NSString stringWithFormat:@"INSERT INTO '%@'('%@') VALUES('%@')",@"DefaultTable",@"MessageTableName",tableName];
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if([db executeUpdate:createTableSQL]){
            result = [db executeUpdate:createIndexSQL];
            result = [db executeUpdate:insertValueSQL];
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
        case DatabaseMessageTableType:
            result = [self createMessageTableWithName:tableName];
            break;
            
        default:
            break;
    }
    
    return result;
}


//#pragma mark -
//#pragma mark - 聊天信息操作 Methods
//
//-(void)getNewMessage:(NSNotification *)notification
//{
//    Message *newMessage = notification.object;
//    
//    [self insertMessageValues:newMessage toTable:newMessage.fromUser];
//    if (newMessage.messageType == MessageVoiceType) {
//        if (newMessage.messageTag && !newMessage.filePath) {
//            NSString *fullPath = [[[ChatFileManager sharedInstance] userVoiceDocPath] stringByAppendingPathComponent:newMessage.fileName];
//            GLOBAL_GCD(^{
//                if([newMessage.fileData writeToFile:fullPath atomically:YES]){
//                    newMessage.fileData = nil;
//                    [self updateMessageInfo:newMessage tableName:newMessage.fromUser];
//                }
//            });
//        }
//        
//    }
//
//}
//
//- (void)insertMessageValues:(Message *)message toTable:(NSString *)tableName
//{
//    NSString *SQL = [NSString stringWithFormat:@"INSERT INTO '%@'('%@','%@','%@') VALUES('%@',%d,'%@')",tableName,@"msgID",@"private",@"msgJsonStr",message.messageID,(message.messageOtherTag1 ? 1:0),[[message toDictionary] JSONString]];
//    [self createTableWithName:tableName tableType:DatabaseMessageTableType];
//    [self.databaseQueue inDatabase:^(FMDatabase *db) {
//        [db executeUpdate:SQL];
//        
//        MAIN_GCD(^{
//            [NotificationCenter postNotificationName:NEW_MESSAGE object:message];
//        });
//    }];
//}
///**
// *  向数据库请求数据，第一次请求是安顺序添加，以后都是插入到数组头部
// *
// *  @param userID 表名
// *  @param count  请求数量
// *  @param offset 起始位置
// *  @param isInit 是否是第一次请求
// *
// *  @return 全部信息数组
// */
//- (NSMutableArray *)messagesfrom:(NSString *)userID withCount:(NSInteger)count offset:(NSInteger)offset
//{
//    [self createTableWithName:userID tableType:DatabaseMessageTableType];
//    NSMutableArray *infoArray = [NSMutableArray array];
//    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM '%@' \
//                                                 WHERE  %@ = 0 \
//                                                 ORDER BY %@ DESC \
//                                                 LIMIT %d OFFSET %d",userID,@"private",@"ID",count,offset];
//    [self.databaseQueue inDatabase:^(FMDatabase *db) {
//        FMResultSet *rs = [db executeQuery:SQL];
//        while ([rs next]) {
//            Message *newMessage = [[Message alloc] init];
//            [newMessage fromDictionary:[[rs stringForColumn:@"msgJsonStr"] objectFromJSONString]];
//            [infoArray insertObject:newMessage atIndex:0];
//        }
//
//    }];
//    
//    return infoArray;
//}
//
//- (void)updateMessageInfo:(Message *)newMessage tableName:(NSString *)tableName
//{
//    NSString *SQL = [NSString stringWithFormat:@"UPDATE '%@' SET %@ = '%@' \
//                                                 WHERE %@ = '%@'",tableName,@"msgJsonStr",[[newMessage toDictionary] JSONString],@"msgID",newMessage.messageID];
//    
//    [self.databaseQueue inDatabase:^(FMDatabase *db) {
//        [db executeUpdate:SQL];
//    }];
//}
@end
