//
//  HomeBaseHttpRequest.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/3.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeBaseHttpRequest.h"
#import "UIKit+AFNetworking.h"

@interface HomeBaseHttpRequest : NSObject

@property (nonatomic,strong) NSError *error;
@property (nonatomic,strong) id _data;
@property (nonatomic,copy) NSString *flag;


typedef void (^basehttpResponseBlock)(HomeBaseHttpRequest *responseData);
typedef void (^basehttpFlagBlock)(NSString *flag);


-(void)baseGetRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(basehttpResponseBlock)block andFailure:(basehttpResponseBlock)failureBlock;

- (void) basePostRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(basehttpFlagBlock)block andFailure:(basehttpFlagBlock)failureBlock;


@end
