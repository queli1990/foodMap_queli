//
//  NoDataView.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/12.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _requestBtn.frame = CGRectMake(100, 100, 100, 100);
        [_requestBtn setTitle:@"再来一次" forState:UIControlStateNormal];
        [_requestBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self addSubview:_requestBtn];
        
        self.backgroundColor = [UIColor clearColor];
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
