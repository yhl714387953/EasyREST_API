//
//  ZYAlertView.m
//  oppein
//
//  Created by yuhailong on 15-4-17.
//  Copyright (c) 2015年 sagacity. All rights reserved.
//

#import "ZYAlertView.h"

@implementation ZYAlertView
{
    UIView* _backView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 150)];
    _backView = backView;
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    backView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    [self addSubview:backView];
    
//    textField
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 270, 100)];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.editable = NO;//不可编辑，但是可以复制等其他操作
    [backView addSubview:self.textView];
    self.textView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
 
    UIButton* button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0, _backView.frame.size.height - 45, 290, 45);
    
    //        文字属性
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button setTintColor:[UIColor colorWithRed:1 green:127 / 255.0 blue:0 alpha:1]];
    [button setTitle:@"确定" forState:(UIControlStateNormal)];
    
    //        事件
    [button addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [backView addSubview:button];
    
}

-(void)showInView:(UIView *)view{
    
    [view addSubview:self];
    
    self.alpha = 0;
    _backView.transform = CGAffineTransformScale(_backView.transform, 1.2, 1.2);
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        _backView.transform = CGAffineTransformScale(_backView.transform, 1 / 1.2, 1 / 1.2);
    }];
}

-(void)clicked:(UIButton*)sender{
    sender.backgroundColor = [UIColor whiteColor];

    [self hide];
}

-(void)hide{
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)setText:(NSString *)text{
    _text = text;
    self.textView.text = text;
    NSLog(@"textView.text:%@",self.textView.text);
 
   CGFloat height = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, 0)].height;
    NSLog(@"%f", height);
    
    CGRect frame = _backView.frame;
    frame.size.height = height + 45;
    if (frame.size.height > 400) {
        frame.size.height = 400;//最多不能超过四百
    }
    
    _backView.frame = frame;
    _backView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
}

-(void)dealloc{
    NSLog(@"销毁了");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
