//
//  ChinaTownListNavView.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "RecommendListNavView.h"

@implementation RecommendListNavView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(15, 20+(44-49*0.4)/2, 50, 49*0.4);
        [_backBtn setImage:[UIImage imageNamed:@"ArrowLeft"] forState:UIControlStateNormal];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, (50-28*0.4));
        [self addSubview:_backBtn];
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(ScreenWidth-15-20, 20+(44-20)/2, 20, 20);
        [_searchBtn setImage:[UIImage imageNamed:@"Magnifier"] forState:UIControlStateNormal];
        [self addSubview:_searchBtn];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_backBtn.frame), 20+(44-30)/2, ScreenWidth-15-CGRectGetMaxX(_backBtn.frame)-_backBtn.frame.size.width, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
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
