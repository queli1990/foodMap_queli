//
//  ChinaTownDetailCategoryAndEnvironmentView.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/11.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCategoryAndEnvironmentView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIButton *categoryBtn;//菜品
@property (nonatomic,strong) UIButton *environmentBtn;//环境
@property (nonatomic,strong) UIView *separateLineView;//分割线


//@property (nonatomic, strong) UIPageControl *pageControl; // 页码指示器
//@property (nonatomic,strong) UIScrollView *scrollView;
//@property (nonatomic,strong) UIView *showView;
//@property (nonatomic) BOOL isShow;


//- (void) addScrollView:(NSArray *)array;

@end
