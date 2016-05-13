//
//  Detail_Comment.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/19.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detail_Comment : NSObject


@property (nonatomic,strong) NSNumber *start;
@property (nonatomic,strong) NSNumber *fetchsize;
@property (nonatomic,strong) NSNumber *page;
@property (nonatomic,strong) NSNumber *rows;
@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,copy) NSString *userid;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *userAvatar;//类型不定
@property (nonatomic,strong) NSNumber *createtime;
@property (nonatomic,copy) NSString *thirdtype;
@property (nonatomic,copy) NSString *thirdid;
@property (nonatomic,copy) NSString *avgrating;
@property (nonatomic,copy) NSString *productscore;
@property (nonatomic,copy) NSString *decorationscore;
@property (nonatomic,copy) NSString *servicescore;
@property (nonatomic,copy) NSString *comment;
@property (nonatomic,copy) NSString *commentsource;
//@property (nonatomic,copy) NSString *isrealdata;
//@property (nonatomic,copy) NSString *language;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,strong) NSArray *photoList;

+ (Detail_Comment *)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)modelsWithArray:(NSArray *)usersArray;



@end
