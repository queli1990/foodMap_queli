//
//  SendCommentViewController.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/25.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendMessageSuccessAndToRequestData <NSObject>

- (void) sendMessageSuccessAndToRequestCommentData;

@end

@interface SendCommentViewController : UIViewController

@property (nonatomic,copy) NSString *thirdid;
@property (nonatomic,weak) id <sendMessageSuccessAndToRequestData> delegate;

@end
