//
//  EaseInfoManager.m
//  testHUD
//
//  Created by yuhailong on 15-5-3.
//  Copyright (c) 2015年 zuiye. All rights reserved.
//

#import "EaseInfoManager.h"

@implementation EaseInfoManager

//大多数的请求都有header body 所以创建一个公用的字典
+(NSMutableDictionary*)getCommonDic{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"RESTType" forKey:@"RESTType"];
//    [dic setObject:@"HTTPMethod" forKey:@"HTTPMethod"];
    
    NSMutableDictionary* headerDic = [NSMutableDictionary dictionary];
    if (kSUD(@"access_token")) [headerDic setObject:[NSString stringWithFormat:@"Bearer %@", kSUD(@"access_token")] forKey:@"Authorization"];
    
//    注意这个body不用的时候要删除，否则会请求异常
    NSMutableDictionary* bodyDic = [NSMutableDictionary dictionary];
    [dic setObject:headerDic forKey:@"HTTPHeader"];
    [dic setObject:bodyDic forKey:@"HTTPBody"];
    
    return dic;
}

+(void)saveAPPEaseInfo:(NSDictionary *)info{
//    默认
//    更改 info
    for (NSString* key in info)
        [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:key] forKey:key];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 info字典里的参数
 RESTType :发的哪个请求，根据请求去拼接不同的url
 HTTPMethod : 请求方式 (GET  POST  DELETE)
 HTTPHeader : 头信息，可能有多个字段，所以是个NSDictionary
 HTTPBody : POST请求的body NSDictionary 然后用JSONKit转成data
 limit : 每次操作的用户数量
 username : 待操作的用户
 
 */
//构造一个数据源，外部使用，所有初始的时候有给默认值，大部分参数修改比较直观，外部只简单的修改必要的参数
+(NSArray*)getAllRequstInfo{
    NSMutableArray* infos = [NSMutableArray array];
    //    获取APP管理员Token index [0]
    NSDictionary* dic0 = @{@"RESTType": @"获取APP管理员Token", @"HTTPMethod": @"POST", @"HTTPHeader": @{@"Content-Type": @"application/json"}};
    
    NSMutableDictionary* HTTPBodyDic0 = [NSMutableDictionary dictionary];
    [HTTPBodyDic0 setObject:@"client_credentials" forKey:@"grant_type"];
    if (kSUD(@"client_id")) [HTTPBodyDic0 setObject:kSUD(@"client_id") forKey:@"client_id"];
    if (kSUD(@"client_secret")) [HTTPBodyDic0 setObject:kSUD(@"client_secret") forKey:@"client_secret"];
    
    NSMutableDictionary* mutDic0 = [NSMutableDictionary dictionaryWithDictionary:dic0];
    [mutDic0 setObject:HTTPBodyDic0 forKey:@"HTTPBody"];
    [infos addObject:mutDic0];
    
    //    注册IM用户[单个] index [1]
    NSDictionary* dic1 = @{@"RESTType": @"注册IM用户[单个]", @"HTTPMethod": @"POST"};
    
    NSMutableDictionary* headerDic1 = [NSMutableDictionary dictionary];
    [headerDic1 setObject:@"application/json" forKey:@"Content-Type"];
    if (kSUD(@"access_token")) [headerDic1 setObject:[NSString stringWithFormat:@"Bearer %@", kSUD(@"access_token")] forKey:@"Authorization"];//    授权注册
    NSMutableDictionary* HTTPBodyDic1 = [NSMutableDictionary dictionary];
    [HTTPBodyDic1 setObject:@"wangWu" forKey:@"username"];
    [HTTPBodyDic1 setObject:@"123456" forKey:@"password"];
    [HTTPBodyDic1 setObject:@"王五" forKey:@"nickname"];
    
    NSMutableDictionary* mutDic1 = [NSMutableDictionary dictionaryWithDictionary:dic1];
    [mutDic1 setObject:headerDic1 forKey:@"HTTPHeader"];
    [mutDic1 setObject:HTTPBodyDic1 forKey:@"HTTPBody"];
    [infos addObject:mutDic1];
    
    
    //    注册IM用户[批量] index [2]
    
//    只有body不一样，所以用mutDic1 实例化mutDic2 更改body为多人数组
    NSMutableDictionary* mutDic2 = [NSMutableDictionary dictionaryWithDictionary:mutDic1];
    [mutDic2 setObject:@"注册IM用户[批量]" forKey:@"RESTType"];
    NSMutableArray* bodyArray = [NSMutableArray array];
    [bodyArray addObject:@{@"username": @"zy1", @"password": @"123456"}];
    [bodyArray addObject:@{@"username": @"zy2", @"password": @"123456"}];
    [bodyArray addObject:@{@"username": @"zy3", @"password": @"123456"}];
    [mutDic2 setObject:bodyArray forKey:@"HTTPBody"];
    
    [infos addObject:mutDic2];

 //    获取IM用户[单个] index [3]
    NSDictionary* dic3 = @{@"RESTType": @"获取IM用户[单个]", @"HTTPMethod": @"GET"};
    NSMutableDictionary* headerDic3 = [NSMutableDictionary dictionary];
    if (kSUD(@"access_token")) [headerDic3 setObject:[NSString stringWithFormat:@"Bearer %@", kSUD(@"access_token")] forKey:@"Authorization"];
    
    NSMutableDictionary* mutDic3 = [NSMutableDictionary dictionaryWithDictionary:dic3];
    [mutDic3 setObject:headerDic3 forKey:@"HTTPHeader"];
   
    [infos addObject:mutDic3];
    
//    获取IM用户[批量] index [4] 用mutDic3 实例化mutDic4 添加limit待人员数量
    NSMutableDictionary* mutDic4 = [NSMutableDictionary dictionaryWithDictionary:mutDic3];
    [mutDic4 setObject:@"获取IM用户[批量]" forKey:@"RESTType"];
    [mutDic4 setObject:@20 forKey:@"limit"];
    [infos addObject:mutDic4];
    
//    删除IM用户[单个] 同查询个人信息的一样，只是请求方式为DELETE 用mutDic3 实例化mutDic5
    NSMutableDictionary* mutDic5 = [NSMutableDictionary dictionaryWithDictionary:mutDic3];
    [mutDic5 setObject:@"删除IM用户[单个]" forKey:@"RESTType"];
    [mutDic5 setObject:@"DELETE" forKey:@"HTTPMethod"];
    [infos addObject:mutDic5];
    
    
//    删除IM用户[批量] 同批量查询的一样，只是请求方式为DELETE 用mutDic4 实例化mutDic6
    NSMutableDictionary* mutDic6 = [NSMutableDictionary dictionaryWithDictionary:mutDic4];
    [mutDic6 setObject:@"删除IM用户[批量]" forKey:@"RESTType"];
    [mutDic6 setObject:@"DELETE" forKey:@"HTTPMethod"];
    [mutDic6 setObject:@5 forKey:@"limit"];
    [infos addObject:mutDic6];
    
    
//    重置IM用户密码
    NSDictionary* dic7 = @{@"RESTType": @"重置IM用户密码", @"HTTPMethod": @"PUT"};
    NSMutableDictionary* mutDic7 = [NSMutableDictionary dictionaryWithDictionary:dic7];
    
    NSMutableDictionary* headerDic7 = [NSMutableDictionary dictionary];
    if (kSUD(@"access_token")) [headerDic7 setObject:[NSString stringWithFormat:@"Bearer %@", kSUD(@"access_token")] forKey:@"Authorization"];
    NSMutableDictionary* bodyDic7 = [NSMutableDictionary dictionary];
    [bodyDic7 setObject:@"111111" forKey:@"newpassword"];
    
    [mutDic7 setObject:headerDic7 forKey:@"HTTPHeader"];
    [mutDic7 setObject:bodyDic7 forKey:@"HTTPBody"];
    [infos addObject:mutDic7];
    
//    修改用户昵称 同重置密码一样，只是body里的参数换成nickname
    NSDictionary* dic8 = @{@"RESTType": @"修改用户昵称", @"HTTPMethod": @"PUT"};
    NSMutableDictionary* mutDic8 = [NSMutableDictionary dictionaryWithDictionary:dic8];
    NSMutableDictionary* headerDic8 = [NSMutableDictionary dictionary];
    if (kSUD(@"access_token")) [headerDic8 setObject:[NSString stringWithFormat:@"Bearer %@", kSUD(@"access_token")] forKey:@"Authorization"];
    
    NSMutableDictionary* bodyDic8 = [NSMutableDictionary dictionary];
    [bodyDic8 setObject:@"111111" forKey:@"nickname"];
    
    [mutDic8 setObject:bodyDic8 forKey:@"HTTPBody"];
    [mutDic8 setObject:headerDic8 forKey:@"HTTPHeader"];
    
    [infos addObject:mutDic8];
    
//    给IM用户的添加好友
    NSDictionary* dic9 = @{@"RESTType": @"给IM用户的添加好友", @"HTTPMethod": @"POST"};
    NSMutableDictionary* mutDic9 = [NSMutableDictionary dictionaryWithDictionary:dic9];
    NSMutableDictionary* headerDic9 = [NSMutableDictionary dictionary];
    if (kSUD(@"access_token")) [headerDic9 setObject:[NSString stringWithFormat:@"Bearer %@", kSUD(@"access_token")] forKey:@"Authorization"];
    [mutDic9 setObject:headerDic9 forKey:@"HTTPHeader"];
    [infos addObject:mutDic9];
    
//    解除IM用户的好友关系 同添加好友一样，只需要把请求方法改为 DELETE
    NSMutableDictionary* mutDic10 = [NSMutableDictionary dictionaryWithDictionary:mutDic9];
    [mutDic10 setObject:@"解除IM用户的好友关系" forKey:@"RESTType"];
    [mutDic10 setObject:@"DELETE" forKey:@"HTTPMethod"];
    
    [infos addObject:mutDic10];
    
//    查看好友
    NSMutableDictionary* mutDic11 = [self getCommonDic];
    [mutDic11 setObject:@"查看IM用户的好友" forKey:@"RESTType"];
    [mutDic11 setObject:@"GET" forKey:@"HTTPMethod"];
    [mutDic11 removeObjectForKey:@"HTTPBody"];//不用的字段要删除，否则异常
    [infos addObject:mutDic11];
    
//    获取IM用户的黑名单
    NSMutableDictionary* mutDic12 = [self getCommonDic];
    [mutDic12 setObject:@"获取IM用户的黑名单" forKey:@"RESTType"];
    [mutDic12 setObject:@"GET" forKey:@"HTTPMethod"];
    [mutDic12 removeObjectForKey:@"HTTPBody"];//不用的字段要删除，否则异常
    [infos addObject:mutDic12];
    
//    往IM用户的黑名单中加人
    NSMutableDictionary* mutDic13 = [self getCommonDic];
    [mutDic13 setObject:@"往IM用户的黑名单中加人" forKey:@"RESTType"];
    [mutDic13 setObject:@"POST" forKey:@"HTTPMethod"];
    [infos addObject:mutDic13];

//    从IM用户的黑名单中减人
    NSMutableDictionary* mutDic14 = [self getCommonDic];
    [mutDic14 setObject:@"从IM用户的黑名单中减人" forKey:@"RESTType"];
    [mutDic14 setObject:@"DELETE" forKey:@"HTTPMethod"];
    [mutDic14 removeObjectForKey:@"HTTPBody"];//不用的字段要删除，否则异常
    [infos addObject:mutDic14];
    
//    查看用户在线状态
    NSMutableDictionary* mutDic15 = [self getCommonDic];
    [mutDic15 setObject:@"查看用户在线状态" forKey:@"RESTType"];
    [mutDic15 setObject:@"GET" forKey:@"HTTPMethod"];
    [mutDic15 removeObjectForKey:@"HTTPBody"];//不用的字段要删除，否则异常
    [infos addObject:mutDic15];
    
//    查询离线消息数
    NSMutableDictionary* mutDic16 = [self getCommonDic];
    [mutDic16 setObject:@"查询离线消息数" forKey:@"RESTType"];
    [mutDic16 setObject:@"GET" forKey:@"HTTPMethod"];
    [mutDic16 removeObjectForKey:@"HTTPBody"];//不用的字段要删除，否则异常
    [infos addObject:mutDic16];
    
//    查询某条离线消息状态
    NSMutableDictionary* mutDic17 = [self getCommonDic];
    NSMutableDictionary* headerDic17 = [mutDic17 objectForKey:@"HTTPHeader"];
    [headerDic17 setObject:@"application/json" forKey:@"Content-Type"];
    [mutDic17 setObject:@"查询某条离线消息状态" forKey:@"RESTType"];
    [mutDic17 setObject:@"GET" forKey:@"HTTPMethod"];
    [mutDic17 removeObjectForKey:@"HTTPBody"];//不用的字段要删除，否则异常
    [infos addObject:mutDic17];
    
//    用户账号禁用
    NSMutableDictionary* mutDic18 = [self getCommonDic];
    NSMutableDictionary* headerDic18 = [mutDic18 objectForKey:@"HTTPHeader"];
    [headerDic18 setObject:@"application/json" forKey:@"Content-Type"];
    [mutDic18 setObject:@"用户账号禁用" forKey:@"RESTType"];
    [mutDic18 setObject:@"POST" forKey:@"HTTPMethod"];
    [mutDic18 removeObjectForKey:@"HTTPBody"];//不用的字段要删除，否则异常
    [infos addObject:mutDic18];
    
//    用户账号解禁
    NSMutableDictionary* mutDic19 = [self getCommonDic];
    NSMutableDictionary* headerDic19 = [mutDic18 objectForKey:@"HTTPHeader"];
    [headerDic19 setObject:@"application/json" forKey:@"Content-Type"];
    [mutDic19 setObject:@"用户账号解禁" forKey:@"RESTType"];
    [mutDic19 setObject:@"POST" forKey:@"HTTPMethod"];
    [mutDic19 removeObjectForKey:@"HTTPBody"];//不用的字段要删除，否则异常
    [infos addObject:mutDic19];
    
    return infos;
}

+(NSString*)getUrlPathByPathInfo:(NSDictionary*)pathInfo{
    NSString* middlePath = kSUD(@"AppKey") ? [kSUD(@"AppKey") stringByReplacingOccurrencesOfString:@"#" withString:@"/"] : @"";
    NSString* type = [pathInfo objectForKey:@"RESTType"];
    NSString* path = @"";
    if ([type isEqualToString:@"获取APP管理员Token"]) {
        path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/token", middlePath];
    }else if ([type isEqualToString:@"注册IM用户[单个]"]){
        path =[NSString stringWithFormat:@"https://a1.easemob.com/%@/users", middlePath];
    }else if ([type isEqualToString:@"注册IM用户[批量]"]){
        path =[NSString stringWithFormat:@"https://a1.easemob.com/%@/users", middlePath];
    }else if ([type isEqualToString:@"获取IM用户[单个]"]){
        path =[NSString stringWithFormat:@"https://a1.easemob.com/%@/users/", middlePath];
        if ([pathInfo objectForKey:@"username"]) //拼接用户名字
            path = [path stringByAppendingString:[pathInfo objectForKey:@"username"]];
        
    }else if ([type isEqualToString:@"获取IM用户[批量]"]){
        if ([pathInfo objectForKey:@"limit"])
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users?limit=%ld", middlePath,(long)[[pathInfo objectForKey:@"limit"] integerValue]];
        
    }else if ([type isEqualToString:@"删除IM用户[单个]"]){
        path =[NSString stringWithFormat:@"https://a1.easemob.com/%@/users/", middlePath];
        if ([pathInfo objectForKey:@"username"]) //拼接用户名字
            path = [path stringByAppendingString:[pathInfo objectForKey:@"username"]];
        
    }else if ([type isEqualToString:@"删除IM用户[批量]"]){
        if ([pathInfo objectForKey:@"limit"])
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users?limit=%ld", middlePath,(long)[[pathInfo objectForKey:@"limit"] integerValue]];
    
    }else if ([type isEqualToString:@"重置IM用户密码"]){
        if ([pathInfo objectForKey:@"username"])
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/password", middlePath, [pathInfo objectForKey:@"username"]];
        
    }else if ([type isEqualToString:@"修改用户昵称"]){
        path =[NSString stringWithFormat:@"https://a1.easemob.com/%@/users/", middlePath];
        if ([pathInfo objectForKey:@"username"]) //拼接用户名字
            path = [path stringByAppendingString:[pathInfo objectForKey:@"username"]];
    }else if ([type isEqualToString:@"给IM用户的添加好友"]){

        if ([pathInfo objectForKey:@"username"] && [pathInfo objectForKey:@"friend"]) {
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/contacts/users/%@", middlePath, [pathInfo objectForKey:@"username"], [pathInfo objectForKey:@"friend"]];
        }
        
    }else if ([type isEqualToString:@"解除IM用户的好友关系"]){
        if ([pathInfo objectForKey:@"username"] && [pathInfo objectForKey:@"friend"]) {
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/contacts/users/%@", middlePath, [pathInfo objectForKey:@"username"], [pathInfo objectForKey:@"friend"]];
        }
        
    }else if ([type isEqualToString:@"查看IM用户的好友"]){
        if ([pathInfo objectForKey:@"username"]) {
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/contacts/users", middlePath, [pathInfo objectForKey:@"username"]];
        }
    }else if ([type isEqualToString:@"获取IM用户的黑名单"]){
        if ([pathInfo objectForKey:@"username"]) {
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/blocks/users", middlePath, [pathInfo objectForKey:@"username"]];
        }
        

    }else if ([type isEqualToString:@"往IM用户的黑名单中加人"]){
         if ([pathInfo objectForKey:@"username"])
             path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/blocks/users", middlePath, [pathInfo objectForKey:@"username"]];
        
    }else if ([type isEqualToString:@"从IM用户的黑名单中减人"]){
        if ([pathInfo objectForKey:@"username"] && [pathInfo objectForKey:@"deleteUser"])
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/blocks/users/%@", middlePath, [pathInfo objectForKey:@"username"], [pathInfo objectForKey:@"deleteUser"]];
        
    }else if ([type isEqualToString:@"查看用户在线状态"]){
        if ([pathInfo objectForKey:@"username"])
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/status", middlePath, [pathInfo objectForKey:@"username"]];
        
    }else if ([type isEqualToString:@"查询离线消息数"]){
        if ([pathInfo objectForKey:@"username"])
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/offline_msg_count", middlePath, [pathInfo objectForKey:@"username"]];
        
    }else if ([type isEqualToString:@"查询某条离线消息状态"]){
        if ([pathInfo objectForKey:@"username"] && [pathInfo objectForKey:@"messageID"]) {
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/offline_msg_status/%@", middlePath, [pathInfo objectForKey:@"username"] , [pathInfo objectForKey:@"messageID"]];
        }
    }else if ([type isEqualToString:@"用户账号禁用"]){
        if ([pathInfo objectForKey:@"username"])
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/deactivate", middlePath, [pathInfo objectForKey:@"username"]];
        
    }else if ([type isEqualToString:@"用户账号解禁"]){
        if ([pathInfo objectForKey:@"username"])
            path = [NSString stringWithFormat:@"https://a1.easemob.com/%@/users/%@/activate", middlePath, [pathInfo objectForKey:@"username"]];
    }else{
        
    }
    
    return path;
}

@end
