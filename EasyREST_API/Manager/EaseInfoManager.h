//
//  EaseInfoManager.h
//  testHUD
//
//  Created by yuhailong on 15-5-3.
//  Copyright (c) 2015年 zuiye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"


@interface EaseInfoManager : NSObject
+(void)saveAPPEaseInfo:(NSDictionary*)info;
+(NSArray*)getAllRequstInfo;
+(NSString*)getUrlPathByPathInfo:(NSDictionary*)pathInfo;
@end
