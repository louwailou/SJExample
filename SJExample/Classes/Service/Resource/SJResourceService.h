//
//  SJResourceService.h
//  SJExample
//
//  Created by Sun on 2018/3/7.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJResourceServiceProtocol.h"
@interface SJResourceService : NSObject<SJResourceServiceProtocol>
+ (SJResourceService*)shared;
@end
