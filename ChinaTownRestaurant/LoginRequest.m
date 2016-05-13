//
//  LoginRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "LoginRequest.h"
#define urlSuffix_str @"/api/user/login.json"


@implementation LoginRequest

-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock{
    
    [self basePostDataRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(PostBaseHttpRequest *responseData) {
        self.flag = [self jsonFlag:responseData._data];
        self.responsedataDic = [self JsonArrayParsing:responseData._data];
        block(self);
    } andFailure:^(PostBaseHttpRequest *responseData) {
        self.responseError = responseData.error;
        failureBlock(self);
    }];
    
    return self;
}

- (NSString *)jsonFlag:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSString *str = [NSString stringWithFormat:@"%@",dic[@"success"]];
    return str;
}

-(NSDictionary *)JsonArrayParsing:(id) responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic1 = dic[@"data"];
    
    return dic1;
}


@end
