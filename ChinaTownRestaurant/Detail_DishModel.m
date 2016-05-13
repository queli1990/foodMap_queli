//
//  Detail_DishModel.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/19.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "Detail_DishModel.h"

@implementation Detail_DishModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        NSString *newId = [dictionary valueForKey:@"description"];
        NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
        [newDic removeObjectForKey:@"description"];
        [newDic setValue:newId forKey:@"Description"];
        [self setValuesForKeysWithDictionary:newDic];
    }
    return self;
}

+ (Detail_DishModel *)modelWithDictionary:(NSDictionary *)dictionary{
    Detail_DishModel *model = [[Detail_DishModel alloc]initWithDictionary:dictionary];
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)usersArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (usersArray.count >= 1) {
        for (int i = 0; i < usersArray.count; i++) {
            Detail_DishModel *model = [Detail_DishModel modelWithDictionary:usersArray[i]];
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
