//
//  SendCommentRequest.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/25.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface SendCommentRequest : BaseHttpRequest

typedef void (^detailHttpResponseBlockhttpResponseBlock)(SendCommentRequest *responseData);

@property (nonatomic,strong) NSError *responseError;
@property (nonatomic) BOOL isSuccess;

-(id)requestData:(NSDictionary *)params andBlock:(detailHttpResponseBlockhttpResponseBlock)block andFailureBlock:(detailHttpResponseBlockhttpResponseBlock)failureBlock;


@end
