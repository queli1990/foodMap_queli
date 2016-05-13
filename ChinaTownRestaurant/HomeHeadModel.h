//
//  ChinaTownRestaurantHeadModel.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeHeadModel : NSObject

@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *category_name;
@property (nonatomic,copy) NSString *category;
//@property (nonatomic,copy) NSString *count;
//@property (nonatomic,copy) NSString *name;
//@property (nonatomic,copy) NSString *title;
//@property (nonatomic,copy) NSString *load;



+ (HomeHeadModel *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;


@end
