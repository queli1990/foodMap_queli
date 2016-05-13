//
//  ChinaTownHomeCityListViewController.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCityListModel.h"

@protocol passCityNameDelegate <NSObject>

- (void) passCity:(HomeCityListModel *)model;

@end

@interface HomeCityListViewController : UIViewController
@property (nonatomic,weak) id<passCityNameDelegate>delegate;
@property (nonatomic,strong) NSMutableArray *datas;



@end
