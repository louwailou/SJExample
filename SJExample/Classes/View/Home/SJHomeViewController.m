//
//  SJHomeViewController.m
//  SJExample
//
//  Created by Sun on 2018/3/13.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJHomeViewController.h"
#import "SJHomeViewModelProtocol.h"
#import "UIViewController+TabbarItem.h"
@interface SJHomeViewController ()
@property (strong, nonatomic) id<SJHomeViewModelProtocol> viewModel;

@end

@implementation SJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UINavigationController *indexViewController = ({
        
        UIViewController *indexVC = [self.routerService matchController:self.viewModel.indexRoute];
        
        //UIImage *normalIcon = [UIImage imageNamed:@"tabbar_case"];//
        //UIImage *selectedIcon = [UIImage imageNamed:@"tabbar_home_selected"];//
        indexVC.tabBarItem = [self itemWithTitle:indexVC.viewModel.title normalImg:@"tabbar_home" selectImg:@"tabbar_home_selected"];
        
        [[UINavigationController alloc] initWithRootViewController:indexVC];
    });

    //案例
    UINavigationController *caseViewController = ({
        UIViewController *caseVC = [self.routerService matchController:self.viewModel.caseRoute];
        
       // UIImage *normalIcon = [UIImage imageNamed:@"tabbar_case"];//
       // UIImage *selectedIcon = [UIImage imageNamed:@"tabbar_case_selected"];
        caseVC.tabBarItem = [self itemWithTitle:caseVC.viewModel.title normalImg:@"tabbar_case" selectImg:@"tabbar_case_selected"];
        [[UINavigationController alloc] initWithRootViewController:caseVC];
    });
    
    //工作台
    UINavigationController *workViewController = ({
        UIViewController *workVC = [self.routerService matchController:self.viewModel.workRoute];
        
        //UIImage *normalIcon = [UIImage imageNamed:@"tabbar_work"];//
        //UIImage *selectedIcon = [UIImage imageNamed:@"tabbar_work_selected"];
        workVC.tabBarItem = [self itemWithTitle:workVC.viewModel.title normalImg:@"tabbar_work" selectImg:@"tabbar_work_selected"];
        [[UINavigationController alloc] initWithRootViewController:workVC];
    });
    // 我的
    UINavigationController *profileViewController = ({
        UIViewController *profileVC = [self.routerService matchController:self.viewModel.myRoute];
        
        //UIImage *normalIcon = [UIImage imageNamed:@"tabbar_profile"];//
        //UIImage *selectedIcon = [UIImage imageNamed:@"tabbar_profile_selected"];
        profileVC.tabBarItem = [self itemWithTitle:profileVC.viewModel.title normalImg:@"tabbar_profile" selectImg:@"tabbar_profile_selected"];//[[UITabBarItem alloc] initWithTitle:profileVC.viewModel.title image:normalIcon selectedImage:selectedIcon];
        
        [[UINavigationController alloc] initWithRootViewController:profileVC];
    });
    NSLog(@"viewContrllers = %@",@[indexViewController, caseViewController, workViewController, profileViewController ]);
    
    self.tabBarController.viewControllers = @[indexViewController, caseViewController, workViewController, profileViewController ];
    
   
   
    
    // Do any additional setup after loading the view.
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [tabBarController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:viewController]) {
            
            [self.viewModel tabbarDidSelectedIndex:idx];
            *stop = YES;
        }
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
