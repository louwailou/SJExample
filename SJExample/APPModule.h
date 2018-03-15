//
//  APPModule.h
//  SJExample
//
//  Created by Sun on 2018/3/7.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJRouterServiceProtocol.h"
@interface APPModule : JSObjectionModule

@end

@interface JSObjectionModule (ShuJi)
-(void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass;
-(void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass inScope:(SJRouterScope)scope;
@end




@interface NSObject (SJObjection)
- (id)sj_objection:(id)classOrProtocol;
- (id)sj_objection:(id)classOrProtocol params:(NSDictionary *)params;
- (id)sj_objection:(id)classOrProtocol argumentList:(NSArray *)argList;
@end

