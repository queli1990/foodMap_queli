//
//  ChinaTownHomeCityListTableViewCell.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCityListModel.h"


@interface HomeCityListTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *cityLabel;
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UIImageView *shadowImageView;

@property (nonatomic,strong) HomeCityListModel *model;

@end
