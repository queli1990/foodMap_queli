//
//  HomeCityListRequest.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/14.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "HomeCityListModel.h"

@interface HomeCityListRequest : BaseHttpRequest

typedef void (^httpResponseBlock)(HomeCityListRequest *responseData);

@property (nonatomic,strong) NSError *responseError;


@property (nonatomic,strong) NSArray *responsedataArray;

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;


@end
