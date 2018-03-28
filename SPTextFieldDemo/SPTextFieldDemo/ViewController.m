//
//  ViewController.m
//  SPTextFieldDemo
//
//  Created by BoWang on 2018/3/28.
//  Copyright © 2018年 BoWang. All rights reserved.
//

#import "ViewController.h"
#import "SPTextField.h"
@interface ViewController ()<SPTextFieldDelegate,UITextFieldDelegate>
{
    SPTextField *accountField;
    SPTextField *passwordField;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    accountField=[SPTextField spTextFieldWithWidth:200 placeholder:@"手机号码" delegate:self];
    [accountField.textField setDelegate:self];
    [accountField setRegexStr:@"^((1[3-9]))\\d{9}$"];
    [accountField.defaultSeparator setHidden:NO];
    [accountField setBlankErrStr:@"请输入手机号码"];
    [accountField setFormatErrStr:@"请输入正确的手机号码"];
    passwordField=[SPTextField spTextFieldWithWidth:200 placeholder:@"密码" delegate:self];
    [passwordField.textField setDelegate:self];
    [passwordField setRegexStr:@"((?=\\w*\\d)(?=\\w*\\D)|(?=\\w*[a-zA-Z])(?=\\w*[^a-zA-Z]))^\\w{6,20}$"];
    [passwordField setBlankErrStr:@"请输入密码"];
    [passwordField setFormatErrStr:@"请输入正确的密码"];
    [self.view addSubview:accountField];
    [accountField setFrame:CGRectMake(0, 20, accountField.frame.size.width, accountField.frame.size.width)];
    [self.view addSubview:passwordField];
    [passwordField setFrame:CGRectMake(0, 100, passwordField.frame.size.width, passwordField.frame.size.width)];
    [passwordField.textField setSecureTextEntry:YES];
    [passwordField.defaultSeparator setHidden:NO];

    UIButton *alert1= [[UIButton alloc]initWithFrame:CGRectMake(10, 170, 50, 40)];
    [alert1 setTitle:@"alert1" forState:UIControlStateNormal];
    [alert1 addTarget:self action:@selector(alert1) forControlEvents:UIControlEventTouchUpInside];
    UIButton *alert2= [[UIButton alloc]initWithFrame:CGRectMake(120, 170, 50, 40)];
    [alert2 setTitle:@"alert2" forState:UIControlStateNormal];
    [alert2 addTarget:self action:@selector(alert2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alert1];
    [self.view addSubview:alert2];
    [alert1 setBackgroundColor:[UIColor blueColor]];
    [alert2 setBackgroundColor:[UIColor blueColor]];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)alert1{
    [accountField checkText];
}
-(void)alert2{
    [passwordField checkText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
