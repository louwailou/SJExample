//
//  SJLoginViewModelProtocol.h
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#ifndef SJLoginViewModelProtocol_h
#define SJLoginViewModelProtocol_h
#import "SJViewModelProtocol.h"
@protocol SJLoginViewModelProtocol <SJViewModelProtocol>

- (void)push;
- (void)resetToRoot;

@end

#endif /* SJLoginViewModelProtocol_h */
