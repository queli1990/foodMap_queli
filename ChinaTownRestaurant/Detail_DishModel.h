//
//  Detail_DishModel.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/19.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detail_DishModel : NSObject

@property (nonatomic,strong) NSNumber *start;
@property (nonatomic,strong) NSNumber *fetchsize;
@property (nonatomic,strong) NSNumber *page;
@property (nonatomic,strong) NSNumber *rows;
@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSNumber *businessId;
@property (nonatomic,strong) NSNumber *cid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *photoUrl;

+ (Detail_DishModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;

@end
