//
//  Detail_CouponModel.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/19.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detail_CouponModel : NSObject

@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSNumber *businessId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,strong) NSNumber *state;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,strong) NSNumber *begintime;
@property (nonatomic,strong) NSNumber *endtime;
@property (nonatomic,strong) NSNumber *amount;
@property (nonatomic,strong) NSNumber *remain;

+ (Detail_CouponModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;


@end
