//
//  ViewController.m
//  DBKit
//
//  Created by Lucifer on 2018/8/30.
//  Copyright © 2018年 Lucifer. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"
#import "DBObject.h"
#import "MyObject.h"
@interface ViewController ()

@property (nonatomic, strong) DBManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.manager = [DBManager shareManager];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    DBObject *object = [DBObject new] ;
    object.intTest = 1;
//    object.intProperty = 2;
    object.stringTest = @"asa";
    object.stringProperty = @"qwe";
    object.floatTest = 1.22;
    object.floatProperty = 3.12322;
    object.boolTest = NO;
    object.boolProperty = true;
    [object toJsonDic];
    [DBObject SQLTableString];
    
    [MyObject SQLTableString];
    
    
    self.manager = [DBManager shareManager];
    [self.manager saveDBObject:object];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
