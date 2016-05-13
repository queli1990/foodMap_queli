//
//  AppDelegate.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/7.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

