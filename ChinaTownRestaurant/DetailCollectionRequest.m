//
//  DetailCollectionRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/25.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "DetailCollectionRequest.h"
#define urlSuffix_str @"api/collects/save.json"


@implementation DetailCollectionRequest

-(id)requestData:(NSDictionary *)params andBlock:(detailHttpResponseBlockhttpResponseBlock)block andFailureBlock:(detailHttpResponseBlockhttpResponseBlock)failureBlock{
    
    [self baseGetRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(BaseHttpRequest *responseData) {
        
        self.isSuccess = [self JsonCount:responseData._data];
        
        block(self);
        
    }
              andFailure:^(BaseHttpRequest *responseData) {
                  self.responseError = responseData.error;
                  failureBlock(self);
              }];
    
    return self;
}

- (BOOL) JsonCount:(id)responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    BOOL success = dic[@"success"];
    return success;
}

@end
