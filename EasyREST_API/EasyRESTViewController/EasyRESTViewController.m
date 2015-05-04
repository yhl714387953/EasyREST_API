//
//  EasyRESTViewController.m
//  EasyREST_API
//
//  Created by yuhailong on 15-5-3.
//  Copyright (c) 2015年 zuiye. All rights reserved.
//

#import "EasyRESTViewController.h"

@interface EasyRESTViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* dataSouces;

@end

@implementation EasyRESTViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"REST API 方法";
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - getter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

-(NSMutableArray *)dataSouces{
    if (!_dataSouces) {
        _dataSouces = [NSMutableArray arrayWithArray:[EaseInfoManager getAllRequstInfo]];
    }
    
    return _dataSouces;
}



#pragma mark - UITableViewDataSource, UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSouces.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    
    NSDictionary* dic = self.dataSouces[indexPath.row];
    NSString* title = [dic objectForKey:@"RESTType"];
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* dic = self.dataSouces[indexPath.row];
    NSString* title = [dic objectForKey:@"RESTType"];
    NSString* message = @"";
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alertView.tag = indexPath.row;
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            [alertView textFieldAtIndex:1].placeholder = @"输入密码";
            break;
        case 2:
            alertView.title = @"此功能待完善，可直接在程序内控制，默认添加三个人";
            break;
        case 3:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入查询用户ID";
            break;
        case 4:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入查询用户个数";
            [[alertView textFieldAtIndex:0] setKeyboardType:(UIKeyboardTypeNumberPad)];
            break;
        case 5:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入删除用户ID";
            break;
        case 6:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入删除用户个数";
            [[alertView textFieldAtIndex:0] setKeyboardType:(UIKeyboardTypeNumberPad)];
            break;
        case 7:
            alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            break;
        case 8:
            alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            [alertView textFieldAtIndex:1].placeholder = @"输入用户昵称";
            [alertView textFieldAtIndex:1].secureTextEntry = NO;
            break;
        case 9:
            alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            [alertView textFieldAtIndex:1].placeholder = @"输入好友ID";
            [alertView textFieldAtIndex:1].secureTextEntry = NO;
            break;
        case 10:
            alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            [alertView textFieldAtIndex:1].placeholder = @"输入待解除好友ID";
            [alertView textFieldAtIndex:1].secureTextEntry = NO;
            
            break;
        case 11:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            break;
        case 12:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            break;
        case 13:
            alertView.title = @"此功能待完善，可直接在程序内控制，默认添加两个人";
            break;
        case 14:
            alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            [alertView textFieldAtIndex:1].placeholder = @"输入待解黑名单ID";
            [alertView textFieldAtIndex:1].secureTextEntry = NO;
            break;
        case 15:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            break;
        case 16:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            break;
        case 17:
            alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入用户ID";
            [alertView textFieldAtIndex:1].placeholder = @"输入消息ID";
            [alertView textFieldAtIndex:1].secureTextEntry = NO;
            break;
        case 18:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入禁用用户ID";
            break;
        case 19:
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].placeholder = @"输入解禁用户ID";
            break;
            
        default:
            break;
    }
    
    [alertView show];
}

#pragma mark - Action
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertWithTitle:(NSString*)title{
    ZYAlertView* alertView = [[ZYAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.text = title;
    [alertView  showInView:self.navigationController.view];
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([[alertView textFieldAtIndex:0].text isEqualToString:@""] || [[alertView textFieldAtIndex:0].text isEqualToString:@""]) {
//        如果文本框不输入任何东西，那么不执行操作
        return;
    }
    
    switch (alertView.tag) {
        case 0:
        {
            [[EaseNetManager sharedManager] getTokenWithBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }

            break;
        case 1:
        {
            
            [[EaseNetManager sharedManager] registUserWithUserInfo:@{@"username": [alertView textFieldAtIndex:0].text, @"password": [alertView textFieldAtIndex:1].text, @"nickname":@""} block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
                
            }];
        }
            break;
        case 2:
        {
            NSMutableArray* users =[NSMutableArray array];
            [users addObject:@{@"username": @"zy11", @"password": @"123456"}];
            [users addObject:@{@"username": @"zy12", @"password": @"123456"}];
            [users addObject:@{@"username": @"zy13", @"password": @"123456"}];
            
            [[EaseNetManager sharedManager] registMoreUsersWithUserInfos:users block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            
            break;
        case 3:
        {
            [[EaseNetManager sharedManager] getUserInfoByRegistID:[alertView textFieldAtIndex:0].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        case 4:
        {
            [[EaseNetManager sharedManager] getMoreUserInfosWithlimit:[[alertView textFieldAtIndex:0].text integerValue] WithBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
        case 5:
        {
            [[EaseNetManager sharedManager] deleteUserByRegistID:[alertView textFieldAtIndex:0].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            
            break;
        case 6:
        {
            [[EaseNetManager sharedManager] deleteUsersByLimit:[[alertView textFieldAtIndex:0].text integerValue] block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        case 7:
        {
            [[EaseNetManager sharedManager] resetUserPasswordWithUserName:[alertView textFieldAtIndex:0].text withNewPassword:[alertView textFieldAtIndex:1].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
            
        }
            break;
            
        case 8:
        {
            [[EaseNetManager sharedManager] changeUserNickNameWithUserName:[alertView textFieldAtIndex:0].text withNickName:[alertView textFieldAtIndex:1].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        case 9:
        {
            [[EaseNetManager sharedManager] addFriendToUser:[alertView textFieldAtIndex:0].text withFriend:[alertView textFieldAtIndex:1].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        case 10:
        {
            [[EaseNetManager sharedManager] relieveFriendToUser:[alertView textFieldAtIndex:0].text withFriend:[alertView textFieldAtIndex:1].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        case 11:
        {
            [[EaseNetManager sharedManager] getUserFriendByUserName:[alertView textFieldAtIndex:0].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        case 12:
        {
            [[EaseNetManager sharedManager] getBlackListByUserName:[alertView textFieldAtIndex:0].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        case 13:
        {
            [[EaseNetManager sharedManager] addBlacklistToUser:@"zy11" withUsernames:@[@"zy12", @"zy13"] block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
        case 14:
        {
            [[EaseNetManager sharedManager] deleteBlaclistUserFromUser:[alertView textFieldAtIndex:0].text withDeleteUser:[alertView textFieldAtIndex:1].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
        case 15:
        {
            [[EaseNetManager sharedManager] getOnlineStateWithUser:[alertView textFieldAtIndex:0].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            
            break;
        case 16:
        {
            [[EaseNetManager sharedManager] getOffLineMessageCountByUser:[alertView textFieldAtIndex:0].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            
            break;
            
        case 17:
        {
            [[EaseNetManager sharedManager] getOffLineMessageStateWithUser:[alertView textFieldAtIndex:0].text andMessageID:[alertView textFieldAtIndex:1].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        case 18:
        {
            [[EaseNetManager sharedManager] forbinUser:[alertView textFieldAtIndex:0].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        case 19:
        {
            [[EaseNetManager sharedManager] unForbinUser:[alertView textFieldAtIndex:0].text block:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:kJsonString(data)];
                });
            }];
        }
            break;
            
        default:
            break;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
