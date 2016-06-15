//
//  HomeHeadButton.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/25.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeHeadButton.h"

@implementation HomeHeadButton

//文字的绘制区域
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGRect rect = CGRectMake(contentRect.origin.x, contentRect.size.height * 0.9, contentRect.size.width, contentRect.size.height * 0.1);
    return rect;
}

//图片的绘制区域
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect rect = CGRectMake(contentRect.origin.x, contentRect.size.height * 0.0, contentRect.size.width, contentRect.size.height * 0.75);
    return rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
