//
//  CommentDetailTableViewCell.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/25.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "CommentDetailTableViewCell.h"
#import "STPhotoBrowserController.h"
#import "STConfig.h"
#import "UIButton+WebCache.h"


@implementation CommentDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView.layer setMasksToBounds:YES];
        
        [self.layer setMasksToBounds:YES];
        
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
        [self.contentView addSubview:_headImageView];
        
        self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+5, 10+(50-20)/2, 150, 20)];
        _nickNameLabel.font = [UIFont systemFontOfSize:14.0];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        _nickNameLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_nickNameLabel];
        
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nickNameLabel.frame.origin.x, CGRectGetMaxY(_headImageView.frame), ScreenWidth-_headImageView.frame.size.width-15*2-5, 20)];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.textColor = [UIColor grayColor];
        _commentLabel.font = [UIFont systemFontOfSize:12.0];
        _commentLabel.numberOfLines = 0;
        [self.contentView addSubview:_commentLabel];
        
        _arrayImageUrl = [NSMutableArray array];
        _arrayButton = [NSMutableArray array];
        
    }
    
    return self;
}


- (void) setModel:(Detail_Comment *)model{
    
    _model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.userAvatar] placeholderImage:[UIImage imageNamed:@"TVLog"]];
    _nickNameLabel.text = model.username;
    
    _commentLabel.text = model.comment;
    CGSize size = [self.commentLabel.text boundingRectWithSize:CGSizeMake(self.commentLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.commentLabel.font} context:nil].size;
    CGRect frame = self.commentLabel.frame;
    frame.size.height = size.height;
    
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
        
        NSInteger kRowNumber = 3;//每行有多少个
//        NSInteger row = _count/kRowNumber;//行
//        NSInteger col = _count%kRowNumber;//列
        
//        for (NSInteger i = 0; i<_count; i++) {
        
            
            [_arrayImageUrl enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSInteger row = idx/kRowNumber;//行
                NSInteger col = idx%kRowNumber;//列
                CGFloat boradY = 10;//首个距顶部的距离
                CGFloat boradX = 10;//首个距左边的距离
                CGFloat marginX = 5;//两个button之间的左右距离
                CGFloat marginY = 5;//两个button之间的上下距离
                CGFloat buttonW = (ScreenWidth-_commentLabel.frame.origin.x-30-10*3)/3;
                CGFloat buttonH = buttonW*2/3;
                
                CGFloat buttonX = boradX+col*(buttonW+marginX)+_commentLabel.frame.origin.x;
                CGFloat buttonY = boradY+row*(buttonH+marginY)+CGRectGetMaxY(_commentLabel.frame);
                
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX,
                                                                             buttonY,
                                                                             buttonW,
                                                                             buttonH)];
                _maxHeight = buttonY+buttonH;
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
            }];
        }
//    }
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
//        CGFloat commentPhotoWith = ((ScreenWidth-CGRectGetMaxX(_headImageView.frame)-30)-2*gap)/3;
//        CGFloat commentPhotoHeight = commentPhotoWith*2/3;
//        return CGRectGetMaxY(_commentLabel.frame)+10+commentPhotoHeight+10;
        return _maxHeight+10;
    }else{
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
