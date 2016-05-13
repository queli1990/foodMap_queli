//
//  ChinaTownListController.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendListController : UIViewController

@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic) int page;
@property (nonatomic) int size;

@property (nonatomic,copy) NSString *cityId;
//@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *foodCategory;
@property (nonatomic,copy) NSString *chooseRegion;
@property (nonatomic,copy) NSString *order;

@property (nonatomic,strong) NSMutableArray *chooseCategoryArray;//菜品的6个分类
@property (nonatomic) NSInteger chooseCategoryCount;//用户选中的分类

@property (nonatomic,copy) NSString *searchWord;

@property (nonatomic) BOOL isFormSearchPage;

@end
