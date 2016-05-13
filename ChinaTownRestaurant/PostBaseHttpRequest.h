//
//  PostBaseHttpRequest.h
//  VegoVideo
//
//  Created by mobile_007 on 16/1/15.
//  Copyright © 2016年 王林芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"


@interface PostBaseHttpRequest : NSObject

@property (nonatomic,strong) NSError *error;
@property (nonatomic,strong) id _data;
@property (nonatomic,copy) NSString *flag;



typedef void (^PostBasehttpResponseBlock)(PostBaseHttpRequest *responseData);
typedef void (^PostBasehttpFlagBlock)(NSString *flag);


-(void)basePostDataRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(PostBasehttpResponseBlock)block andFailure:(PostBasehttpResponseBlock)failureBlock;


- (void) basePostFlagRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(PostBasehttpFlagBlock)block andFailure:(PostBasehttpFlagBlock)failureBlock;




@end
