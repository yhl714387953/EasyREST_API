//
//  Header.h
//  testHUD
//
//  Created by yuhailong on 15-5-3.
//  Copyright (c) 2015年 zuiye. All rights reserved.
//

#ifndef testHUD_Header_h
#define testHUD_Header_h
#define kSUD(key) [[NSUserDefaults standardUserDefaults] stringForKey:key]
#define kJsonString(data) [NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]]

#endif
