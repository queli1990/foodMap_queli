//
//  SearchTableViewCell.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/15.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface SearchTableViewCell : UITableViewCell

@property (nonatomic,strong) SearchModel *model;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
//@property (nonatomic,strong) UIButton *rightButton;

@end


