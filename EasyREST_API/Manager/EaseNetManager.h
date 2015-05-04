//
//  EaseNetManager.h
//  testHUD
//
//  Created by yuhailong on 15-5-3.
//  Copyright (c) 2015年 zuiye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import "JSONKit.h"
#import "EaseInfoManager.h"

typedef void (^EaseNetBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);

@interface EaseNetManager : NSObject
+(instancetype)sharedManager;
@property (nonatomic, strong) NSOperationQueue* queue;

//获取APP管理员Token
-(void)getTokenWithBlock:(EaseNetBlock)complation;

//注册IM用户[单个]
-(void)registUserWithUserInfo:(NSDictionary*)userInfo block:(EaseNetBlock)complation;

//注册IM用户[批量]
-(void)registMoreUsersWithUserInfos:(NSArray*)userInfos block:(EaseNetBlock)complation;

//获取IM用户[单个]
-(void)getUserInfoByRegistID:(NSString*)registID block:(EaseNetBlock)complation;

//批量获取用户
-(void)getMoreUserInfosWithlimit:(NSInteger)limit WithBlock:(EaseNetBlock)complation;

//删除IM用户[单个]
-(void)deleteUserByRegistID:(NSString*)registID block:(EaseNetBlock)complation;

//删除IM用户[批量]
-(void)deleteUsersByLimit:(NSInteger)limit block:(EaseNetBlock)complation;

//重置IM用户密码
-(void)resetUserPasswordWithUserName:(NSString*)userName withNewPassword:(NSString*)password block:(EaseNetBlock)complation;

//修改用户昵称
-(void)changeUserNickNameWithUserName:(NSString*)userName withNickName:(NSString*)nickName block:(EaseNetBlock)complation;

//给IM用户的添加好友
-(void)addFriendToUser:(NSString*)userName withFriend:(NSString*)friendName block:(EaseNetBlock)complation;

//解除IM用户的好友关系
-(void)relieveFriendToUser:(NSString*)userName withFriend:(NSString*)friendName block:(EaseNetBlock)complation;

//查看IM用户的好友
-(void)getUserFriendByUserName:(NSString*)userName block:(EaseNetBlock)complation;

//获取IM用户的黑名单
-(void)getBlackListByUserName:(NSString*)userName block:(EaseNetBlock)complation;

//往IM用户的黑名单中加人
-(void)addBlacklistToUser:(NSString*)userName withUsernames:(NSArray*)usernames block:(EaseNetBlock)complation;

//从IM用户的黑名单中减人
-(void)deleteBlaclistUserFromUser:(NSString*)userName withDeleteUser:(NSString*)deleteUser block:(EaseNetBlock)complation;

//查看用户在线状态
-(void)getOnlineStateWithUser:(NSString*)userName block:(EaseNetBlock)complation;

//查询离线消息数
-(void)getOffLineMessageCountByUser:(NSString*)userName block:(EaseNetBlock)complation;

//查询某条离线消息状态
-(void)getOffLineMessageStateWithUser:(NSString*)userName andMessageID:(NSString*)messageID block:(EaseNetBlock)complation;

//用户账号禁用
-(void)forbinUser:(NSString*)userName block:(EaseNetBlock)complation;

//用户账号解禁
-(void)unForbinUser:(NSString*)userName block:(EaseNetBlock)complation;

@end
