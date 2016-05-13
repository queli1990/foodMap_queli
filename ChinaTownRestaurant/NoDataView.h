//
//  NoDataView.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/12.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue,alhpaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alhpaValue]

@interface NoDataView : UIView

@property (nonatomic,strong) UIButton *requestBtn;

@end
