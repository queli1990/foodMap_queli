//
//  DetailCommentTableViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/25.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "DetailCommentTableViewController.h"
#import "RecommendListNavView.h"
#import "CommentDetailTableViewCell.h"
#import "STPhotoBrowserController.h"

@interface DetailCommentTableViewController ()<UITableViewDelegate,UITableViewDataSource,CommentDetailTableViewCellDelegate,STPhotoBrowserDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) RecommendListNavView *navView;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic, strong, nullable)NSArray *currentArray; //
@property (nonatomic, strong, nullable)UIView *currentView; //

@property (nonatomic,strong) UIView *commentView;
@property (nonatomic,strong) UITextField *commentTextField;

@end

@implementation DetailCommentTableViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *view in _currentView.subviews) {
        [view removeFromSuperview];
    }
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    
    [self initTableView];
    
    _currentView = [[UIView alloc] init];
    
//    [self initCommentView];
}

- (void) initCommentView{
    self.commentView = [[UIView alloc] initWithFrame:CGRectMake(15, ScreenHeight-40, ScreenWidth-30, 40)];
    _commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, ScreenWidth-30, 30)];
    _commentTextField.placeholder = @"写点评论吧";
    _commentTextField.font = [UIFont systemFontOfSize:16.0];
    _commentTextField.textAlignment = NSTextAlignmentLeft;
    _commentTextField.textColor = [UIColor blackColor];
    _commentTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _commentTextField.backgroundColor = [UIColor clearColor];
    _commentTextField.borderStyle = UITextBorderStyleRoundedRect;
    _commentTextField.delegate = self;
    [_commentView addSubview:_commentTextField];
    [self.view addSubview:_commentView];
}

#pragma UITextViewDelegate
- (void) textFieldDidBeginEditing:(UITextField *)textField{
    if (ScreenWidth == 320) {
        _commentView.frame = CGRectMake(15, ScreenHeight-253-50, ScreenWidth-30, 40);
    }else if (ScreenWidth == 375){
        _commentView.frame = CGRectMake(15, ScreenHeight-258-50, ScreenWidth-30, 40);
    }else{
        _commentView.frame = CGRectMake(15, ScreenHeight-271-50, ScreenWidth-30, 40);
    }
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    _commentView.frame = CGRectMake(15, ScreenHeight-40, ScreenWidth-30, 40);
    [_commentTextField resignFirstResponder];
    
    if (_commentTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入评论内容" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
    }
    return YES;
}



- (void) setNav{
    _navView = [[RecommendListNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.searchBtn.hidden = YES;
    _navView.titleLabel.text = @"评论详情";
    _navView.titleLabel.textColor = [UIColor whiteColor];
    _navView.backgroundColor = [UIColor blackColor];
    [_navView.backBtn addTarget: self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
}

- (void) initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[CommentDetailTableViewCell class] forCellReuseIdentifier:@"CommentDetailTableViewCell"];
    [self.view addSubview:_tableView];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentDetailTableViewCell" forIndexPath:indexPath];
    cell.model = self.modle;
    _cellHeight = [cell heightForCell];
    cell.delegate = self;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void) DetailCommentPhotoTableViewCell:(CommentDetailTableViewCell *)cell currentItem:(NSInteger)currentItem{
    //启动图片浏览器
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
    browserVc.sourceImagesContainerView = _currentView; // 原图的父控件
    browserVc.countImage = cell.arrayImageUrl.count; // 图片总数
    
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [self.currentView addSubview:view];
        }
    }
    
    self.currentArray = cell.arrayImageUrl;
    
    browserVc.currentPage = currentItem;
    browserVc.delegate = self;
    [browserVc show];
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(STPhotoBrowserController *)browser placeholderImageForIndex:(NSInteger)index
{
    if ([self.currentView.subviews[index] isKindOfClass:[UIButton class]]) {
        return [self.currentView.subviews[index] currentImage];
    }else{
        return nil;
    }
}

- (NSURL *)photoBrowser:(STPhotoBrowserController *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.currentArray[index];
    return [NSURL URLWithString:urlStr];
}



- (void) backToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
