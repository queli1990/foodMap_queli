//
//  ChinaTownHomeCityListModel.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCityListModel : NSObject

//@property (nonatomic,strong) NSNumber *start;
//@property (nonatomic,strong) NSNumber *fetchsize;
//@property (nonatomic,strong) NSNumber *page;
//@property (nonatomic,strong) NSNumber *rows;
//@property (nonatomic,strong) NSNumber *id;
//@property (nonatomic,copy) NSString *name;
//@property (nonatomic,strong) NSNumber *parentid;
//@property (nonatomic,strong) NSNumber *state;

@property (nonatomic,strong) NSNumber *storage;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,copy) NSString *image;

+ (HomeCityListModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;


@end
