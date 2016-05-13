//
//  RegistRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "RegistRequest.h"
#define urlSuffix_str @"/api/user/register.json"


@implementation RegistRequest

- (void)requestFlag:(NSDictionary *)params andBlock:(basehttpFlagBlock)block andFailureBlock:(basehttpFlagBlock)failureBlock{
    
    [self basePostFlagRequest:params andTransactionSuffix:urlSuffix_str andBlock:^(NSString *flag) {
        self.flagString = flag;
        block(self.flagString);
    } andFailure:^(NSString *flag) {
        self.flagString = flag;
        failureBlock(self.flagString);
    }];
    
}

@end
