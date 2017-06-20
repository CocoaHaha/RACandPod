//
//  ViewController.m
//  AHello
//
//  Created by 石向锋 on 2017/5/9.
//  Copyright © 2017年 CocoHaHa. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
//#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (nonatomic,strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 300, 300)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image =[UIImage imageNamed:@""];
    [self.view addSubview:imageView];
    
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipe.direction= UISwipeGestureRecognizerDirectionUp;
    [imageView addGestureRecognizer:swipe];
    imageView.userInteractionEnabled=YES;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
     _textField= [[UITextField alloc]initWithFrame:CGRectMake(0, 600, 350, 40)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.text = @"";
    _textField.placeholder = @"";
    _textField.secureTextEntry =YES;
    _textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_textField];

    [[self.textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
        NSLog(@"change");
    }];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"发送请求******");
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"RACDisposable");
        }];
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"每注册一次就会发送一次请求 接收到数据1:%@",x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"每注册一次就会发送一次请求 接收到数据2:%@",x);
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"系统通知被监听");
    }];
    
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"swipe down");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"swipe up");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
