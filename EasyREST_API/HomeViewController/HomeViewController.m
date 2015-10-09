//
//  HomeViewController.m
//  testHUD
//
//  Created by yuhailong on 15-5-3.
//  Copyright (c) 2015年 zuiye. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *AppKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *client_idTextField;
@property (weak, nonatomic) IBOutlet UITextField *client_secretTextField;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"REST API";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)next:(UIButton *)sender {
    [self.view endEditing:YES];
//    这里直接填写你的信息
//    self.AppKeyTextField.text = @"polystor-1#oppein";
//    self.client_idTextField.text = @"YXA6-bfa0NgbEeShfD2m51Vnug";
//    self.client_secretTextField.text = @"YXA67Doo71CoYhckXPEmUYVzAbLkfsk";
    
    self.AppKeyTextField.text = @"gyyys#yunhaiqiaodev";
    self.client_idTextField.text = @"YXA6aBE-wOjbEeSbvOfBpCG12g";
    self.client_secretTextField.text = @"YXA6bYKy1fioM5ULhuqWwJOA6MYa33g";
    
    
    if ([self.AppKeyTextField.text isEqualToString:@""] || [self.client_idTextField.text isEqualToString:@""] || [self.client_secretTextField.text isEqualToString:@""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请填写完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }

//    保存下信息
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:self.AppKeyTextField.text forKey:@"AppKey"];
    [dic setObject:self.client_idTextField.text forKey:@"client_id"];
    [dic setObject:self.client_secretTextField.text forKey:@"client_secret"];
    [EaseInfoManager saveAPPEaseInfo:dic];
    
    sender.enabled = NO;
    [[EaseNetManager sharedManager] getTokenWithBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        sender.enabled = YES;
        if (data) {
            NSDictionary* jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if ([jsonDic objectForKey:@"access_token"] && ![[jsonDic objectForKey:@"access_token"] isEqualToString:@""]) {
                EasyRESTViewController* vc = [[EasyRESTViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    
    }];
    

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
