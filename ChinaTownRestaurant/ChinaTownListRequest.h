//
//  ChinaTownListRequest.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/12.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "RecommendListModel.h"
#import "RecommendCityListModel.h"

@interface ChinaTownListRequest : BaseHttpRequest

typedef void (^httpResponseBlock)(ChinaTownListRequest *responseData);

@property (nonatomic,strong) NSError *responseError;

@property (nonatomic,strong) NSMutableArray *cityListArray;
@property (nonatomic,strong) NSArray *responsedataArray;
@property (nonatomic,strong) NSNumber *count;

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;


@end
