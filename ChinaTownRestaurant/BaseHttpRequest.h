//
//  BaseHttpRequest.h
//  VegoVideo
//
//  Created by mobile_007 on 15/11/13.
//  Copyright © 2015年 王林芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit+AFNetworking.h"
#import "BaseHttpRequest.h"

@interface BaseHttpRequest : NSObject

@property (nonatomic,strong) NSError *error;
@property (nonatomic,strong) id _data;
@property (nonatomic,copy) NSString *flag;


typedef void (^basehttpResponseBlock)(BaseHttpRequest *responseData);
typedef void (^basehttpFlagBlock)(NSString *flag);


-(void)baseGetRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(basehttpResponseBlock)block andFailure:(basehttpResponseBlock)failureBlock;

- (void) basePostRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(basehttpFlagBlock)block andFailure:(basehttpFlagBlock)failureBlock;

//- (void) baseDeleteRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) uslSuffix andBlock:()


@end
