//
//  LoginRequest.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PostBaseHttpRequest.h"

@interface LoginRequest : PostBaseHttpRequest

typedef void (^httpResponseBlock)(LoginRequest *responseData);

@property (nonatomic,strong) NSError *responseError;
@property (nonatomic,strong) NSDictionary *responsedataDic;

@property (nonatomic,copy) NSString *flag;


-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlock)block andFailureBlock:(httpResponseBlock)failureBlock;


@end
