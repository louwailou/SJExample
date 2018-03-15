//
//  SJTabbarViewController.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJViewController.h"
@interface SJTabbarViewController : SJViewController<UITabBarControllerDelegate>
@property (strong, nonatomic, readonly) UITabBarController *tabBarController;
@end
