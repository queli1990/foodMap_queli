//
//  ChinaTownDetailNavView.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/11.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "DetailNavView.h"

@implementation DetailNavView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = UIColorFromRGB(0xffb300, 1.0);
        self.backgroundColor = [UIColor blackColor];
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(15, 20+(44-44*0.5)/2, 50, 44*0.5);
        [_backBtn setImage:[UIImage imageNamed:@"Detail_leftArrow"] forState:UIControlStateNormal];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, (50-26*0.5));
        [self addSubview:_backBtn];
        
        self.collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectionBtn.frame = CGRectMake(ScreenWidth-27-15, 20+(44-27)/2, 27, 27);
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"Detail_CollectionNormal"] forState:UIControlStateNormal];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"Detail_CollectionSelected"] forState:UIControlStateHighlighted];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"Detail_CollectionSelected"] forState:UIControlStateSelected];
        [self addSubview:_collectionBtn];
        
        
        self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(ScreenWidth-20-15-20-15, _collectionBtn.frame.origin.y, 20, 20);
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Detail_CollectionNormal"] forState:UIControlStateNormal];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Detail_CollectionHeighted"] forState:UIControlStateHighlighted];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Detail_CollectionSelected"] forState:UIControlStateSelected];
        [self addSubview:_shareBtn];
        
        self.chineseTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/4, 20+(44-20)/2, ScreenWidth/2, 20)];
        _chineseTitleLabel.textAlignment = NSTextAlignmentCenter;
        _chineseTitleLabel.textColor = UIColorFromRGB(0xffffff, 1.0);
        _chineseTitleLabel.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:_chineseTitleLabel];
        
        self.englishTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_chineseTitleLabel.frame.origin.x, 20+5+20+4, _chineseTitleLabel.frame.size.width, 10)];
        _englishTitleLabel.textColor = [UIColor whiteColor];
        _englishTitleLabel.textAlignment = NSTextAlignmentCenter;
        _englishTitleLabel.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:_englishTitleLabel];
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
