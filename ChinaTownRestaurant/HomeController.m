//
//  ChinaTownHomeController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeController.h"
#import "HomeNavView.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "HomeHeadModel.h"
#import "RecommendListController.h"
#import "HomeCityListViewController.h"
#import "LoginViewController.h"
#import "PersonalViewController.h"
#import "SearchViewController.h"
#import "HomeBigRequest.h"
#import "NoResultView.h"
#import "DetailController.h"
#import "HomeHeadButton.h"
#import "UIButton+WebCache.h"
#import <Accelerate/Accelerate.h>


@interface HomeController ()<UITableViewDelegate,UITableViewDataSource,passCityNameDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) HomeNavView *navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableArray *headDatas;
@property (nonatomic,strong) UIScrollView *headView;
@property (nonatomic,strong) NSUserDefaults *user;

@property (nonatomic) BOOL isDeleteOriginalData;
@property (nonatomic) BOOL isFormChooseCity;
@property (nonatomic,strong) NoDataView *nodataView;
@property (nonatomic,strong) GMDCircleLoader *loader;
@property (nonatomic,strong) NoResultView *noResultView;
@property (nonatomic,strong) UIImageView *background;

@property (nonatomic) CGFloat cellHeight;

@end

@implementation HomeController


- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_tableView.contentOffset.y<64) {
        CGFloat clear = _tableView.contentOffset.y;
        CGFloat z = -clear;
        
        _background.image = [[UIImage imageNamed:@"clearHomeBackground"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.background.image = [self boxblurImage:self.background.image withBlurNumber:(0.9-(z/200))];
    }

}

- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    _background.image = [[UIImage imageNamed:@"clearHomeBackground"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.background.image = [self boxblurImage:self.background.image withBlurNumber:0.9];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    _defauletCityModel = [[HomeCityListModel alloc] init];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _user = [NSUserDefaults standardUserDefaults];
    
    _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _background.contentMode = UIViewContentModeScaleAspectFill;
    _background.image = [[UIImage imageNamed:@"clearHomeBackground"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.background.image = [self boxblurImage:self.background.image withBlurNumber:0.9];
    self.background.clipsToBounds=YES;
    [self.view addSubview:_background];
    
    [self setNav];
    
    [self initTableView];
    
    [self addLoader];
    [self initNodataView];
    [self initNoResultView];
    
    _page = 1;
    _rows = 10;
    self.params = [NSMutableDictionary dictionary];
    [self setParams];
    
    [self requestWithDictionary:_params];


    //如果首次启动时，不能滑动
//    for (UIGestureRecognizer *gesture in self.navigationController.view.gestureRecognizers) {
//        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
//            [self.navigationController.view removeGestureRecognizer:gesture];
//        }
//    }
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_loader) {
        [_loader start];
    }
}

- (void) addLoader{
    _loader = [[GMDCircleLoader alloc] initWithFrame:CGRectMake((ScreenWidth-50)/2, (ScreenHeight-50)/2, 50, 50)];
    [_loader start];
    [self.view addSubview:_loader];
}

- (void) initNoResultView{
    self.noResultView = [[NoResultView alloc] initWithFrame:CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-40)];
}

- (void) initNodataView{
    _nodataView = [[NoDataView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [_nodataView.requestBtn addTarget:self action:@selector(requestData:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) requestData:(UIButton *)btn{
    [self setParams];
    [self.view addSubview:_loader];
    [_loader start];
    [self requestWithDictionary:_params];
}

- (void) setParams{
//    [_params setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"page"];
//    [_params setObject:[NSString stringWithFormat:@"%d",_rows] forKey:@"rows"];
    [_params setObject:[NSString stringWithFormat:@"%@",self.defauletCityModel.city] forKey:@"city_id"];
    [_params setObject:@"json" forKey:@"format"];
}

- (void) requestWithDictionary:(NSMutableDictionary *)dic{
    
    [_nodataView removeFromSuperview];
    [_noResultView removeFromSuperview];
    
    [[HomeBigRequest alloc] requestData:dic andBlock:^(HomeBigRequest *responseData) {
        
        [_loader removeFromSuperview];
        //存城市列表
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData._data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic_array = dic[@"data"];
        NSArray *array = dic_array[@"cities"];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"citysListDic"];//没有转化成模型
        
        self.headDatas = (NSMutableArray *)responseData.homeHeadArray;
        if (_headDatas.count) {
            [self setTableViewHeadView];
        }
        
        if (responseData.homeCellArray.count) {
            if (_isDeleteOriginalData || _isFormChooseCity) {
                [_datas removeAllObjects];
            }
            
            [self.datas addObjectsFromArray:responseData.homeCellArray];
            
            if (_tableView.hidden) _tableView.hidden = NO;
            
            [_tableView reloadData];
            
            [_tableView.mj_header endRefreshing];
            
            int count;
            if (responseData.totoalCount.intValue % self.rows == 0) {
                count = responseData.totoalCount.intValue / self.rows;
            }else{
                count = responseData.totoalCount.intValue / self.rows + 1;
            }
            
            if (self.page >= count) {
                [_tableView.mj_footer removeFromSuperview];
            }else{
                [self addTableViewFooter];
            }
        }else{
            _tableView.hidden = YES;
            [self.view addSubview:_noResultView];
            if (TARGET_IPHONE_SIMULATOR) NSLog(@"请求成功，但是没有数据");
        }
        _isDeleteOriginalData = NO;
        _isFormChooseCity = NO;
        
    } andFailureBlock:^(HomeBigRequest *responseData) {
        _tableView.hidden = YES;
        [_loader removeFromSuperview];
        [self.view addSubview:_nodataView];
        
        if (TARGET_IPHONE_SIMULATOR) NSLog(@"列表页请求失败");
        _isDeleteOriginalData = NO;
    }];
    
}

- (void) addTableViewFooter{
    _page ++;
    [self setParams];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestWithDictionary:_params];
    }];
}

- (void) initTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"ChinaTownRestaurantTableViewCell"];
    
    [self.view addSubview:_tableView];
    
    //设置刷新头
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isDeleteOriginalData = YES;
        _page = 1;
        [self setParams];
        [weakSelf requestWithDictionary:_params];
    }];
    [self.tableView.mj_header endRefreshing];
    
    _tableView.hidden = YES;
}

- (void) setTableViewHeadView{
    int defultCount = 3;
    CGFloat boradX = 40;//首个距左边的距离
    CGFloat boradY = 20;//首个距顶部的距离
    CGFloat marginX = 60;//两个button之间的左右距离
    CGFloat marginY = 20;//两个button之间的上下距离
    CGFloat buttonW = (ScreenWidth-marginX*(defultCount-1)-boradX*2)/defultCount;
    CGFloat buttonH = buttonW*5/4;
    _headView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, buttonH*2+boradY*3)];
    _headView.backgroundColor = [UIColor clearColor];
    
    
    for (int i = 0 ; i<self.headDatas.count ; i++) {
        HomeHeadModel *model = _headDatas[i];
        
        NSInteger row = i/defultCount;//行
        NSInteger col = i%defultCount;//列
        CGFloat buttonX = boradX+col*(buttonW+marginX);
        CGFloat buttonY = boradY+row*(buttonH+marginY);
        
        HomeHeadButton *btn = [HomeHeadButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        btn.tag = 1000+i;
        
        [btn setTitle:model.category_name forState:UIControlStateNormal];
        
        if (ScreenWidth == 320) {
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        }
        
        [btn.titleLabel sizeToFit];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
//        [btn sd_setImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal];//从接口请求的图片，替换为下面这行代码
        if ([model.category_name isEqualToString:@"小吃面食"]) {
            [btn setImage:[UIImage imageNamed:@"SnackFood"] forState:UIControlStateNormal];
        }else if ([model.category_name isEqualToString:@"粤菜"]){
            [btn setImage:[UIImage imageNamed:@"GuangDongFood"] forState:UIControlStateNormal];
        }else if ([model.category_name isEqualToString:@"川菜"]){
            [btn setImage:[UIImage imageNamed:@"SiChuanFood"] forState:UIControlStateNormal];
        }else if([model.category_name isEqualToString:@"东北菜"]){
            [btn setImage:[UIImage imageNamed:@"DongBeiFood"] forState:UIControlStateNormal];
        }else if([model.category_name isEqualToString:@"江浙菜"]){
            [btn setImage:[UIImage imageNamed:@"JiangZheFood"] forState:UIControlStateNormal];
        }else if ([model.category_name isEqualToString:@"全部"]){
            [btn setImage:[UIImage imageNamed:@"AllFood"] forState:UIControlStateNormal];
        }
        
        
        [btn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:btn];
        
    }
    
    _headView.pagingEnabled = YES;
    if (_headDatas.count%6 == 0) {
        _headView.contentSize = CGSizeMake(_headDatas.count/6,0);
    }else{
        _headView.contentSize = CGSizeMake(ScreenWidth*(_headDatas.count/6+1),0);
    }
    
    _tableView.tableHeaderView = _headView;
}

- (void) headBtnClick:(UIButton *)btn{
    HomeHeadModel *model = _headDatas[btn.tag-1000];
    
    RecommendListController *vc =[[RecommendListController alloc] init];
    vc.cityId = self.defauletCityModel.city;
    if (![model.category_name isEqualToString:@"全部"]) vc.foodCategory = model.category_name;
    vc.isFormSearchPage = NO;
    
    vc.chooseCategoryCount = btn.tag-1000;
    vc.chooseCategoryArray = _headDatas;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark TableViewDelegate
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChinaTownRestaurantTableViewCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell取消点中效果颜色
    _cellHeight = [cell homeCellHeight];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return _cellHeight;
    return ScreenWidth*9/16+50;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void) setNav{
    _navView = [[HomeNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    
    NSString *userLastChooseCityId = [_user objectForKey:@"userLastChooseCityId"];
    NSString *userLastChooseCity = [_user objectForKey:@"userLastChooseCity"];
    
    if (userLastChooseCity.length == 0) {
        self.defauletCityModel.city_name = @"纽约";
        self.defauletCityModel.city = @"2395";
    }else{
        self.defauletCityModel.city_name = userLastChooseCity;
        self.defauletCityModel.city = userLastChooseCityId;
    }
    _navView.cityLabel.text = self.defauletCityModel.city_name;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentCityTableView:)];
    [_navView.cityView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *goSearchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSearchPage:)];
    [_navView.searchView addGestureRecognizer:goSearchTap];
    
    [_navView.personalBtn addTarget:self action:@selector(goToPersonal:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_navView];
}

- (void) goSearchPage:(UITapGestureRecognizer *)tap{
    SearchViewController *vc = [[SearchViewController alloc] init];
    vc.cityId = self.defauletCityModel.city;
    vc.chooseArray = self.headDatas;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) presentCityTableView:(UITapGestureRecognizer *)tap{
    HomeCityListViewController *vc = [[HomeCityListViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HomeModel *model = _datas[indexPath.row];
    DetailController *vc = [[DetailController alloc] init];
    vc.businessId = model.businessId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSMutableArray *)headDatas{
    if (_headDatas == nil) {
        _headDatas = [NSMutableArray array];
        
    }
    return _headDatas;
}

- (NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

#pragma 城市选择列表 --> 代理
- (void) passCity:(HomeCityListModel *)model{
    _navView.cityLabel.text = model.city_name;
    
    self.defauletCityModel = model;
    _page = 1;
    _isFormChooseCity = YES;
    
    [self setParams];
    [self.view addSubview:_loader];
    [_loader start];
    [self requestWithDictionary:_params];
    _tableView.contentOffset = CGPointMake(0, 0);
}

- (void) goToPersonal:(UIButton *)btn{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userNickName"]) {
        PersonalViewController *vc = [[PersonalViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    //模糊度
    if (blur < 0.f) {
        blur = 0.0f;
    }
    if (blur >0.99f) {
        blur = 0.99;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    //图像处理
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    //    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
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
