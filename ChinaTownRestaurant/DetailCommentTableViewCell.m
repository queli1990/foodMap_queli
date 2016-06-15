//
//  DetailCommentTableViewCell.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/20.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "DetailCommentTableViewCell.h"
#import "CommentPhotoImageView.h"
#import "STPhotoBrowserController.h"
#import "STConfig.h"
#import "UIButton+WebCache.h"

@implementation DetailCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = UIColorFromRGB(0xffffff, 1.0);
        
        UIView *whiteLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        whiteLineView.backgroundColor = UIColorFromRGB(0xcccccc, 1.0);
        [_bottomView addSubview:whiteLineView];
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.contentView.layer setMasksToBounds:YES];
        [self.layer setMasksToBounds:YES];
        
        CGFloat top = 15;
        
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, top, 55, 55)];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
        [_bottomView addSubview:_headImageView];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-10-60, 15, 60, 15)];
        _dateLabel.font = [UIFont systemFontOfSize:12.0];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.textColor = [UIColor whiteColor];
        [_bottomView addSubview:_dateLabel];
        
        
//        CGFloat marginY = (50-20-15)/3;
        self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, 20, ScreenWidth-10-55-10-10-_dateLabel.frame.size.width, 20)];
        _nickNameLabel.font = [UIFont systemFontOfSize:19.0];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        _nickNameLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        [_bottomView addSubview:_nickNameLabel];
        
        self.evaluateLabel = [[UILabel alloc] init];
        _evaluateLabel.text = @"打分:";
        _evaluateLabel.textColor = UIColorFromRGB(0x808080, 1.0);
        UIFont *font = [UIFont fontWithName:@"Arial" size:14];
        _evaluateLabel.font = font;
        CGSize labelSize = [_evaluateLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
        _evaluateLabel.frame = CGRectMake(_nickNameLabel.frame.origin.x, CGRectGetMaxY(_nickNameLabel.frame)+9, labelSize.width, 15);
        [_bottomView addSubview:_evaluateLabel];
        
        
        _evaluateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_evaluateLabel.frame)+5, _evaluateLabel.frame.origin.y, 128*0.4, 42*0.4)];//高度固定，宽度需要调整
        _evaluateImageView.image = [UIImage imageNamed:@"evaluate"];
        
        _evaluateLabelOnImageView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _evaluateImageView.frame.size.width, _evaluateImageView.frame.size.height)];
        _evaluateLabelOnImageView.font = [UIFont systemFontOfSize:12.0];
        _evaluateLabelOnImageView.textColor = [UIColor whiteColor];
        _evaluateLabelOnImageView.textAlignment = NSTextAlignmentCenter;
        _evaluateLabelOnImageView.backgroundColor = [UIColor clearColor];
        [_evaluateImageView addSubview:_evaluateLabelOnImageView];
        [_bottomView addSubview:_evaluateImageView];
        
        
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nickNameLabel.frame.origin.x, CGRectGetMaxY(_evaluateImageView.frame)+15, ScreenWidth-_headImageView.frame.size.width-15*2-5, 20)];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.textColor = [UIColor grayColor];
        _commentLabel.font = [UIFont systemFontOfSize:12.0];
        _commentLabel.numberOfLines = 0;
        [_bottomView addSubview:_commentLabel];
        
        [self.contentView addSubview:_bottomView];
        
        _arrayImageUrl = [NSMutableArray array];
        _arrayButton = [NSMutableArray array];
        
    }
    
    return self;
}

- (void) setModel:(Detail_Comment *)model{
    
    _model = model;
    
    NSString *timeInterval = [NSString stringWithFormat:@"%ld",model.createtime.integerValue/1000];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval.integerValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"MM月dd日"];
    _dateLabel.text = [formatter stringFromDate:date];
    
    CGFloat decoration = model.decorationscore.floatValue;
    _evaluateLabelOnImageView.text = [NSString stringWithFormat:@"%.1f",decoration];
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.userAvatar] placeholderImage:[UIImage imageNamed:@"head_placeholder"]];
    _nickNameLabel.text = model.username;
    
    _commentLabel.text = model.comment;
    
    CGSize size = [self.commentLabel.text boundingRectWithSize:CGSizeMake(self.commentLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.commentLabel.font} context:nil].size;
    CGRect frame = self.commentLabel.frame;
    
    if (size.height >= 45) {
//        _commentLabel.numberOfLines = 3;
        frame.size.height = 45;
    }else{
        frame.size.height = size.height;
    }
    self.commentLabel.frame = frame;
    
    
    _count = model.photoList.count;
    //判断是否有图片，同时判断图片的个数
    if (model.photoList.count) {
        
        [_arrayImageUrl removeAllObjects];
        [_arrayButton removeAllObjects];
        
        for (int i = 0; i<model.photoList.count; i++) {
            NSDictionary *photo = model.photoList[i];
            [self.arrayImageUrl addObject:photo[@"photoUrl"]];
        }
        
        if (model.photoList.count > self.arrayButton.count) {
            
            [_arrayImageUrl enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CGFloat buttonW = (ScreenWidth-_commentLabel.frame.origin.x-30-10*3)/3;
                CGFloat buttonH = buttonW*2/3;
                CGFloat buttonX = _commentLabel.frame.origin.x+idx*(10+buttonW);
                CGFloat buttonY = CGRectGetMaxY(_commentLabel.frame)+10;
                
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX,
                                                                             buttonY,
                                                                             buttonW,
                                                                             buttonH)];
                button.imageView.contentMode = UIViewContentModeScaleAspectFill;
                button.clipsToBounds = YES;
                [button sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                                  forState:UIControlStateNormal
                          placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
                [button addTarget:self
                           action:@selector(buttonClick:)
                 forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:button];
                [self.arrayButton addObject:button];
                
                if (idx > 2) {
                    button.hidden = YES;
                }
                
            }];
        }
        
    }else{
        
        for (UIView *view in self.contentView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                [view removeFromSuperview];
            }
        }
    }
}

- (void)buttonClick:(UIButton *)button
{
    [self.arrayButton enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (btn == button) {
//            NSLog(@"%s, %lu, %@", __FUNCTION__, (unsigned long)idx, self.contentView);
            
            [self.delegate DetailCommentPhotoTableViewCell:self currentItem:idx];
        }
    }];
}

- (CGFloat) heightForCell{
    
    if (_count) {
        CGFloat commentPhotoWith = ((ScreenWidth-CGRectGetMaxX(_headImageView.frame)-30)-2*gap)/3;
        CGFloat commentPhotoHeight = commentPhotoWith*2/3;
        _bottomView.frame = CGRectMake(0, 0, ScreenWidth, CGRectGetMaxY(_commentLabel.frame)+10+commentPhotoHeight+10);
        return CGRectGetMaxY(_commentLabel.frame)+10+commentPhotoHeight+10;
    }else{
        _bottomView.frame = CGRectMake(0, 0, ScreenWidth, CGRectGetMaxY(_commentLabel.frame)+10);
        return CGRectGetMaxY(_commentLabel.frame)+10;
    }
    return 100;
}


- (NSMutableArray *)arrayButton
{
    if (!_arrayButton) {
        _arrayButton = [NSMutableArray array];
    }
    return _arrayButton;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
