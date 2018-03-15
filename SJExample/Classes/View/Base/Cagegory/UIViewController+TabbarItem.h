//
//  UIViewController+TabbarItem.h
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TabbarItem)
- (UITabBarItem *)itemWithTitle:(NSString *)title normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg;
@end
