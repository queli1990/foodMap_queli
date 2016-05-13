//
//  ChinaTownListTableViewCell.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendListModel.h"
#import "TipView.h"


@interface RecommendListTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIView *whiteLineView;

@property (nonatomic,strong) UIImageView *sumImgView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIImageView *addressImageView;
@property (nonatomic,strong) UILabel *loadLabel;

@property (nonatomic,strong) UIImageView *categoryImageView;
@property (nonatomic,strong) UILabel *categoryLabel;


@property (nonatomic,strong) TipView *tipView;

@property (nonatomic,strong) RecommendListModel *model;

@end
