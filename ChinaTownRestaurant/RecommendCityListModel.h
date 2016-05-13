//
//  RecommendCityListModel.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/3.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendCityListModel : NSObject

@property (nonatomic,strong) NSNumber *start;
@property (nonatomic,strong) NSNumber *fetchsize;
@property (nonatomic,strong) NSNumber *page;
@property (nonatomic,strong) NSNumber *rows;
@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSNumber *parentid;
@property (nonatomic,strong) NSNumber *state;

//@property (nonatomic,strong) NSNumber *storage;
//@property (nonatomic,copy) NSString *city;
//@property (nonatomic,copy) NSString *city_name;
//@property (nonatomic,copy) NSString *image;

+ (RecommendCityListModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;


@end
