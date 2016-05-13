//
//  BaseNavigationController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/4.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //获取系统自带手势的target对象
    id target=self.interactivePopGestureRecognizer.delegate;
    
    //创建全屏手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    //设置手势代理，拦截手势触发
    pan.delegate=self;
    //给导航控制器的View添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    //禁止系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled=NO;
}

//什么时候调用：每次触发之前都会询问下代理，是否触发
//作用：拦截手势触发
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //注意：只有非根控制器才有滑动返回功能，根控制器没有
    //判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if(self.childViewControllers.count==1)
    {
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
