//
//  ImgBtnClick.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/11.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ImgBtnClick.h"

@implementation ImgBtnClick

- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self addSubview:_imgView];
        
        self.clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.frame = CGRectMake(0, 0, 20, 20);
        [self addSubview:_clickBtn];
        
//        _clickBtn addTarget:self action:nil forControlEvents:<#(UIControlEvents)#>
//        
//        if (_clickBtn.highlighted) {
//            
//        }
        
    }
    return self;
}

@end
