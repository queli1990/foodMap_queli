//
//  ChinaTownMapController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/12.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MapController.h"
#import <MAMapKit/MAMapKit.h>
#import "MapCustomAnnotationView.h"



@interface MapController ()<MAMapViewDelegate>

@property (nonatomic,strong) CLLocationManager *locationManger;

@end

@implementation MapController{
    MAMapView *_mapView;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"开启定位" message:@"The calendar permission was not authorized. Please enable it in Settings to continue." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *setting = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSURL *appSettings = [NSURL URLWithString:[NSString stringWithFormat:@"%@",UIApplicationOpenSettingsURLString]];
                [UIApplication.sharedApplication openURL:appSettings];
            });
            
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:setting];
        [alertController addAction:cancle];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //配置用户Key
//    [MAMapServices sharedServices].apiKey = @"553455c7719b74903c1cacdd7ba53579";
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;//显示用户信息
    
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    
    //后台定位
    //    _mapView.pausesLocationUpdatesAutomatically = NO;
    //    _mapView.allowsBackgroundLocationUpdates = YES;//iOS9以上系统必须配置
    
    [self.view addSubview:_mapView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 40, 36, 36);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setTitle:@"back" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Detail_Map_backNormal"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Detail_Map_backHeighted"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void) backToLastPage:(UIButton *)tbn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view, typically from a nib.
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lng);
    pointAnnotation.title = self.title;
    pointAnnotation.subtitle = self.subTitle;
    
    [_mapView addAnnotation:pointAnnotation];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        static NSString *reuseIndetifier = @"annotationReuseIndetifier";//自定义大头针的图标
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;

        //使用自定义图片，不用大头针
//        annotationView.image = [UIImage imageNamed:@"TVLog"];
//        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
        
        return annotationView;
    }
    return nil;
}

//使用自定义的弹出气泡
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//        MapCustomAnnotationView *annotationView = (MapCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MapCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
//        }
//        annotationView.image = [UIImage imageNamed:@"TVLog"];
//
//        // 设置为NO，用以调用自定义的calloutView
//        annotationView.canShowCallout = NO;
//        
//        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
//        return annotationView;
//    }
//    return nil;
//}


//实时获取当前位置
//-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
//updatingLocation:(BOOL)updatingLocation
//{
//    if(updatingLocation)
//    {
//        //取出当前位置的坐标
//        NSLog(@"当前位置的坐标:latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//    }
//}


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
