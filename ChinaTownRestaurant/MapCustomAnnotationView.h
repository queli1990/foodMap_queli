//
//  MapCustomAnnotationView.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/12.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "MapCustomCalloutView.h"

@interface MapCustomAnnotationView : MAAnnotationView

@property (nonatomic,readonly) MapCustomCalloutView *calloutView;

@end
