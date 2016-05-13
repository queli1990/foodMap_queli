//
//  ViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/7.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ViewController.h"
#import "HomeController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl; // 页码指示器
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initGuide];

    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
   
}


- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

- (void) initGuide{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scrollView.backgroundColor = [UIColor darkGrayColor];
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
    for (int i = 0; i < self.count; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Guide%d", i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        imageView.image = image;
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
        if (i == self.count-1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];//在imageview3上加载一个透明的button
            
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            
            [button setFrame:CGRectMake((ScreenWidth-180)/2, ScreenHeight-100, 180, 60)];
            
            [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
            
            [imageView addSubview:button];
            
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = button.frame.size.width/2;
            
            button.backgroundColor =[UIColor clearColor];
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*self.count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    // pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(scrollView.frame.origin.x, ScreenHeight-40, scrollView.frame.size.width, 40)];
    self.pageControl.numberOfPages = self.count; // 有多少个指示小圆点
    self.pageControl.backgroundColor = [UIColor clearColor];
    
//    [self.pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}

- (void)firstpressed{
    HomeController *vc = [[HomeController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFirstLogin"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
