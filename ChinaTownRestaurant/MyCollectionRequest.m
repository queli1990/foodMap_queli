//
//  MyCollectionRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/7/5.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MyCollectionRequest.h"
//#define urlSuffix_str @"api/page/business/list.json"

@implementation MyCollectionRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    [self baseGetRequest:params andTransactionSuffix:self.requestUrl andBlock:^(BaseHttpRequest *responseData) {
        
        self.models = [self JsonArray:responseData._data];
        block(self);
        
    }
              andFailure:^(BaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}

-(NSArray *)JsonArray:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSArray *dic_array = dic[@"data"];
    NSArray *models = [MyCollectionModel modelsWithArray:dic_array];
    return models;
}


@end
