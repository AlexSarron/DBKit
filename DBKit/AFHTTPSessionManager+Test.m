//
//  AFHTTPSessionManager+Test.m
//  DBKit
//
//  Created by Lucifer on 2018/10/10.
//  Copyright © 2018 Lucifer. All rights reserved.
//

#import "AFHTTPSessionManager+Test.h"

@implementation AFHTTPSessionManager (Test)

+ (void)load {
    
    
}

+ (instancetype)manager {
    
    NSLog(@"Lucifer");
    return [[[self class] alloc] initWithBaseURL:nil];
}

@end
