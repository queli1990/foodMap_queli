//
//  ChinaTownHomeCityListTableViewCell.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeCityListTableViewCell.h"

@implementation HomeCityListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*9/16)];
        
        CGFloat scale = 720/ScreenWidth;
        CGFloat heigth = 149/scale;
        self.shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScreenWidth*9/16-heigth, ScreenWidth, heigth)];
        _shadowImageView.image = [UIImage imageNamed:@"CityList_shadow"];
        
        
        self.cityLabel = [[UILabel alloc] init];
        if (ScreenWidth == 320) {
            _cityLabel.frame = CGRectMake(15, heigth-10-15, ScreenWidth-15*2, 15);
        }else{
            _cityLabel.frame = CGRectMake(21, heigth-15-15, ScreenWidth-21*2, 15);
        }
        _cityLabel.font = [UIFont systemFontOfSize:18.0];
        _cityLabel.textAlignment = NSTextAlignmentLeft;
        _cityLabel.textColor = UIColorFromRGB(0xffffff, 1.0);
        
        
        [_shadowImageView addSubview:_cityLabel];
        [_bgImageView addSubview:_shadowImageView];
        [self.contentView addSubview:_bgImageView];
    }
    return self;
}

- (void) setModel:(HomeCityListModel *)model{
    _model = model;
    _cityLabel.text = model.city_name;
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"TVLog"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
