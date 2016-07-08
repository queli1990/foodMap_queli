//
//  MyCollectionModel.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/7/5.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCollectionModel : NSObject

@property (nonatomic,strong) NSNumber *start;
@property (nonatomic,strong) NSNumber *fetchsize;
@property (nonatomic,strong) NSNumber *page;
@property (nonatomic,strong) NSNumber *rows;
@property (nonatomic,strong) NSNumber *Id;
@property (nonatomic,strong) NSNumber *userId;
@property (nonatomic,strong) NSNumber *businessId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *businessName;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *avgRating;
@property (nonatomic,copy) NSString *avgPrice;

+ (MyCollectionModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;


@end

