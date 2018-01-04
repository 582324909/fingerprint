//
//  ViewController.m
//  指纹
//
//  Created by 张伟伟 on 2018/1/4.
//  Copyright © 2018年 张伟伟. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LAContext.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fingerprint];
}

-(void)fingerprint {
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    //提示文字
    NSString *hint = @"请使用您的指纹以解锁";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:hint
                            reply:^(BOOL success, NSError * _Nullable error) {
                                if (success) {
                                    /*
                                     指纹验证成功之后执行的方法
                                     本段代码写的例子是成功之后进入主页，不成功则进入验证失败的页面
                                     */
                                    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    [self presentViewController:[sto instantiateViewControllerWithIdentifier:@"HOME"] animated:YES completion:nil];
                                }else {
                                    //指纹验证失败执行的方法（有三次验证的机会，三次都失败才会进入下面的方法）
                                    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    [self presentViewController:[sto instantiateViewControllerWithIdentifier:@"error"] animated:YES completion:nil];
                                }
                            }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
