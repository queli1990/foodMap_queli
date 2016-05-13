//
//  ChinaTownDetailShopInfo.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/11.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipCircleView.h"

@interface DetailShopInfo : UIView

@property (nonatomic,strong) UIImageView *backgroundImageView;//地图背景
@property (nonatomic,strong) UILabel *nameLabel;//名称
@property (nonatomic,strong) UILabel *categoryLabel;//菜品
@property (nonatomic,strong) UILabel *addressLabel;//地址
@property (nonatomic,strong) TipCircleView *tipView;//右边的评分
@property (nonatomic,strong) UIButton *telBtn;//打电话按钮
@property (nonatomic,strong) UILabel *telLabel;//打电话的label

@property (nonatomic,strong) NSDictionary *dic;


@end
