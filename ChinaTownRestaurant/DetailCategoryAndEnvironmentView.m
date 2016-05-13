//
//  ChinaTownDetailCategoryAndEnvironmentView.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/11.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "DetailCategoryAndEnvironmentView.h"

@implementation DetailCategoryAndEnvironmentView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _categoryBtn.frame = CGRectMake(15, 5, 40, 30);
        [_categoryBtn setTitle:@"菜品" forState:UIControlStateNormal];
        [_categoryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_categoryBtn];
        
        self.environmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _environmentBtn.frame = CGRectMake(70, 5, 40, 30);
        [_environmentBtn setTitle:@"环境" forState:UIControlStateNormal];
        [_environmentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_environmentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_environmentBtn];
        
        self.separateLineView = [[UIView alloc] initWithFrame:CGRectMake(59, 10, 1, 20)];
        _separateLineView.backgroundColor = [UIColor grayColor];
        [self addSubview:_separateLineView];
        
    }
    return self;
}






@end
