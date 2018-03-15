//
//  SJViewModelServiceImp.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJViewModelServicesProtocol.h"
#import "SJNavigationPrivateProtocol.h"

@interface SJViewModelServicesImp:NSObject <SJViewModelServicesProtocol,SJNavigationPrivateProtocol>

//- (instancetype)initWithNavigationStack:(SJNavigationControllerStack *)navigationStack;

@end
