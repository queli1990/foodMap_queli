//
//  PersonalTableViewCell.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PersonalTableViewCell.h"

@implementation PersonalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 85, 50)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        [self.contentView addSubview:_titleLabel];
        
        self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-30-30-5, (60-30)/2, 30, 30)];
        _headImg.image = [UIImage imageNamed:@"head_placeholder"];
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = _headImg.frame.size.width/2;
        [self.contentView addSubview:_headImg];
        
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-15-15, (60-20)/2, 15, 20)];
        img.image = [UIImage imageNamed:@"ArrowRight"];
//        [self.contentView addSubview:img];
        
        self.inputLabel = [[UILabel alloc] init];
        _inputLabel.textAlignment = NSTextAlignmentRight;
        _inputLabel.font = [UIFont systemFontOfSize:16.0];
        _inputLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_inputLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, ScreenWidth, 1)];
        _lineView.backgroundColor = [UIColor colorWithRed:239.0/256.0 green:239.0/256.0 blue:239.0/256.0 alpha:1.0];
        [self.contentView addSubview:_lineView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
