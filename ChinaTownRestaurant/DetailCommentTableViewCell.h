//
//  DetailCommentTableViewCell.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/20.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Detail_Comment.h"
#import "Detail_Comment_PhotoListModel.h"

@class DetailCommentTableViewCell;
@protocol DetailCommentTableViewCellDelegate <NSObject>
- (void) DetailCommentPhotoTableViewCell:(DetailCommentTableViewCell *)cell currentItem:(NSInteger) currentItem;
@end


@interface DetailCommentTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nickNameLabel;

@property (nonatomic,strong) UILabel *evaluateLabel;
@property (nonatomic,strong) UIImageView *evaluateImageView;
@property (nonatomic,strong) UILabel *evaluateLabelOnImageView;

@property (nonatomic,strong) UILabel *dateLabel;

@property (nonatomic,strong) UILabel *commentLabel;


@property (nonatomic) NSInteger count;


@property (nonatomic,strong) Detail_Comment *model;

@property (nonatomic,weak) id <DetailCommentTableViewCellDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *arrayImageUrl;
@property (nonatomic,copy) NSMutableArray *arrayButton;

- (CGFloat) heightForCell;
- (void)DetailCommentTableViewCell:(DetailCommentTableViewCell *)cell currentItem:(NSInteger)currentItem;


@end
