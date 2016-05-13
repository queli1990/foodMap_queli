//
//  ChinaTownDetailShopInfo.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/11.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "DetailShopInfo.h"

@implementation DetailShopInfo

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
        _backgroundImageView.image = [UIImage imageNamed:@"Detail_MapBackgorund.jpg"];
        _backgroundImageView.userInteractionEnabled = YES;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 17, 20, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:20.0];
        _nameLabel.textColor = UIColorFromRGB(0x4c4c4c, 1.0);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_backgroundImageView addSubview:_nameLabel];
        
        self.tipView = [[TipCircleView alloc] initWithFrame:CGRectMake(ScreenWidth-58, 0, 58, 58)];
        _tipView.imageView.image = [UIImage imageNamed:@"tip_ circle"];
        [_backgroundImageView addSubview:_tipView];
        
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame)+10, 17, ScreenWidth-_tipView.frame.size.width-CGRectGetMaxX(_nameLabel.frame)-5, 20)];
        _categoryLabel.font = [UIFont systemFontOfSize:20.0];
        _categoryLabel.textAlignment = NSTextAlignmentLeft;
        _categoryLabel.textColor = UIColorFromRGB(0x4c4c4c, 1.0);
        [_backgroundImageView addSubview:_categoryLabel];
        
        
        UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_nameLabel.frame)+9, 40, 20)];
        addLabel.text = @"Add:  ";
//        UIFont *font = [UIFont fontWithName:@"Arial" size:14.0];
        addLabel.font = [UIFont systemFontOfSize:14.0];
//        CGSize nameLabelSize = [addLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
        [self.backgroundImageView addSubview:addLabel];
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addLabel.frame), CGRectGetMaxY(_nameLabel.frame)+9, ScreenWidth-30-CGRectGetMaxX(addLabel.frame)-50, 40)];
        _addressLabel.font = [UIFont systemFontOfSize:14.0];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.numberOfLines = 0;
        _addressLabel.textColor = UIColorFromRGB(0x4c4c4c, 1.0);
        [_backgroundImageView addSubview:_addressLabel];
        
        CGFloat marginY = 10;
        self.telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _telBtn.frame = CGRectMake(15, frame.size.height-marginY-22, 22, 22);
        [_telBtn setImage:[UIImage imageNamed:@"phoneNomal"] forState:UIControlStateNormal];
        [_telBtn setImage:[UIImage imageNamed:@"phoneSelected"] forState:UIControlStateSelected];
        [_telBtn setImage:[UIImage imageNamed:@"phoneSelected"] forState:UIControlStateHighlighted];
        [_telBtn addTarget:self action:@selector(tellCall) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundImageView addSubview:_telBtn];
        
        self.telLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_telBtn.frame)+6, _telBtn.frame.origin.y, ScreenWidth-CGRectGetMaxX(_telBtn.frame)-50, 20)];
        _telLabel.font = [UIFont systemFontOfSize:18.0];
        _telLabel.textAlignment = NSTextAlignmentLeft;
        _telLabel.textColor = UIColorFromRGB(0x4c4c4c, 1.0);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tellCall)];
        _telLabel.userInteractionEnabled = YES;
        [_telLabel addGestureRecognizer:tap];
        
        [_backgroundImageView addSubview:_telLabel];
        
        [self addSubview:_backgroundImageView];
    }
    return self;
}

- (void) tellCall{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_telLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void) setDic:(NSDictionary *)dic{
    _nameLabel.text = dic[@"name"];
    UIFont *font = [UIFont fontWithName:@"Arial" size:21.0];
    _nameLabel.font = font;
    CGSize nameLabelSize = [_nameLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    _nameLabel.frame = CGRectMake(15, 17, nameLabelSize.width, 20);
    
    _categoryLabel.text = dic[@"categories"];
    _categoryLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame)+5, 17, ScreenWidth-_tipView.frame.size.width-CGRectGetMaxX(_nameLabel.frame)-5, 20);
    
    CGFloat productScore = [dic[@"productScore"] floatValue];
    _tipView.productScore = [NSString stringWithFormat:@"%.1f",productScore];
    
    NSString *address = dic[@"address"];
    _addressLabel.text = [NSString stringWithFormat:@"%@",address];
    
    NSString *telString = dic[@"telephone"];
    _telLabel.text = telString;
    
}


@end
