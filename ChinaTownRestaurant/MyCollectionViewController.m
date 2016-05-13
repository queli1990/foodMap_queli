//
//  MyCollectionViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/6.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface MyCollectionViewController ()
@property (nonatomic,strong) UIView *navView;
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    
    
}

- (void) setNav{
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor = [UIColor blackColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 20, 50, 44);
    [btn setImage:[UIImage imageNamed:@"ArrowLeft"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"ArrowLeft"] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(12, 15, 12, 25);//高20，宽10
    [btn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:btn];
    
    UILabel *titleLabe = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-(ScreenWidth-100))/2, 20+(44-30)/2, ScreenWidth-100, 30)];
    titleLabe.font = [UIFont systemFontOfSize:20.0];
    titleLabe.textColor = [UIColor whiteColor];
    titleLabe.textAlignment = NSTextAlignmentCenter;
    titleLabe.text = @"我的收藏";
    [_navView addSubview:titleLabe];
    
    [self.view addSubview:_navView];
}

- (void) backToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
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
