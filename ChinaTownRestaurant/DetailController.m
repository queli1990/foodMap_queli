//
//  ChinaTownDetailController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "DetailController.h"
#import "DetailNavView.h"
#import "DetailShopInfo.h"
#import "DetailCategoryAndEnvironmentView.h"
#import "MapController.h"
#import "DetailRequest.h"
#import "DetailCommentTableViewCell.h"

#import "RegistViewController.h"
#import "DetailCollectionRequest.h"
#import "DetailCommentTableViewController.h"

#import "STPhotoBrowserController.h"
#import "STConfig.h"
#import "UIButton+WebCache.h"

#import "SendCommentViewController.h"
#import "LoginViewController.h"


@interface DetailController ()<UITableViewDelegate,UITableViewDataSource,STPhotoBrowserDelegate,DetailCommentTableViewCellDelegate,sendMessageSuccessAndToRequestData>
@property (nonatomic,strong) DetailNavView *navView;
@property (nonatomic,strong) DetailShopInfo *shopInfoView;
@property (nonatomic,strong) DetailCategoryAndEnvironmentView *categoryAndEnvironmentView;
@property (nonatomic,strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UIPageControl *pageControl; // 页码指示器
//@property (nonatomic) BOOL isCategoryAndEnvironmentViewScrollviewShow;
@property (nonatomic,strong) NSMutableArray *scrollViewImgsArray;
@property (nonatomic,strong) UITableView *commentTableView;

@property (nonatomic,strong) NSMutableArray *arrayButton;
@property (nonatomic, strong, nullable)UIView *currentView; //
@property (nonatomic, strong, nullable)NSArray *currentArray; //
@property (nonatomic) BOOL isScrollViewShow;


@property (nonatomic,strong) NSMutableArray *dishArray;
@property (nonatomic,strong) NSMutableArray *commentArray;
@property (nonatomic,strong) NSMutableArray *couponArray;
@property (nonatomic,strong) NSMutableDictionary *businessDic;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) BOOL isCollected;

@property (nonatomic,strong) NoDataView *nodataView;
@property (nonatomic,strong) GMDCircleLoader *loader;

@end

@implementation DetailController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NSLog(@"%f",_commentTableView.contentOffset.y);
    
    
    _isScrollViewShow = NO;
    for (UIView *view in _currentView.subviews) {
        [view removeFromSuperview];
    }
    [_commentTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setNav];
    
    [self addLoader];
    [self initNodataView];
    
    _currentView = [[UIView alloc] init];
    
    [self requestData:nil];
    
}


- (void) addLoader{
    _loader = [[GMDCircleLoader alloc] initWithFrame:CGRectMake((ScreenWidth-50)/2, (ScreenHeight-50)/2, 50, 50)];
    [_loader start];
    [self.view addSubview:_loader];
}

- (void) initNodataView{
    _nodataView = [[NoDataView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [_nodataView.requestBtn addTarget:self action:@selector(requestDataWithRequestBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) addCommentButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(ScreenWidth-50-15, ScreenHeight-50-15, 50, 50);
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(goToSendCommentPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
}

- (void) goToSendCommentPage:(UITapGestureRecognizer *)tap{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]) {
        SendCommentViewController *vc = [[SendCommentViewController alloc] init];
        vc.delegate = self;//为了实现提交评论后重新请求数据
        vc.thirdid = self.businessId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 发送评论页面，发送评论成功后，返回此页面时，重新请求数据
- (void) sendMessageSuccessAndToRequestCommentData{
    [self requestData:nil];
}

- (void) requestDataWithRequestBtn:(UIButton *)btn{
    [self requestData:nil];
}

- (void) requestData:(NSMutableDictionary *)dic{
    
    [_nodataView removeFromSuperview];
    [self.view addSubview:_loader];
    [_loader start];
    
    DetailRequest *request = [[DetailRequest alloc] init];
    request.businessId = self.businessId;
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    if (userID.length) {
        if (dic == nil) {
            dic = [NSMutableDictionary dictionary];
        }
        [dic setObject:userID forKey:@"userid"];
    }
    
    [request requestData:dic andBlock:^(DetailRequest *responseData) {
        
        [_loader removeFromSuperview];
        
        self.commentArray = (NSMutableArray *)request.commentArray;
        self.dishArray = (NSMutableArray *)request.dishArray;
        self.businessDic = (NSMutableDictionary *)request.businessDic;
        self.isCollected = request.isCollection;
        
        //防止某些id下对应的城市没有数据，如id=2395，则字典返回类型为null
        if (![_businessDic isKindOfClass:[NSDictionary class]]) {
            [self.view addSubview:_nodataView];
            return ;
        }
        
        _navView.chineseTitleLabel.text = self.businessDic[@"name"];
        _navView.englishTitleLabel.text = @"Din Tai Fung";
        
        [self setShopInfo];
        
        [self setCategoryAndEnvironmentView];
        
        [self initTableView];
        
        [self initCommentBtn];
        
        [self reloadNav];
        
        
    } andFailureBlock:^(DetailRequest *responseData) {
        [_loader removeFromSuperview];
        [self.view addSubview:_nodataView];
        
    }];
}

- (void) reloadNav{
    _navView.collectionBtn.userInteractionEnabled = YES;
    if (_isCollected) {
        _navView.collectionBtn.selected = YES;
    }else{
        _navView.collectionBtn.selected = NO;
    }
}

- (void) initCommentBtn{
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-44, ScreenWidth, 44)];
    commentView.backgroundColor = UIColorFromRGB(0xF9F9F9, 1.0);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-16-90-10)/2, (44-14)/2 , 16, 14)];
    imageView.image = [UIImage imageNamed:@"comment"];
    imageView.userInteractionEnabled = YES;
    [commentView addSubview:imageView];
    
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, (44-20)/2, 20, 20)];
    commentLabel.textColor = UIColorFromRGB(0x808080, 1.0);
    commentLabel.textAlignment = NSTextAlignmentLeft;
    commentLabel.text = @"点评此商家";
    UIFont *font = [UIFont fontWithName:@"Arial" size:18];
    commentLabel.font = font;
    CGSize labelSize = [commentLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];//90宽
    commentLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+10, 10, labelSize.width, 25);
    
    [commentView addSubview:commentLabel];
    [self.view addSubview:commentView];
    
    UITapGestureRecognizer *tapToComment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSendCommentPage:)];
    [commentView addGestureRecognizer:tapToComment];
}

- (void) initTableView
{
    _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-44) style:UITableViewStyleGrouped];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.separatorColor = [UIColor clearColor];
    [_commentTableView registerClass:[DetailCommentTableViewCell class] forCellReuseIdentifier:@"DetailCommentTableViewCell"];
    [self.view addSubview:_commentTableView];
}

#pragma mark UITableViewDelegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger count = 1;//默认有一个店铺信息
    if (self.dishArray.count) count++;
    if (self.commentArray.count) count++;
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 0;
    if (section == 1) return 0;
    if (section == 2 && self.commentArray.count) return self.commentArray.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    DetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCommentTableViewCell" forIndexPath:indexPath];
    DetailCommentTableViewCell *cell = [[DetailCommentTableViewCell alloc] init];
    
    cell.model = self.commentArray[indexPath.row];
    _cellHeight = [cell heightForCell];
    cell.delegate = self;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Detail_Comment *model = _commentArray[indexPath.row];
    DetailCommentTableViewController *vc = [[DetailCommentTableViewController alloc] init];
    vc.modle = model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void) DetailCommentPhotoTableViewCell:(DetailCommentTableViewCell *)cell currentItem:(NSInteger)currentItem{
    //启动图片浏览器
    NSLog(@"%f",_commentTableView.contentOffset.y);
    
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
//    browserVc.sourceImagesContainerView = cell.contentView; // 原图的父控件
    browserVc.sourceImagesContainerView = _currentView; // 不能用上面的这行代码！！
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


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) return _shopInfoView;
    if (section == 1) {
        if (_dishArray.count) {
            return _categoryAndEnvironmentView;
        }else{
            UIView *viewForDish = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
            viewForDish.backgroundColor = [UIColor clearColor];
            return viewForDish;
        }
    }
    if (section == 2) {
        UIView *viewForDish = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        viewForDish.backgroundColor = UIColorFromRGB(0xf0f0f0, 1.0);
        return viewForDish;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return ScreenWidth*1449/3726;
    if (section == 1) {
        if (_dishArray.count) {
            return 120;
        }else{
            return 1;
        }
    }
    if (section == 2) return 1;
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0 || section==1 || section==2 || section==3) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        footView.backgroundColor = UIColorFromRGB(0xf0f0f0, 1.0);
        return footView;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}


//菜品和环境
- (void) setCategoryAndEnvironmentView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    
    self.categoryAndEnvironmentView = [[DetailCategoryAndEnvironmentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    _categoryAndEnvironmentView.categoryBtn.hidden = YES;
    _categoryAndEnvironmentView.environmentBtn.hidden = YES;
    _categoryAndEnvironmentView.separateLineView.hidden = YES;
    
    self.scrollViewImgsArray = [NSMutableArray array];
    
    for (int i = 0; i<self.dishArray.count; i++) {
        Detail_DishModel *model = self.dishArray[i];
        [self.scrollViewImgsArray addObject:model.photoUrl];
    }
    
    __block CGFloat buttonW = (ScreenWidth - STMargin * 4)/3;
    __block CGFloat buttonH = buttonW;
    __block CGFloat buttonX = 0;
    __block CGFloat buttonY = 0;
    
    [self.scrollViewImgsArray enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
        buttonX = STMargin + (idx) * (buttonW + STMarginSmall);
        buttonY = (idx / 3) * (buttonH + STMarginSmall);
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX,
                                                                     (120-buttonH)/2,
                                                                     buttonW,
                                                                     buttonH)];
        button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        button.clipsToBounds = YES;
        [button sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                          forState:UIControlStateNormal
                  placeholderImage:[UIImage imageNamed:@"placeholder_1_1"]];
        
        [button setTag:idx];
        [button addTarget:self
                   action:@selector(buttonClick:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        [self.arrayButton addObject:button];
    }];
    
    
    [self.scrollView setContentSize:CGSizeMake((self.scrollViewImgsArray.count)* (buttonH +STMarginSmall)+STMarginSmall*2,0)];
    [_categoryAndEnvironmentView addSubview:_scrollView];
    
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(STPhotoBrowserController *)browser placeholderImageForIndex:(NSInteger)index
{
    if (_isScrollViewShow) {
        return [self.scrollView.subviews[index] currentImage];
        _isScrollViewShow = NO;
    }else{
        if ([self.currentView.subviews[index] isKindOfClass:[UIButton class]]) {
            return [self.currentView.subviews[index] currentImage];
        }else{
            return nil;
        }
    }
}

- (NSURL *)photoBrowser:(STPhotoBrowserController *)browser highQualityImageURLForIndex:(NSInteger)index
{
    if (_isScrollViewShow) {
        NSString *urlStr = self.scrollViewImgsArray[index];
        return [NSURL URLWithString:urlStr];
        _isScrollViewShow = NO;
    }else{
        NSString *urlStr = self.currentArray[index];
        return [NSURL URLWithString:urlStr];
    }
}


#pragma mark - event response 事件相应

- (void)buttonClick:(UIButton *)button
{
    _isScrollViewShow = YES;
    //启动图片浏览器
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
    browserVc.sourceImagesContainerView = self.scrollView; // 原图的父控件
    browserVc.countImage = self.scrollViewImgsArray.count; // 图片总数
    browserVc.currentPage = (int)button.tag;
    browserVc.delegate = self;
    [browserVc show];
}


//商家信息
- (void) setShopInfo{
    self.shopInfoView = [[DetailShopInfo alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*1449/3726)];
    _shopInfoView.dic = self.businessDic;
    
    UITapGestureRecognizer *goMapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushMapController:)];
    [_shopInfoView.backgroundImageView addGestureRecognizer:goMapTap];
    
}

- (void) setNav{
    self.navView = [[DetailNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.englishTitleLabel.hidden = YES;
    [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.collectionBtn addTarget:self action:@selector(collectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _navView.shareBtn.hidden = YES;
    _navView.collectionBtn.userInteractionEnabled = NO;
    [self.view addSubview:_navView];
}

- (void) collectionBtnClick:(UIButton *)btn{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    if (userID.length) {
        btn.selected = !btn.selected;
        
        btn.userInteractionEnabled = NO;
        NSLog(@"目前不能取消收藏，顾把btn设置为不可点击状态");
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.businessId forKey:@"businessId"];
        [dic setObject:userID forKey:@"userId"];
        if (btn.selected) {
            
            [[DetailCollectionRequest alloc] requestData:dic andBlock:^(DetailCollectionRequest *responseData) {
                btn.userInteractionEnabled = YES;
                btn.selected = YES;
                
            } andFailureBlock:^(DetailCollectionRequest *responseData) {
                btn.userInteractionEnabled = YES;
                btn.selected = NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }];
            
        }else{
            NSLog(@"取消收藏");
            
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager DELETE:[NSString stringWithFormat:@"http://i.vego.tv:2048/api/collects/%@.json",userID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dic);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
    }else{
        RegistViewController *vc = [[RegistViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSMutableArray *)scrollViewImgsArray{
    if (_scrollViewImgsArray == nil) {
        _scrollViewImgsArray = [NSMutableArray array];
    }
    return _scrollViewImgsArray;
}



- (void) backToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushMapController:(UITapGestureRecognizer *)tap{
    MapController *vc = [[MapController alloc] init];
    vc.lat = [_businessDic[@"lat"] floatValue];
    vc.lng = [_businessDic[@"lng"] floatValue];
    vc.title = _businessDic[@"name"];
    vc.subTitle = _businessDic[@"categories"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSMutableArray *)couponArray{
    if (_couponArray == nil) {
        _couponArray = [NSMutableArray array];
    }
    return _couponArray;
}

- (NSMutableArray *)commentArray{
    if (_commentArray == nil) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

- (NSMutableArray *)dishArray{
    if (_dishArray == nil) {
        _dishArray = [NSMutableArray array];
    }
    return _dishArray;
}

- (NSMutableArray *)arrayButton
{
    if (!_arrayButton) {
        _arrayButton = [NSMutableArray array];
    }
    return _arrayButton;
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
