//
//  ModeifyPersonalInfoRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ModeifyPersonalInfoRequest.h"

@implementation ModeifyPersonalInfoRequest

- (void)requestFlag:(NSDictionary *)params andBlock:(basehttpFlagBlock)block andFailureBlock:(basehttpFlagBlock)failureBlock{
    
    if (self.requestFlag == 1) {//昵称
        
        [self basePostFlagRequest:params andTransactionSuffix:@"/api/user/update/base.json" andBlock:^(NSString *flag) {
            self.flagString = flag;
            block(self.flagString);
        } andFailure:^(NSString *flag) {
            self.flagString = flag;
            failureBlock(self.flagString);
        }];
        
    }else if (self.requestFlag == 2){//密码
        
        [self basePostFlagRequest:params andTransactionSuffix:@"/api/user/update/pwd.json" andBlock:^(NSString *flag) {
            self.flagString = flag;
            block(self.flagString);
        } andFailure:^(NSString *flag) {
            self.flagString = flag;
            failureBlock(self.flagString);
        }];
    }
}

@end
