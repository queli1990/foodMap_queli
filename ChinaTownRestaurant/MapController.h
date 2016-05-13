//
//  ChinaTownMapController.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/12.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapController : UIViewController

@property (nonatomic) float lat;
@property (nonatomic) float lng;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subTitle;

@end
