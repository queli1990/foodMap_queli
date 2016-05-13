//
//  LoginOrRegistNav.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/6.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "LoginOrRegistNav.h"

@implementation LoginOrRegistNav

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(15, 20+(44-49*0.5)/2, 50, 49*0.5);
        [_backBtn setImage:[UIImage imageNamed:@"ArrowLeft"] forState:UIControlStateNormal];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, (50-28*0.5));
        [self addSubview:_backBtn];
        
        CGFloat with = (ScreenWidth-(15+50)*2)/2;
        
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(CGRectGetMaxX(_backBtn.frame), _backBtn.frame.origin.y, with, _backBtn.frame.size.height);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [self addSubview:_loginBtn];
        
        self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registBtn.frame = CGRectMake(CGRectGetMaxX(_loginBtn.frame), _backBtn.frame.origin.y, with, _backBtn.frame.size.height);
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [self addSubview:_registBtn];
        
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
