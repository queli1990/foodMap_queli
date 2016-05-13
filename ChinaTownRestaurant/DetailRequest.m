//
//  DetailRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/19.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "DetailRequest.h"
#define urlSuffix_str @"api/page/business"


@implementation DetailRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    NSString *str = [NSString stringWithFormat:@"api/page/business/%@.json",self.businessId];
    
    [self baseGetRequest:params andTransactionSuffix:str andBlock:^(BaseHttpRequest *responseData) {
        
        self.commentArray = [self JsonArrayForContentParsing:responseData._data];
        self.dishArray = [self JsonArrayForDish:responseData._data];
        self.couponArray = [self JsonArrayForCoupon:responseData._data];
        self.businessDic = [self JsonCount:responseData._data];
        self.isCollection = [self userHaveCollectedOrNot:responseData._data];
        block(self);
        
    }
              andFailure:^(BaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}

- (BOOL) userHaveCollectedOrNot:(id)responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    
    NSString *str = dic_array[@"collects"];
    return str.boolValue;
}

- (NSDictionary *) JsonCount:(id)responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSDictionary *countDic = dic_array[@"business"];
    return countDic;
}

-(NSArray *)JsonArrayForDish:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSArray *array = dic_array[@"dish"];
    NSArray *models = [Detail_DishModel modelsWithArray:array];
    return models;
}

-(NSArray *)JsonArrayForCoupon:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSArray *array = dic_array[@"coupon"];
    NSArray *models = [Detail_CouponModel modelsWithArray:array];
    return models;
}

-(NSArray *)JsonArrayForContentParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSArray *array = dic_array[@"comment"];
    NSArray *models = [Detail_Comment modelsWithArray:array];
    return models;
}

@end
