//
//  ZYAlertView.h
//  oppein
//
//  Created by yuhailong on 15-4-17.
//  Copyright (c) 2015年 sagacity. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertBlock)(NSString* alertText);
@interface ZYAlertView : UIView

@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, copy) NSString* text;
-(void)showInView:(UIView *)view;
@end
