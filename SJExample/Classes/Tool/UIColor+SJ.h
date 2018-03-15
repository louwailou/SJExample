//
//  UIColor+SJ.h
//  SJExample
//
//  Created by Sun on 2018/3/13.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SJ)

- (UIImage *)sj_color2Image;

- (UIImage *)sj_color2ImageSized:(CGSize)size;

+ (UIColor *)sj_colorFromString:(NSString *)str;
@end
