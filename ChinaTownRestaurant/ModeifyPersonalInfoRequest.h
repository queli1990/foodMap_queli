//
//  ModeifyPersonalInfoRequest.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PostBaseHttpRequest.h"

@interface ModeifyPersonalInfoRequest : PostBaseHttpRequest

typedef void (^httpResponseBlockPost_Detail_insertComment)(ModeifyPersonalInfoRequest *responseData);
typedef void (^basehttpFlagBlock)(NSString *flag);


@property (nonatomic,strong) NSError *responseError;
@property (nonatomic,strong) NSArray *responsedataArray;
@property (nonatomic,copy) NSString *flagString;

@property (nonatomic) NSInteger requestFlag;

//-(id)requestData:(NSDictionary *)params andBlock:(httpResponseBlockPost_Detail_insertComment)block andFailureBlock:(httpResponseBlockPost_Detail_insertComment)failureBlock;

- (void)requestFlag:(NSDictionary *)params andBlock:(basehttpFlagBlock)block andFailureBlock:(basehttpFlagBlock)failureBlock;


@end
