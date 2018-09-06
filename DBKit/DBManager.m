//
//  DBManager.m
//  DBKit
//
//  Created by Lucifer on 2018/8/30.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import "DBManager.h"
#import "DBObject.h"
#import <objc/runtime.h>

@interface DBManager ()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation DBManager

static DBManager *manager = nil;

+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [DBManager new];
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"DBManager.db"];

        manager.dataBase = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        manager.lock = [[NSLock alloc] init];
        NSLog(@"current thread = %@", [NSThread currentThread]);
        
        manager.queue = dispatch_queue_create("dataBaseQueue", 0);
        dispatch_async(manager.queue, ^{
            
//            [manager.lock lock];
            NSLog(@"block thread = %@", [NSThread currentThread]);
            [manager.dataBase inDatabase:^(FMDatabase * _Nonnull db) {
                
                bool update = [db executeUpdate:[DBObject SQLTableString]];
                NSLog(@"update = %@", update?@"yes":@"no");
                NSLog(@"dataBaseBlock thread = %@", [NSThread currentThread]);
            }];
//            [manager.lock unlock];
        });
        
        
    });
    
    return manager;
}

- (BOOL)saveDBObject:(DBObject *)object {
    
    NSDictionary *ivarList = [object getAllIvarNameAndType];
    NSMutableDictionary *classMap = [@{} mutableCopy];
    for (NSString *key in ivarList.allKeys) {
        
        NSString *value = [ivarList objectForKey:key];
        if (![value isEqualToString:@"B"] && ![value isEqualToString:@"i"] && ![value isEqualToString:@"f"] /*&& ![value isEqualToString:@"@\"NSString\""]*/) {
            
            //获取value对应的类，判断是否实现DBObject协议
            value = [value substringWithRange:NSMakeRange(2, value.length-2)];
            NSString *className = [value substringWithRange:NSMakeRange(0, value.length-1)];
            
            Class class = NSClassFromString(className);
            uint count = 0;
            Protocol * __unsafe_unretained _Nonnull*protocolList = class_copyProtocolList(class, &count);
            for (unsigned int i=0; i<count; i++) {
                Protocol *myProtocal=protocolList[i];
                const char *protocolName=protocol_getName(myProtocal);
                NSLog(@"protocol----->%@",[NSString stringWithUTF8String:protocolName]);
                if ([[NSString stringWithUTF8String:protocolName] isEqualToString:@"DBObject"]) {
                    
                    [classMap setObject:value forKey:key];
                }
            }
        }
    }
    __block BOOL result = NO;
    dispatch_async(self.queue, ^{
        
        for (NSString *key in classMap) {
            
            
        }
        NSString *sqlString = [NSString stringWithFormat:@"update \'%@\' set", object.SQLTableName];
        NSMutableArray *argumentList = [@[] mutableCopy];
        for (NSString *key in ivarList.allKeys) {
            
            sqlString = [sqlString stringByAppendingString:[NSString stringWithFormat:@" %@ = %%\@,", key]];
            if ([classMap.allKeys containsObject:key]) {
                
                DBObject *value = [object valueForKey:key];
                [argumentList addObject:[NSString stringWithFormat:@"%@-%@", value.SQLTableName, [value valueForKey:value.mainKey]]];
            } else {
                
                
                [argumentList addObject:[object valueForKey:key]?:@""];
            }
        }
        
        [self.dataBase inDatabase:^(FMDatabase * _Nonnull db) {
            
            result = [db executeUpdate:sqlString withArgumentsInArray:@[]];
        }];
    });
    
    return result;
}


@end
