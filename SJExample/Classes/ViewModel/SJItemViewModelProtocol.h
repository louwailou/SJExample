//
//  SJItemViewModelProtocol.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//
#import "SJViewModelProtocol.h"

@protocol SJItemViewModelProtocol<NSObject>

@property (strong, nonatomic) SJCallback callbackCommand;

@property (weak, nonatomic, readonly) NSObject<SJViewModelProtocol> *hostViewModel;

-(instancetype)initWithHostViewModel:(id<SJViewModelProtocol>)viewModel dataModel:(id)dataModel;

@optional
-(void)initialize;

@end
