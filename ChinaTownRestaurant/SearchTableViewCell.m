//
//  SearchTableViewCell.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/15.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (50-13*1.3)/2, 18*1.3, 13*1.3)];
        _leftImageView.image = [UIImage imageNamed:@"TimerImage"];
        [self.contentView addSubview:_leftImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+20, 10, 200, 30)];
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        
        
        UIView *viewForLine = [[UIView alloc] initWithFrame:CGRectMake(_leftImageView.frame.origin.x, 49, ScreenWidth-(_leftImageView.frame.origin.x)*2, 1)];
        viewForLine.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
        [self.contentView addSubview:viewForLine];
        
        self.contentView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:244.0/255.0 alpha:1.0];
    }
    return self;
}

- (void) setModel:(SearchModel *)model {
    _model = model;
    _nameLabel.text = model.searchWord;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
