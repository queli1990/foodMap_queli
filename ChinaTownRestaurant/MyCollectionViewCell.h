//
//  MyCollectionViewCell.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/7/5.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipView.h"
#import "MyCollectionModel.h"

@interface MyCollectionViewCell : UITableViewCell

@property (nonatomic,strong) UIView *blackLineView;
@property (nonatomic,strong) UIView *whiteLineView;

@property (nonatomic,strong) UIImageView *showView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIImageView *bigPicture;

@property (nonatomic,strong) UIView *adressAndPriceView;//盛放地址和价格的view
@property (nonatomic,strong) UILabel *adressLabel;
@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) TipView *tipView;


@property (nonatomic,strong) MyCollectionModel *model;

- (CGFloat) homeCellHeight;

@end