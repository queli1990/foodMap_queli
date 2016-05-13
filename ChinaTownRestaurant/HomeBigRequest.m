//
//  HomeBigRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/3.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeBigRequest.h"
#define urlSuffix_str @"index/1/"


@implementation HomeBigRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    [self baseGetRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(HomeBaseHttpRequest *responseData) {
//        self.totoalCount = [self jsonTotalCount:responseData._data];
        self.homeCellArray = [self JsonArrayForCell:responseData._data];
        self.homeHeadArray = [self JsonArrayForHead:responseData._data];
        self.homeCityListArray = [self JsonArrayForCityList:responseData._data];
        block(self);
        
    }
              andFailure:^(HomeBaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}

//新借口没有总数
- (NSNumber *)jsonTotalCount:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSArray *data = dic[@"data"];
    NSDictionary *dic_array = data[0];
    NSDictionary *business = dic_array[@"business"];
    NSNumber *count = business[@"total"];
    return count;
}

-(NSArray *)JsonArrayForCell:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSArray *array = dic_array[@"focuses"];
    NSArray *models = [HomeModel modelsWithArray:array];
    return models;
}

-(NSArray *)JsonArrayForHead:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSArray *array = dic_array[@"categories"];
    NSArray *models = [HomeHeadModel modelsWithArray:array];
    return models;
}


-(NSArray *)JsonArrayForCityList:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSArray *array = dic_array[@"cities"];
    NSArray *models = [HomeCityListModel modelsWithArray:array];
    return models;
}


@end
