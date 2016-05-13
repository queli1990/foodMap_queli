//
//  BaseNavigationController.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/4.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController<UINavigationControllerDelegate,UINavigationBarDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,weak) UIViewController *currentShowVC;

@end
