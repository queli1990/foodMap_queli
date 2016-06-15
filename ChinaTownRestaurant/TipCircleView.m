
//
//  TipCircleView.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/28.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "TipCircleView.h"

@interface TipCircleView()
@property (nonatomic,strong) UILabel *label;
@end

@implementation TipCircleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        _imageView.image = [UIImage imageNamed:@"tip"];
        [self addSubview:_imageView];
        
        self.layer.masksToBounds = YES;
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(width*0.2, (height/2)-10, width*1.2, 20)];
        //        _label.backgroundColor = [UIColor redColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = UIColorFromRGB(0x7a1a08, 1.0);
        [self addSubview:_label];
        [UIView animateWithDuration:0 animations:^{
            _label.transform = CGAffineTransformRotate(_label.transform,atan(height/width));
        } completion:^(BOOL finished) {
            _label.transform = CGAffineTransformTranslate(_label.transform,-width*0.2, -5);
        }];
        
    }
    return self;
}

- (void)setProductScore:(NSString *)productScore{
    _productScore = productScore;
    _label.text = productScore;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
