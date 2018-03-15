//
//  SJTabbarViewController.m
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJTabbarViewController.h"

@interface SJTabbarViewController ()

@property (strong, nonatomic, readwrite) UITabBarController *tabBarController;
@end

@implementation SJTabbarViewController


- (instancetype)initWithViewModel:(id<SJViewModelProtocol>)viewModel{
    if (self = [super initWithViewModel:viewModel]) {
        self.tabBarController = [[UITabBarController alloc] init];
        self.tabBarController.delegate = self;
        [self.tabBarController.tabBar setTranslucent:YES];
        [self.tabBarController.tabBar setBarStyle:UIBarStyleDefault];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.view setBackgroundColor:[UIColor clearColor]];
    self.tabBarController.view.frame = self.view.bounds;
    
    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
