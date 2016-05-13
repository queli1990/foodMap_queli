//
//  DetailRequest.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/19.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "Detail_Comment.h"
#import "Detail_CouponModel.h"
#import "Detail_DishModel.h"


@interface DetailRequest : BaseHttpRequest

typedef void (^httpResponseBlock)(DetailRequest *responseData);

@property (nonatomic,strong) NSError *responseError;

@property (nonatomic,copy) NSString *businessId;

@property (nonatomic,strong) NSArray *commentArray;
@property (nonatomic,strong) NSArray *dishArray;
@property (nonatomic,strong) NSArray *couponArray;
@property (nonatomic,strong) NSDictionary *businessDic;
@property (nonatomic) BOOL isCollection;


-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;

@end
