//
//  AppDelegate.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/7.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import <MAMapKit/MAMapKit.h>
#import "ViewController.h"

#import "BaseNavigationController.h"

@interface AppDelegate ()<MAMapViewDelegate>
@property (nonatomic,strong) NSUserDefaults *user;
@end

@implementation AppDelegate{
    MAMapView *_mapView;
    UIImageView *bgImageView;
    UIImageView *maskImageView;
    CGFloat second;
    NSTimer *timer;
}


//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)taped{
//    NSTimer *timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(dismissAnimate) userInfo:nil repeats:YES];
//    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(dismissAnimate) userInfo:nil repeats:YES];
    [self performSelector:@selector(dismissAnimate) withObject:nil afterDelay:3.0f];
    
    self.window.userInteractionEnabled = NO;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animation];
    scaleAnim.keyPath = @"transform.scale";
    scaleAnim.fillMode = kCAFillModeForwards;
    scaleAnim.removedOnCompletion = NO;
    scaleAnim.toValue = [NSNumber numberWithFloat:0.8f];
    scaleAnim.duration = 2;
    [bgImageView.layer addAnimation:scaleAnim forKey:nil];
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animation];
    opacityAnim.keyPath = @"opacity";
    opacityAnim.fillMode = kCAFillModeForwards;
    opacityAnim.removedOnCompletion = NO;
    opacityAnim.toValue = [NSNumber numberWithFloat:1.0f];
    opacityAnim.duration = 2;
    [maskImageView.layer addAnimation:opacityAnim forKey:nil];
}

- (void) dismissAnimate{
//    second += 0.05;
//    
//    if (second >2.0) {
    self.window.userInteractionEnabled = YES;
        maskImageView.hidden = YES;
        bgImageView.hidden = YES;
//        [timer invalidate];
//        timer = nil;
//    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [MAMapServices sharedServices].apiKey = @"553455c7719b74903c1cacdd7ba53579";
    _mapView = [[MAMapView alloc] init];
    _mapView.showsUserLocation = YES;//显示用户信息
    
    _user = [NSUserDefaults standardUserDefaults];
    [self requestLocation];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"11" forKey:@"isFirstLogin"];//为了测试首次的启动页
    
    NSString *isFirstLogin = [_user objectForKey:@"isFirstLogin"];
    if ([isFirstLogin isEqualToString:@"NO"]) {
        HomeController *vc = [[HomeController alloc] init];
//        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }else{
        ViewController *vc = [[ViewController alloc] init];
        vc.count = 6;
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }
    
    [self.window makeKeyAndVisible];
    
    
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 1.25, ScreenHeight * 1.25)];
    bgImageView.image = [UIImage imageNamed:@"GuideClearBg"];
//    if (ScreenHeight == 480) {
//        bgImageView.image = [UIImage imageNamed:@"GuideClearBg_640-960"];
//    }else if (ScreenHeight == 568){
//        bgImageView.image = [UIImage imageNamed:@"GuideClearBg_640-1136"];
//    }else if (ScreenHeight == 667){
//        bgImageView.image = [UIImage imageNamed:@"GuideClearBg_750-1134"];
//    }else{
//        bgImageView.image = [UIImage imageNamed:@"GuideClearBg_1242-2208"];
//    }
    
    bgImageView.center = self.window.center;
    [self.window addSubview:bgImageView];
    
    maskImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskImageView.backgroundColor = UIColorFromRGB(0x221F17, 1.0);
//    maskImageView.image = [UIImage imageNamed:@"GuideDimBg.png"];//背景图片用颜色代替
    maskImageView.layer.opacity = 0.0f;
    [self.window addSubview:maskImageView];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 99, 160)];
    titleImageView.image = [UIImage imageNamed:@"GuideMap.png"];
    titleImageView.center = CGPointMake(ScreenWidth / 2.0f, 200);
    [maskImageView addSubview:titleImageView];
    
    UIImageView *pathImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 276, 96)];
    pathImageView.image = [UIImage imageNamed:@"GuideLine.png"];
    pathImageView.center = CGPointMake(ScreenWidth /2.0f, 450);
    [maskImageView addSubview:pathImageView];
    
    [self taped];
    return YES;
}

//请求地理位置
- (void) requestLocation{
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    
    if (_locationManager.location.coordinate.longitude == 0) {
        return;
    }
    
    NSString *loactionStr = [NSString stringWithFormat:@"http://maps.google.cn/maps/api/geocode/json?latlng=%f,%f&language=CN",_locationManager.location.coordinate.latitude,_locationManager.location.coordinate.longitude];//当前位置
    
    //测试数据
//    NSString *loactionStr = [NSString stringWithFormat:@"http://maps.google.cn/maps/api/geocode/json?latlng=40.9931780000,113.1329930000&language=CN"];//乌兰察布市
//    NSString *loactionStr = [NSString stringWithFormat:@"http://maps.google.cn/maps/api/geocode/json?latlng=32.3288250000,121.2492190000&language=CN"];//南通市
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//二进制格式转换过来
    
    [manager GET:loactionStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];//把二进制的数据通过json转换过来
        
        NSArray *array = dic[@"results"];
        NSDictionary *dic1 = array[1];
        NSArray *address_components = dic1[@"address_components"];
        NSDictionary *provinciale = address_components[1];
        NSString *locationName = provinciale[@"short_name"];
        
        
        [_user setObject:locationName forKey:@"locationName"];//市级名称
        [_user setObject:[NSString stringWithFormat:@"%f",_locationManager.location.coordinate.longitude] forKey:@"longitude"];
        [_user setObject:[NSString stringWithFormat:@"%f",_locationManager.location.coordinate.latitude] forKey:@"latitude"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
