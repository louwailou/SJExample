//
//  AppDelegate+Launch.m
//  SJExample
//
//  Created by Sun on 2018/3/7.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "AppDelegate+Launch.h"
#import "APPModule.h"
#import "IndexModule.h"
#import "WorkModule.h"
#import "MyModule.h"
#import "CaseModule.h"
#import "LoginModule.h"

#pragma mark 添加module 
@implementation AppDelegate (Launch)
+ (void)load{
    [JSObjection setDefaultInjector:[JSObjection createInjectorWithModules:
                                     [APPModule new],
                                     [LoginModule new],
                                     [IndexModule new],
                                     [MyModule new],
                                     [WorkModule new],
                                     [CaseModule new],nil]];
#pragma mark 设置缓存
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
@end
