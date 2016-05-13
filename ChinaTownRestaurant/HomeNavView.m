//
//  ChinaTownHomeNavView.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeNavView.h"
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//#define UIColorFromRGB(rgbValue,alhpaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alhpaValue]

@implementation HomeNavView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat leftGap = 10;
        
        //左边的城市相关控件
        self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftGap, 20+(44-15)/2, 50, 15)];
        _cityLabel.font = [UIFont systemFontOfSize:16.0];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        _cityLabel.textColor = UIColorFromRGB(0xffffff, 1.0);
        
        _cityImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cityLabel.frame), 20+(44-11)/2, 11, 11)];
        _cityImgView.image = [[UIImage imageNamed:@"ArrowDown"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _cityImgView.userInteractionEnabled = YES;
        
        self.cityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(_cityImgView.frame), 64)];
        [_cityView addSubview:_cityImgView];
        [_cityView addSubview:_cityLabel];
        [self addSubview:_cityView];
        
        
        //右边的个人按钮
        _personalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _personalBtn.frame = CGRectMake(ScreenWidth-15-28, 20+(44-28)/2, 28, 28);
        [_personalBtn setImage:[UIImage imageNamed:@"personal"] forState:UIControlStateNormal];
        [self addSubview:_personalBtn];
        
        
        //添加中间的搜索相关控件
        CGFloat margin = 0;
        if (ScreenWidth == 320) {
            margin = (ScreenWidth-_cityView.frame.size.width-470*0.4-28-15)/2;
            _searchView = [[UIImageView alloc] initWithFrame:CGRectMake(margin+CGRectGetMaxX(_cityView.frame), 20+(44-68*0.4)/2, 470*0.4, 68*0.4)];
        }else{
            margin = (ScreenWidth-_cityView.frame.size.width-470*0.5-28-15)/2;
            _searchView = [[UIImageView alloc] initWithFrame:CGRectMake(margin+CGRectGetMaxX(_cityView.frame), 20+(44-68*0.5)/2, 470*0.5, 68*0.5)];
        }
        _searchView.userInteractionEnabled = YES;
        _searchView.image = [[UIImage imageNamed:@"searchBg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
//        _searchView.layer.masksToBounds = YES;
//        _searchView.layer.borderWidth = 1.0;
//        _searchView.layer.borderColor = [UIColor whiteColor].CGColor;
//        _searchView.layer.cornerRadius = 14.0;
//        _searchView.backgroundColor = [UIColor cyanColor];
        
        
        _searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, (_searchView.frame.size.height-15)/2, 15, 15)];
        _searchImgView.image = [UIImage imageNamed:@"Magnifier"];
        
        
        _searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_searchImgView.frame)+7, (_searchView.frame.size.height-30)/2, _searchView.frame.size.width-_searchImgView.frame.size.width-20, 30)];
        _searchLabel.font = [UIFont systemFontOfSize:16.0];
        _searchLabel.backgroundColor = [UIColor clearColor];
        _searchLabel.textAlignment = NSTextAlignmentLeft;
        _searchLabel.text = @"输入商户名、地点";
        _searchLabel.textColor = UIColorFromRGB(0xffffff, 0.6);
        _searchView.userInteractionEnabled = YES;
        [_searchView addSubview:_searchImgView];
        [_searchView addSubview:_searchLabel];
        [self addSubview:_searchView];
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
