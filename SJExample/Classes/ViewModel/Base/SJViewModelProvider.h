//
//  SJViewModelProvider.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJViewModelProvider : NSObject<JSObjectionProvider>
- (instancetype)initWithClass:(Class)classObject;
@property (strong,nonatomic,readonly) Class classObject;
@end


@interface JFItemViewModelProvider: SJViewModelProvider

@end
