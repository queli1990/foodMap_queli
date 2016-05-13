//
//  ChinaTownRestaurantModel.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (HomeModel *)modelWithDictionary:(NSDictionary *)dictionary{
    HomeModel *model = [[HomeModel alloc]initWithDictionary:dictionary];
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)usersArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (usersArray.count >= 1) {
        for (int i = 0; i < usersArray.count; i++) {
            HomeModel *model = [HomeModel modelWithDictionary:usersArray[i]];
            [array addObject:model];
        }
        return (NSArray *)array;
    }else{
        return nil;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"underFinedKey:%@",key);
}


@end
