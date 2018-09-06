//
//  DBManager.h
//  DBKit
//
//  Created by Lucifer on 2018/8/30.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@class DBObject;
@interface DBManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dataBase;


+ (instancetype)shareManager;

- (BOOL)saveDBObject:(DBObject *)object;

@end
