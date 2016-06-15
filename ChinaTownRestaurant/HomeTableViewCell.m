//
//  ChinaTownRestaurantTableViewCell.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.blackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        _blackLineView.backgroundColor = UIColorFromRGB(0x000000, 0.18);
        [self.contentView addSubview:_blackLineView];
        
        
        self.bigPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_blackLineView.frame), ScreenWidth, (ScreenWidth)*9/16)];
        
        
        self.whiteLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        _whiteLineView.backgroundColor = UIColorFromRGB(0xffffff, 0.2);
        [self.bigPicture addSubview:_whiteLineView];
        
        
        CGFloat scal = 720/ScreenWidth;
        self.showView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_whiteLineView.frame), ScreenWidth, 200/scal)];
        _showView.image = [UIImage imageNamed:@"HomeCellShade"];
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (39-24)/2, 24, 24)];
//        _iconImageView.image = [UIImage imageNamed:@"HomeCellIcon"];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+10, (39-20)/2, ScreenWidth-10-CGRectGetMaxX(_iconImageView.frame)-100, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:18.0];
        _nameLabel.textColor = UIColorFromRGB(0xffffff, 1.0);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.showView addSubview:_nameLabel];
        [self.showView addSubview:_iconImageView];
        [self.bigPicture addSubview:_showView];
        
        
        _tipView = [[TipView alloc] initWithFrame:CGRectMake(ScreenWidth-60, 0, 60, 60)];
        [_bigPicture addSubview:_tipView];
        
        
        self.adressAndPriceView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_bigPicture.frame), ScreenWidth, 50)];
        _adressAndPriceView.backgroundColor = UIColorFromRGB(0x000000, 0.20);
        
        self.adressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-20, 20)];
        _adressLabel.font = [UIFont systemFontOfSize:12.0];
        _adressLabel.textColor = UIColorFromRGB(0xffffff, 1.0);
        _adressLabel.textAlignment = NSTextAlignmentLeft;
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_adressLabel.frame)+5, ScreenWidth-20, 20)];
        _priceLabel.font = [UIFont systemFontOfSize:14.0];
        _priceLabel.textColor = UIColorFromRGB(0xffffff, 1.0);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        
        [_adressAndPriceView addSubview:_priceLabel];
        [_adressAndPriceView addSubview:_adressLabel];
        [self.contentView addSubview:_adressAndPriceView];
        
        [self.contentView addSubview:_bigPicture];
    }
    
    return self;
}

- (CGFloat) homeCellHeight{
    return CGRectGetMaxY(_adressAndPriceView.frame);
}

- (void) setModel:(HomeModel *)model{
    _model = model;
    
    if ([model.category isEqualToString:@"217"]) {
        _iconImageView.image = [UIImage imageNamed:@"cell_icon_sneck"];
    }else if ([model.category isEqualToString:@"103"]){
        _iconImageView.image = [UIImage imageNamed:@"cell_icon_guangdong"];
    }else if ([model.category isEqualToString:@"102"]){
        _iconImageView.image = [UIImage imageNamed:@"cell_icon_sichuan"];
    }else if ([model.category isEqualToString:@"106"]){
        _iconImageView.image = [UIImage imageNamed:@"cell_icon_dongbei"];
    }else if ([model.category isEqualToString:@"101"]){
        _iconImageView.image = [UIImage imageNamed:@"cell_icon_jiangzhe"];
    }else {
        _iconImageView.image = [UIImage imageNamed:@"HomeCellIcon"];
    }
    
    [_bigPicture sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeholder_16_9"]];
    _nameLabel.text = model.name;
    _adressLabel.text = model.address;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@元/人",model.avgPrice];
    
    CGFloat rating = model.avgRating.floatValue;
    _tipView.productScore = [NSString stringWithFormat:@"%.1f",rating];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
