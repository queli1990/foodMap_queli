//
//  ChooseBtn.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ChooseBtn.h"

@implementation ChooseBtn

- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.text = @"全部";
        UIFont *font = [UIFont fontWithName:@"Arial" size:16.0];
        _subTitleLabel.font = font;
        CGSize labelSize = [_subTitleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
        _subTitleLabel.frame = CGRectMake((self.frame.size.width-10-labelSize.width-20)/2, 10, labelSize.width, 20);
        _subTitleLabel.textColor = [UIColor blackColor];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subTitleLabel];
        
        
        _arrowImgView = [[UIImageView alloc] init];
        _arrowImgView.frame = CGRectMake(CGRectGetMaxX(_subTitleLabel.frame)+5, (40-15)/2, 15, 15);
        _arrowImgView.image = [UIImage imageNamed:@"TVLog"];
        [self addSubview:_arrowImgView];
        
        
        _lineImgView = [[UIImageView alloc] initWithFrame:self.frame];
        _lineImgView.image = [UIImage imageNamed:@""];
        [self addSubview:_lineImgView];
        
        self.showView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-1, 10, 1, 20)];
        _showView.backgroundColor = [UIColor grayColor];
        [self addSubview:_showView];
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
