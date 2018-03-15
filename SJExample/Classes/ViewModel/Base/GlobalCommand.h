//
//  Global.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJCallbackResult.h"

typedef void (^SJCallback)(NSDictionary *resultDic, NSError *error);

typedef void (^SJRequestApiCallback)(NSDictionary *params, NSString*api);

// cell 选中
typedef void (^SJCellDidSelectCommand)(NSIndexPath *indexPath,id params);
