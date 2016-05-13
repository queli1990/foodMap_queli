//
//  CommentDetailTableViewCell.h
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/25.
//  Copyright © 2016年 QL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Detail_Comment.h"


@class CommentDetailTableViewCell;
@protocol CommentDetailTableViewCellDelegate <NSObject>
- (void) DetailCommentPhotoTableViewCell:(CommentDetailTableViewCell *)cell currentItem:(NSInteger) currentItem;
@end

@interface CommentDetailTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UILabel *commentLabel;

@property (nonatomic) NSInteger count;

@property (nonatomic) CGFloat maxHeight;

@property (nonatomic,strong) Detail_Comment *model;

@property (nonatomic,weak) id <CommentDetailTableViewCellDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *arrayImageUrl;
@property (nonatomic,copy) NSMutableArray *arrayButton;

- (CGFloat) heightForCell;
- (void)DetailCommentTableViewCell:(CommentDetailTableViewCell *)cell currentItem:(NSInteger)currentItem;



@end
