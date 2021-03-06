//
//  DBObject.m
//  DBKit
//
//  Created by Lucifer on 2018/8/30.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import "DBObject.h"
#import <objc/runtime.h>
#import "MyObject.h"
@interface DBObject()

@property (nonatomic, copy) NSString *interfaceString;
@property (nonatomic, assign) int intProperty;

@end

@implementation DBObject

+ (void)load {
    
    
}

+ (NSString *)SQLTableName {
    
    return NSStringFromClass(self.class);
}

- (NSString *)SQLTableName {
    
    return NSStringFromClass(self.class);
}

- (NSData *)toJsonData {

    NSMutableDictionary *ivarDic = [@{} mutableCopy];

    NSDictionary *dic = [self getAllIvarNameAndType];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([obj isEqualToString:@"B"] || [obj isEqualToString:@"i"] || [obj isEqualToString:@"f"]) {
            
            NSNumber *value = [self valueForKey:key];
            [ivarDic setObject:value forKey:key];
        } else if ([obj isEqualToString:@"@\"NSString\""]) {
            
            NSString *value = [self valueForKey:key]?:@"";
            [ivarDic setObject:value forKey:key];
        }
    }];

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:ivarDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    return jsonData;
}

- (NSDictionary *)toJsonDic {
    
    NSMutableDictionary *ivarDic = [@{} mutableCopy];
    
    NSDictionary *dic = [self getAllIvarNameAndType];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isEqualToString:@"B"] || [obj isEqualToString:@"i"] || [obj isEqualToString:@"f"]) {
            
            NSNumber *value = [self valueForKey:key];
            [ivarDic setObject:value forKey:key];
        } else if ([obj isEqualToString:@"@\"NSString\""]) {
            
            NSString *value = [self valueForKey:key]?:@"";
            [ivarDic setObject:value forKey:key];
        }
    }];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:ivarDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    return jsonDic;
}

- (NSDictionary *)getAllIvarNameAndType {
    
    uint count;
    Ivar *ivarList = class_copyIvarList(self.class, &count);
    NSMutableDictionary *ivarDic = [@{} mutableCopy];
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        ivarName = [ivarName substringFromIndex:1];
        NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
        NSLog(@"name = %@, type = %@", ivarName, ivarType);
        [ivarDic setObject:ivarType forKey:ivarName];
    }
    
    return ivarDic;
}

+ (NSDictionary *)runtime {
    //获取property的名字以及对应的类型
    uint count;
    objc_property_t *propertyList = class_copyPropertyList(self.class, &count);
    NSMutableDictionary *propertyDic = [@{} mutableCopy];
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = propertyList[i];
//        NSLog(@"propertyName = %s attributes = %s", property_getName(property), property_getAttributes(property));
        NSDictionary *dic = [self typeOfProperty:[NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding]];
//        NSLog(@"dic = %@", dic);
        [propertyDic addEntriesFromDictionary:dic];
    }
    
    return [propertyDic copy];
}

+ (NSDictionary *)typeOfProperty:(NSString *)propertyAttribute {
    
    NSString *attribute = [propertyAttribute substringWithRange:NSMakeRange(0, 2)];
    NSRange nameRange = [propertyAttribute rangeOfString:@"V_"];
    NSUInteger nameLocation = nameRange.location+nameRange.length;
    NSString *name = [propertyAttribute substringWithRange:NSMakeRange(nameLocation, propertyAttribute.length - nameLocation)];
    NSDictionary *dic = @{};
    if ([attribute isEqualToString:@"Ti"]) {
        
        dic = @{name:@"INTEGER"};
    } else if ([attribute isEqualToString:@"T@\"NSString\""]) {
        
        dic = @{name:@"TEXT"};
    } else if ([attribute isEqualToString:@"Tf"]) {
        
        dic = @{name:@"FLOAT"};
    } else if ([attribute isEqualToString:@"TB"]) {
        
        dic = @{name:@"BOOL"};
    } else  {
        
        dic = @{name:@"TEXT"};
    }
    return dic;
}

- (NSString *)mainKey {
    
    NSString *tableName = [self SQLTableName];
    NSString *first = [tableName substringToIndex:1].lowercaseString;
    NSString *key = [NSString stringWithFormat:@"%@%@Id", first, [tableName substringWithRange:NSMakeRange(1, tableName.length-1)]];//转化为首字母小写
    return key;
}

+ (NSString *)mainKey {
    
    NSString *tableName = [self SQLTableName];
    NSString *first = [tableName substringToIndex:1].lowercaseString;
    NSString *key = [NSString stringWithFormat:@"%@%@Id", first, [tableName substringWithRange:NSMakeRange(1, tableName.length-1)]];//转化为首字母小写
    return key;
}

+ (NSString *)SQLTableString {
    
    NSString *sql = @"create table if not exists ";
    sql = [sql stringByAppendingString:[NSString stringWithFormat:@"'%@'", [DBObject SQLTableName]]];
    
    NSMutableDictionary *propertyDic = [[self runtime] mutableCopy];
    NSString *key = [self mainKey];
    NSString *value = propertyDic[key];
    if (value) {
        
        [propertyDic removeObjectForKey:key];
    }
    sql = [sql stringByAppendingString:[NSString stringWithFormat:@" (\'%@\' INTEGER PRIMARY KEY AUTOINCREMENT,", key]];
    for (NSString *string in propertyDic.allKeys) {
        
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@" \'%@\' %@,", string, propertyDic[string]]];
    }
    
    sql = [sql substringWithRange:NSMakeRange(0, sql.length-1)];//删除最后一个逗号
    sql = [sql stringByAppendingString:@")"];
    
    NSLog(@"%@ sqlString = %@", [self SQLTableName], sql);
    return sql;
}

@end
