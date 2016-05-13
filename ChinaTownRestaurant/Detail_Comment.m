//
//  Detail_Comment.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/19.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "Detail_Comment.h"

@implementation Detail_Comment

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
//        NSString *newId = [dictionary valueForKey:@"description"];
//        NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
//        [newDic removeObjectForKey:@"description"];
//        [newDic setValue:newId forKey:@"Description"];
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (Detail_Comment *)modelWithDictionary:(NSDictionary *)dictionary{
    Detail_Comment *model = [[Detail_Comment alloc]initWithDictionary:dictionary];
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)usersArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (usersArray.count >= 1) {
        for (int i = 0; i < usersArray.count; i++) {
            Detail_Comment *model = [Detail_Comment modelWithDictionary:usersArray[i]];
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

