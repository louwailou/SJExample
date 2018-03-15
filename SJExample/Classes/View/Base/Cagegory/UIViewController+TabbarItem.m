//
//  UIViewController+TabbarItem.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UIViewController+TabbarItem.h"

@implementation UIViewController (TabbarItem)
- (UITabBarItem *)itemWithTitle:(NSString *)title normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg{
    UITabBarItem *tabItem;
    
    UIImage * normalImage = [[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage = [[UIImage imageNamed:selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabItem = [[UITabBarItem alloc] initWithTitle:nil
                                            image:normalImage
                                    selectedImage:selectImage];
    
    [tabItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:213/255.0 green:40/255.0 blue:43/255.0 alpha:1]}
                           forState:UIControlStateSelected];
    
    tabItem.title = title;
    
    return tabItem;
}

@end
