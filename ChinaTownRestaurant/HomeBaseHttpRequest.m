//
//  HomeBaseHttpRequest.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/3.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeBaseHttpRequest.h"
#define baseURL_vego @"http://114.215.152.233:8000/"


@implementation HomeBaseHttpRequest

-(void)baseGetRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(basehttpResponseBlock)block andFailure:(basehttpResponseBlock)failureBlock{
    
    NSString*url = [self buildUrlStr:params andTransactionSuffix:urlSuffix];
    //    NSLog(@"url:%@",url);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self._data = responseObject;
        block(self);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        _error = error;
        failureBlock(self);
        
    }];
    
}

- (void) basePostRequest:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix andBlock:(basehttpFlagBlock)block andFailure:(basehttpFlagBlock)failureBlock{
    
    NSString*url = [self buildUrlStr:nil andTransactionSuffix:urlSuffix];
    //    NSLog(@"url:%@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];//请求格式
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.flag = @"success";
        block(self.flag);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        self.flag = @"failure";
        _error = error;
        failureBlock(self.flag);
        
    }];
    
}

-(NSString*)buildUrlStr:(NSDictionary *)params andTransactionSuffix:(NSString *) urlSuffix{
    
    NSMutableString *urlString =[NSMutableString string];
    
    [urlString appendString:baseURL_vego];
    
    [urlString appendString:urlSuffix];
    
    //    [urlString appendString:@"?"];
    //
    //    NSArray *array = @[@"cpid",@"plateform_id",@"topic_id",@"page",@"size"];
    //    for (int i = 0; i < array.count; i++) {
    //        NSString *value = [params valueForKey:array[i]];
    //        [urlString appendFormat:@"%@=%@",array[i],value];
    //    }
    //
    //    return urlString;
    NSString *escapedString;
    NSInteger keyIndex = 0;
    
    
    for (id key in params) {
        if(keyIndex == 0){
            
            escapedString =(NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)[params valueForKey:key], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
            [urlString appendFormat:@"?%@=%@",key,escapedString];
        }else{
            
            escapedString =(NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)[params valueForKey:key], NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
            [urlString appendFormat:@"&%@=%@",key,escapedString];
            
        }
        
        keyIndex ++;
    }
    //    NSLog(@"urlstring:%@",urlString);
    return urlString;
}


@end
