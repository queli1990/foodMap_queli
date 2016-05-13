//
//  SearchViewController.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/15.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (nonatomic,strong) NSMutableArray *chooseArray;
@property (nonatomic) NSInteger chooseCount;

@property (nonatomic,copy) NSString *cityId;

@end
