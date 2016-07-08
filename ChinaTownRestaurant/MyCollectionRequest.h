//
//  MyCollectionRequest.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/7/5.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "MyCollectionModel.h"


@interface MyCollectionRequest : BaseHttpRequest

typedef void (^httpResponseBlock)(MyCollectionRequest *responseData);

@property (nonatomic,strong) NSError *responseError;

@property (nonatomic,copy) NSString *requestUrl;

@property (nonatomic,strong) NSArray *models;

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;

@end
