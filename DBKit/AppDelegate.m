//
//  AppDelegate.m
//  DBKit
//
//  Created by Lucifer on 2018/8/30.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import "AppDelegate.h"

@interface Sark2 : NSObject
@property (nonatomic, copy) NSString *name1;
@property (nonatomic, copy) NSString *name;
@end
@implementation Sark2
- (void)speak {
    NSLog(@"my name's %@", self.name);
}
@end

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)sunny {
    
    id cls = [Sark2 class];
    void *obj = &cls;
    NSObject *object = [NSObject new];
    [(__bridge id)(obj) speak];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [self sunny];
    int a[5] = {1,2,3,4,5};
    int *ptr = (int *)(&a+1);
//    NSLog(@"%d,%d",*(a+1),*(ptr-1));
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"4");
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"5");
    });
    
    [self performSelector:@selector(test2)];
    
    [self performSelector:@selector(test3) withObject:nil afterDelay:0];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"6");
    });
    
    [self test1];
    
    return YES;
}

- (void)test1 {
    
    NSLog(@"1");
}

- (void)test2 {
    
    NSLog(@"2");
}

- (void)test3 {
    
    NSLog(@"3");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
