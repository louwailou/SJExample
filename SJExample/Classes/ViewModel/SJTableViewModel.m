//
//  SJTableViewModel.m
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJTableViewModel.h"
@interface SJTableViewModel()


@end


@implementation SJTableViewModel
@synthesize dataSource = _dataSource;
@synthesize sectionIndexTitles = _sectionIndexTitles;
@synthesize page = _page;
@synthesize perPage = _perPage;
@synthesize totalCount = _totalCount;
@synthesize shouldPullToRefresh = _shouldPullToRefresh;
@synthesize shouldInfiniteScrolling = _shouldInfiniteScrolling;
@synthesize keyword = _keyword;
@synthesize didSelectCommand = _didSelectCommand;

@synthesize pullRefreshTrigger = _pullRefreshTrigger;

- (void)initialize {
    [super initialize];
    
    self.page = 1;
    self.perPage = 10;
    
}


- (NSUInteger)offsetForPage:(NSUInteger)page {
    return (page - 1) * self.perPage;
}

- (void)requestRemoteDataWithPage:(NSUInteger)page {
    
}



@end
