//
//  NoResultView.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/19.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "NoResultView.h"

@implementation NoResultView

- (instancetype) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.noResultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-40)];
        _noResultImageView.image = [UIImage imageNamed:@""];
        [self addSubview:_noResultImageView];
        
        self.noResultLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
        _noResultLabel.text = @"没有您想要的搜索结果";
        _noResultLabel.textColor = [UIColor whiteColor];
        _noResultLabel.font = [UIFont systemFontOfSize:16.0];
        _noResultLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_noResultLabel];
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
