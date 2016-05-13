//
//  RecommendCityListModel.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/3.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "RecommendCityListModel.h"

@implementation RecommendCityListModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (RecommendCityListModel *)modelWithDictionary:(NSDictionary *)dictionary{
    RecommendCityListModel *model = [[RecommendCityListModel alloc]initWithDictionary:dictionary];
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)usersArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (usersArray.count >= 1) {
        for (int i = 0; i < usersArray.count; i++) {
            RecommendCityListModel *model = [RecommendCityListModel modelWithDictionary:usersArray[i]];
            [array addObject:model];
        }
        return (NSArray *)array;
    }else{
        return nil;
    }
}

@end
