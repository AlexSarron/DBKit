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
#import "AFNetworking.h"
#import "NSObject+method.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "NSDictionary+objectForKey.h"

@interface ViewController ()

@property (nonatomic, strong) DBManager *manager;

@end
@interface Sark : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *name1;
@property (nonatomic, copy) NSString *name2;
@end
@implementation Sark
- (void)speak {
    
    NSLog(@"self = %@, address = %p", self, self);
    NSLog(@"my name's %@, address = %p", self.name, &_name);
//    NSLog(@"my name1's %@, address = %p", self.name1, &_name1);
    NSLog(@"my name2's %@, address = %p", self.name2, &_name2);
}
@end
@interface Sark1 : Sark

@end
@implementation Sark1

- (instancetype)init {
    
    self = [super init];
    [self speak];
    [super speak];
    return self;
}

- (void)speak {
    NSLog(@"my %@", self);
}
@end
@implementation ViewController


- (void)sunny {
    
    id cls = [Sark class];
    void *obj = &cls;
    NSObject *object = [NSObject new];
    [(__bridge id)(obj) speak];
     
}

- (void)viewDidLoad {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
//    [super viewDidLoad];
//    [super viewDidLoad];
    /*
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSThread currentThread].description message:@"" delegate:nil cancelButtonTitle:@"1" otherButtonTitles:nil];
//        [alert show];
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSThread currentThread].description  message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:okAction];
        [self presentViewController:alertVC animated:false completion:^{
         
            NSLog(@"current thread = %@", [NSThread currentThread]);
        }];
        
        [CATransaction flush];
    });
    */
    /*
     int i = 10;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@" i = %d",i);
    });
    
    NSLog(@"change before i = %d", i);
    i = 20;
    NSLog(@"change after i = %d", i);
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:@{@"key":@"value"}];
    NSString *value = [dic objectForKey:@"key"];
    NSString *value1 = dic[@"key"];
    
    UIButton *sdButon = [UIButton buttonWithType:UIButtonTypeCustom];
    sdButon.frame = CGRectMake(50, 50, 100, 100);
    [sdButon sd_setImageWithURL:[NSURL URLWithString:@"http://blog.leichunfeng.com/images/check_green.png"] forState:UIControlStateNormal];
    [self.view addSubview:sdButon];
//    [sdButon sizeToFit];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSURL *URL = [NSURL URLWithString:@"http://blog.leichunfeng.com/images/check_green.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/check_green.png", documentsDir]];
    CFDataRef rawData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/check_green.png", documentsDir]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    NSData *imageData = UIImagePNGRepresentation(image);
    */
//    [super class];
//    [super viewDidLoad];
    NSLog(@"ViewController = %@ , 地址 = %p", self, &self);
    [self class];
    NSLog(@"ViewController = %@ , 地址 = %p", self, &self);
    NSObject *objc = [NSObject new];
    NSLog(@"objc = %@ , 地址 = %p", objc, &objc);
    
    NSLog(@"ViewController = %@ , 地址 = %p", self, &self);
    
    id cls = [Sark class];
    NSLog(@"Sark class = %@ 地址 = %p", cls, &cls);
    
    void *obj = &cls;
    NSLog(@"Void *obj = %@ 地址 = %p", obj,&obj);
    
    [(__bridge id)obj speak];
    
    Sark *sark = [[Sark alloc]init];
    sark.name = @"name";
    void *objs = (__bridge void *)sark;
    
    NSLog(@"Sark instance = %@ 地址 = %p", sark, &sark);
    NSLog(@"Sark instance = %@ 地址 = %p", sark.name, &sark+1);
    NSLog(@"void *objs = %@ 地址 = %p", objs, &objs);
//    NSLog(@"void *objs = %@ 地址 = %p", (objs+6), &objs+6);
    /*
    void *selfObject0 = &cls+2;
    NSLog(@"selfObject = %@", (__bridge id)selfObject0);

    void *selfObject = &cls+2;
    NSLog(@"selfObject = %@", (__bridge id)selfObject);

    void *selfObject1 = &cls+4;
    NSLog(@"selfObject = %@", (__bridge id)selfObject1);
    
    [sark speak];
    
   
    [self sunny];
    // Do any additional setup after loading the view, typically from a nib.
//    self.manager = [DBManager shareManager];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    SEL select = (SEL) "stringButton";
    SEL select1 = @selector(stringButton);
    [button addTarget:self action:select forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [[self class] performSelector:@selector(method)];
    [NSObject performSelector:@selector(method)];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSInteger i = -1;
    NSUInteger j = 255;
    if (i<j) {
        
        NSLog(@"123");
    } else {
        
        NSLog(@"456");
    }
    
    char x = -1;
    NSUInteger y = 256;
    
    NSLog(@"%s %d", __func__, x < y);
    NSLog(@"%s %d", __func__, y > x);
    */
}

- (IMP)methodForSelector:(SEL)aSelector {
    
    
    return [super methodForSelector:aSelector];
}

- (void)keyboardWillShow {
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    UIWindow *keyboardWindow = windows.lastObject;
    UIViewController *vc = keyboardWindow.rootViewController;
    NSArray *views = vc.view.subviews.firstObject.subviews.lastObject.subviews.firstObject.subviews.firstObject.subviews.firstObject.subviews.firstObject.subviews;
    UIView *view = views.lastObject;
    CALayer *layer = view.layer.sublayers.firstObject;
//    layer.contentsMultiplyColor = UIColor.redColor.CGColor;
    [layer setValue:UIColor.redColor.CGColor forKey:@"contentsMultiplyColor"];
    
}


- (IBAction)getText:(UITextField *)sender forEvent:(UIEvent *)event {
    
    UITextRange *selectedRange = [sender markedTextRange];
    
    NSString * newText = [sender  textInRange:selectedRange];
    
    if(newText.length>0)
    return;
    
    NSLog(@"newText = %@", newText);
    NSLog(@"textFiled.text = %@", sender.text);
}
- (void)stringButton {
    
    NSLog(@"touch me");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:true];
    /*
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
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
