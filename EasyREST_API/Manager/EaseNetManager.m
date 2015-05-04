//
//  EaseNetManager.m
//  testHUD
//
//  Created by yuhailong on 15-5-3.
//  Copyright (c) 2015年 zuiye. All rights reserved.
//

#import "EaseNetManager.h"
static EaseNetManager* _manager;
@implementation EaseNetManager

+(instancetype)sharedManager{
    if (!_manager) {
        _manager = [[EaseNetManager alloc] init];
    }
    
    return _manager;
}

-(NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    
    return _queue;
}

/*
 info字典里的参数
 RESTType :发的哪个请求，根据请求去拼接不同的url
 HTTPMethod : 请求方式 (GET  POST  DELETE)
 HTTPHeader : 头信息，可能有多个字段，所以是个NSDictionary
 HTTPBody : POST请求的body NSDictionary 然后用JSONKit转成data
 limit : 每次操作的用户数量
 
 */
#pragma mark -
#pragma mark - netCommonMethod
/*
    info字典里的参数
 RESTType :发的哪个请求，根据请求去拼接不同的url
 HTTPMethod : 请求方式 (GET  POST  DELETE)
 HTTPHeader : 头信息，可能有多个字段，所以是个NSDictionary
 HTTPBody : POST请求的body NSDictionary 然后用JSONKit转成data
 limit : 每次操作的用户数量
*/
-(void)sendRequestByInfo:(NSDictionary*)info WithBlock:(EaseNetBlock)complation{
    NSString* path = [EaseInfoManager getUrlPathByPathInfo:info];//获取地址
//    NSLog(@"======%@",path);
//    NSLog(@"======%@", info);
//    NSLog(@"======%@", [info objectForKey:@"RESTType"]);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
//    设置请求方式
    if ([info objectForKey:@"HTTPMethod"])
        [request setHTTPMethod:[info objectForKey:@"HTTPMethod"]];
    
//    设置头信息
    NSMutableDictionary* headerDic = [info objectForKey:@"HTTPHeader"];

    if (headerDic)
        for (NSString* key in headerDic)
            [request setValue:[headerDic objectForKey:key] forHTTPHeaderField:key];
    
//    设置body
    if ([info objectForKey:@"HTTPBody"])
        [request setHTTPBody:[[info objectForKey:@"HTTPBody"] JSONData]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            NSDictionary* jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            NSString* token = [jsonDic objectForKey:@"access_token"];
            if ([[info objectForKey:@"RESTType"] isEqualToString:@"获取APP管理员Token"] && token) {//如果解析到了access_token 保存一下
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complation(response, data, connectionError);
        });
        
    }];

}

#pragma mark - allMethod
//获取APP管理员Token
-(void)getTokenWithBlock:(EaseNetBlock)complation{
    NSDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:0];
   
    [self sendRequestByInfo:info WithBlock:complation];
}
//注册IM用户[单个]
-(void)registUserWithUserInfo:(NSDictionary*)userInfo block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:1];
    if (userInfo) [info setObject:userInfo forKey:@"HTTPBody"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//注册IM用户[批量]
-(void)registMoreUsersWithUserInfos:(NSArray*)userInfos block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:2];
    if (userInfos) [info setObject:userInfos forKey:@"HTTPBody"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//
//获取IM用户[单个]
-(void)getUserInfoByRegistID:(NSString*)registID block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:3];
    if (registID) [info setObject:registID forKey:@"username"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//批量获取用户
-(void)getMoreUserInfosWithlimit:(NSInteger)limit WithBlock:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:4];
    if (limit) [info setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//删除IM用户[单个]
-(void)deleteUserByRegistID:(NSString*)registID block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:5];
    if (registID) [info setObject:registID forKey:@"username"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//删除IM用户[批量]
-(void)deleteUsersByLimit:(NSInteger)limit block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:6];
    if (limit) [info setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//重置IM用户密码
-(void)resetUserPasswordWithUserName:(NSString*)userName withNewPassword:(NSString*)password block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:7];
    if (userName) [info setObject:userName forKey:@"username"];
    NSMutableDictionary* bodyDic = [info objectForKey:@"HTTPBody"];
    if (password) [bodyDic setObject:password forKey:@"newpassword"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//修改用户昵称
-(void)changeUserNickNameWithUserName:(NSString*)userName withNickName:(NSString*)nickName block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:8];
    if (userName) [info setObject:userName forKey:@"username"];
    NSMutableDictionary* bodyDic = [info objectForKey:@"HTTPBody"];
    if (nickName) [bodyDic setObject:nickName forKey:@"nickname"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//给IM用户的添加好友
-(void)addFriendToUser:(NSString*)userName withFriend:(NSString*)friendName block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:9];
    if (userName) [info setObject:userName forKey:@"username"];
    if (friendName) [info setObject:friendName forKey:@"friend"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//解除IM用户的好友关系
-(void)relieveFriendToUser:(NSString*)userName withFriend:(NSString*)friendName block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:10];
    if (userName) [info setObject:userName forKey:@"username"];
    if (friendName) [info setObject:friendName forKey:@"friend"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//查看IM用户的好友
-(void)getUserFriendByUserName:(NSString*)userName block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:11];
    if (userName) [info setObject:userName forKey:@"username"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//获取IM用户的黑名单
-(void)getBlackListByUserName:(NSString*)userName block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:12];
    if (userName) [info setObject:userName forKey:@"username"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//往IM用户的黑名单中加人
-(void)addBlacklistToUser:(NSString*)userName withUsernames:(NSArray*)usernames block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:13];
    if (userName) [info setObject:userName forKey:@"username"];
    NSMutableDictionary* bodyDic = [info objectForKey:@"HTTPBody"];
    [bodyDic setObject:usernames forKey:@"usernames"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//从IM用户的黑名单中减人
-(void)deleteBlaclistUserFromUser:(NSString*)userName withDeleteUser:(NSString*)deleteUser block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:14];
    if (userName) [info setObject:userName forKey:@"username"];
    if (deleteUser) [info setObject:userName forKey:@"deleteUser"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//查看用户在线状态
-(void)getOnlineStateWithUser:(NSString*)userName block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:15];
    if (userName) [info setObject:userName forKey:@"username"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//查询离线消息数
-(void)getOffLineMessageCountByUser:(NSString*)userName block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:16];
    if (userName) [info setObject:userName forKey:@"username"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//查询某条离线消息状态
-(void)getOffLineMessageStateWithUser:(NSString*)userName andMessageID:(NSString*)messageID block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:17];
    if (userName) [info setObject:userName forKey:@"username"];
    if (messageID) [info setObject:messageID forKey:@"messageID"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//用户账号禁用
-(void)forbinUser:(NSString*)userName block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:18];
    if (userName) [info setObject:userName forKey:@"username"];
    [self sendRequestByInfo:info WithBlock:complation];
}

//用户账号解禁
-(void)unForbinUser:(NSString*)userName block:(EaseNetBlock)complation{
    NSMutableDictionary* info = [[EaseInfoManager getAllRequstInfo] objectAtIndex:19];
    if (userName) [info setObject:userName forKey:@"username"];
    [self sendRequestByInfo:info WithBlock:complation];
}




@end
