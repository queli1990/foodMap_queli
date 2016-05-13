//
//  ChinaTownHomeController.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCityListModel.h"

@interface HomeController : UIViewController

@property (nonatomic,strong) HomeCityListModel *defauletCityModel;//若第一次进入app时为默认的城市

@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic) int page;
@property (nonatomic) int rows;


@end
