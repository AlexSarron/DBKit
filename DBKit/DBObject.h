//
//  DBObject.h
//  DBKit
//
//  Created by Lucifer on 2018/8/30.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@class MyObject;
@protocol DBObject

@end

@interface DBObject : NSObject

@property (nonatomic, assign, readonly) int intProperty;
@property (nonatomic, copy) NSString *stringProperty;
@property (nonatomic, assign) float floatProperty;
@property (nonatomic, strong) NSDecimalNumber *decimaNumberProperty;
@property (nonatomic, assign) BOOL boolProperty;

@property (nonatomic, assign) int intTest;
@property (nonatomic, copy) NSString *stringTest;
@property (nonatomic, assign) float floatTest;
@property (nonatomic, strong) NSDecimalNumber *decimaNumberTest;
@property (nonatomic, assign) BOOL boolTest;

@property (nonatomic, strong) MyObject *objectTest;

+ (NSString *)SQLTableName;
- (NSString *)SQLTableName;
+ (NSString *)mainKey;
- (NSString *)mainKey;

+ (NSString *)SQLTableString;
+ (NSDictionary *)runtime;

- (NSDictionary *)toJsonDic;
- (NSData *)toJsonData;

- (NSDictionary *)getAllIvarNameAndType;

@end
