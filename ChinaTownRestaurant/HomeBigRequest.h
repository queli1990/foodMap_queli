//
//  HomeBigRequest.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/3.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeBaseHttpRequest.h"
#import "HomeModel.h"
#import "HomeHeadModel.h"
#import "HomeCityListModel.h"

@interface HomeBigRequest : HomeBaseHttpRequest

typedef void (^httpResponseBlock)(HomeBigRequest *responseData);

@property (nonatomic,strong) NSError *responseError;

@property (nonatomic,strong) NSNumber *totoalCount;
@property (nonatomic,strong) NSArray *homeCellArray;
@property (nonatomic,strong) NSArray *homeCityListArray;
@property (nonatomic,strong) NSArray *homeHeadArray;

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;


@end
