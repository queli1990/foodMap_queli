//
//  ChinaTownListTableViewCell.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "RecommendListTableViewCell.h"

@implementation RecommendListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        _bottomView.backgroundColor = UIColorFromRGB(0xffffff, 0.1);
        
        self.whiteLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        _whiteLineView.backgroundColor = UIColorFromRGB(0x000000, 0.18);
        [_bottomView addSubview:_whiteLineView];
        
        _sumImgView = [[UIImageView alloc] initWithFrame:CGRectMake(gap, gap, 120, 80)];
        [self.contentView addSubview:_sumImgView];
        
        _tipView = [[TipView alloc] initWithFrame:CGRectMake(ScreenWidth-50, 0, 50, 50)];
        [_bottomView addSubview:_tipView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_sumImgView.frame)+gap, _sumImgView.frame.origin.y, ScreenWidth-CGRectGetMaxX(_sumImgView.frame)-gap-_tipView.frame.size.width-gap-gap, 30)];
        _nameLabel.font = [UIFont systemFontOfSize:16.0];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_bottomView addSubview:_nameLabel];
        
        
        self.addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_nameLabel.frame)+5+2, 16, 16)];
        _addressImageView.image = [UIImage imageNamed:@"addressIcon"];
        [_bottomView addSubview:_addressImageView];
        
        _loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_addressImageView.frame)+5, CGRectGetMaxY(_nameLabel.frame)+5, ScreenWidth-CGRectGetMaxX(_sumImgView.frame)-gap-gap-gap, 20)];
        _loadLabel.font = [UIFont systemFontOfSize:12.0];
        _loadLabel.textAlignment = NSTextAlignmentLeft;
        _loadLabel.textColor = [UIColor whiteColor];
//        _loadLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_bottomView addSubview:_loadLabel];
        
        
        self.categoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_addressImageView.frame.origin.x, CGRectGetMaxY(_loadLabel.frame)+5+2, 16, 16)];
        _categoryImageView.image = [UIImage imageNamed:@"foodCategory"];
        [_bottomView addSubview:_categoryImageView];
        
        _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_categoryImageView.frame)+5, CGRectGetMaxY(_loadLabel.frame)+5, _loadLabel.frame.size.width, 20)];
        _categoryLabel.font = [UIFont systemFontOfSize:12.0];
        _categoryLabel.textAlignment = NSTextAlignmentLeft;
        _categoryLabel.textColor = [UIColor whiteColor];
//        _categoryLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_bottomView addSubview:_categoryLabel];
        
        
        [self.contentView addSubview:_bottomView];
    }
    return self;
}

- (void) setModel:(RecommendListModel *)model{
    _model = model;
    [_sumImgView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"placeholder_3_2"]];
    _nameLabel.text = model.name;
    _loadLabel.text = model.address;
    _categoryLabel.text = model.categories;
    _tipView.productScore = model.productScore;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
