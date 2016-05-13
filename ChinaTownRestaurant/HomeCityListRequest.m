//
//  HomeCityListRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/14.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeCityListRequest.h"
#define urlSuffix_str @"api/region/list.json?parentid=-10000"

@implementation HomeCityListRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    [self baseGetRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(BaseHttpRequest *responseData) {
        
        self.responsedataArray = [self JsonArrayForContentParsing:responseData._data];
        block(self);
        
    }
              andFailure:^(BaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}


-(NSArray *)JsonArrayForContentParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = dic[@"data"];
    NSArray *models = [HomeCityListModel modelsWithArray:array];
    return models;
}

@end
