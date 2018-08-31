//
//  DBManager.m
//  DBKit
//
//  Created by Lucifer on 2018/8/30.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import "DBManager.h"
#import "DBObject.h"
@implementation DBManager

static DBManager *manager = nil;

+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [DBManager new];
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"DBManager.db"];

        manager.dataBase = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        
        [manager.dataBase inDatabase:^(FMDatabase * _Nonnull db) {
           
            bool update = [db executeUpdate:[DBObject SQLTableString]];
            NSLog(@"update = %@", update?@"yes":@"no");
        }];
    });
    
    return manager;
}

@end
