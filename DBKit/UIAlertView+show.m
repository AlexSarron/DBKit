//
//  UIAlertView+show.m
//  DBKit
//
//  Created by Lucifer on 2018/10/11.
//  Copyright © 2018 Lucifer. All rights reserved.
//

#import "UIAlertView+show.h"
#import <objc/message.h>

@implementation UIAlertView (show)


+ (void)load
{
    // self -> UIImage
    // 获取imageNamed
    // 获取哪个类的方法
    // SEL:获取哪个方法
    Method show = class_getInstanceMethod(self, @selector(show));
    // 获取xmg_imageNamed
    Method new_show = class_getInstanceMethod(self, @selector(new_show));
    
    Method show1 = class_getInstanceMethod(self, @selector(_showAnimated:));
    // 获取xmg_imageNamed
    Method new_show1 = class_getInstanceMethod(self, @selector(new__showAnimated:));
    
    Method show2 = class_getInstanceMethod(self, @selector(_showByReplacingAlert:animated:));
    // 获取xmg_imageNamed
    Method new_show2 = class_getInstanceMethod(self, @selector(new__showByReplacingAlert:animated:));
    
    Method show3 = class_getInstanceMethod(self, @selector(_showByReplacingPreviousAlertAnimated:));
    // 获取xmg_imageNamed
    Method new_show3 = class_getInstanceMethod(self, @selector(new__showByReplacingPreviousAlertAnimated:));
    
    // 交互方法:runtime
    method_exchangeImplementations(show, new_show);
    method_exchangeImplementations(show1, new_show1);
    method_exchangeImplementations(show2, new_show2);
    method_exchangeImplementations(show3, new_show3);
    // 调用imageNamed => xmg_imageNamedMethod
    // 调用xmg_imageNamedMethod => imageNamed
}

- (void)new_show
{
    NSLog(@"1 thread = %@", [NSThread currentThread]);
    [self new_show];
    NSLog(@"2 thread = %@", [NSThread currentThread]);
}

- (void)new__showAnimated:(bool) animated{
    
    NSLog(@"3 thread = %@", [NSThread currentThread]);
    [self new__showAnimated:animated];
    NSLog(@"4 thread = %@", [NSThread currentThread]);
}

- (void)new_showsOverSpringBoardAlerts{
    
    NSLog(@"5 thread = %@", [NSThread currentThread]);
    [self new_showsOverSpringBoardAlerts];
    NSLog(@"6 thread = %@", [NSThread currentThread]);
}

- (void)new__showByReplacingAlert:(NSObject *)o animated:(bool) animated{
    
    NSLog(@"7 thread = %@", [NSThread currentThread]);
    [self new__showByReplacingAlert:o animated:animated];
    NSLog(@"8 thread = %@", [NSThread currentThread]);
}

- (void)new__showByReplacingPreviousAlertAnimated:(bool) animated{
    
    NSLog(@"9 thread = %@", [NSThread currentThread]);
    [self new__showByReplacingPreviousAlertAnimated:animated];
    NSLog(@"10 thread = %@", [NSThread currentThread]);
}

@end
