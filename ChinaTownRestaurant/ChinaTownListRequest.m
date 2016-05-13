//
//  ChinaTownListRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/12.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ChinaTownListRequest.h"
//#define urlSuffix_str @"api/business/list/page"
#define urlSuffix_str @"api/page/business/list.json"



@implementation ChinaTownListRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    [self baseGetRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(BaseHttpRequest *responseData) {
        
        self.responsedataArray = [self JsonArrayForContentParsing:responseData._data];
        self.cityListArray = (NSMutableArray *)[self JsonArrayForCityLists:responseData._data];
        self.count = [self JsonCount:responseData._data];
        block(self);
        
    }
              andFailure:^(BaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}

- (NSNumber *) JsonCount:(id)responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSDictionary *countDic = dic_array[@"business"];
    NSNumber *total = countDic[@"total"];
    return total;
}

-(NSArray *)JsonArrayForCityLists:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSArray *array = dic_array[@"region"];
    NSArray *models = [RecommendCityListModel modelsWithArray:array];
    return models;
}

-(NSArray *)JsonArrayForContentParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic_array = dic[@"data"];
    NSDictionary *business = dic_array[@"business"];
    NSArray *array = business[@"rows"];
    NSArray *models = [RecommendListModel modelsWithArray:array];
    return models;
}


@end
