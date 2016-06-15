//
//  ChinaTownHomeCityListViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeCityListViewController.h"
#import "HomeCityListTableViewCell.h"
#import "HomeCityListRequest.h"
#import "NoResultView.h"


@interface HomeCityListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *tableView;
//@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) NoResultView *noResultView;

@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) UIImageView *searchImageView;
@property (nonatomic,strong) NSMutableArray *searchResultArray;

@end

@implementation HomeCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initNav];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"citysListDic"];
    self.datas = (NSMutableArray *)[HomeCityListModel modelsWithArray:array];
    [self initTableView];
    
//    [self requestDataWithDic:nil];//数据从首页拿过来直接使用，不需要请求数据
    
    //nav不用搜索框了，如果要将下面2行代码解开
//    [self setSearch];
    
//    [self setNoResultView];
}

- (void) setNoResultView{
    self.noResultView = [[NoResultView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    _noResultView.backgroundColor = [UIColor blackColor];
}

- (void) setSearch{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(ScreenWidth-28-17-15, 20+(44-28)/2, 28, 28);
    [backBtn setImage:[UIImage imageNamed:@"CityList_backHeighted"] forState:UIControlStateHighlighted];
    [backBtn setImage:[UIImage imageNamed:@"CityList_backNormal"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    CGFloat scale = 28.00/68.00;//比例
    CGFloat height = 28;
    CGFloat with = scale*470;
    
    CGFloat marginLeft = 28+17+15;//按钮的间隙
    CGFloat marginRight = (ScreenWidth-with)/2;//图片的间隙
    
    self.searchImageView = [[UIImageView alloc] init];
    if (marginLeft > marginRight)  {
        _searchImageView.frame = CGRectMake(marginLeft, 20+(44-height)/2, with, height);
    }else{
        _searchImageView.frame = CGRectMake(marginRight, 20+(44-height)/2, with, height);
    }
    _searchImageView.image = [[UIImage imageNamed:@"searchBg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _searchImageView.userInteractionEnabled = YES;
    
    
    UIImageView *magnifier = [[UIImageView alloc] initWithFrame:CGRectMake(10, (28-15)/2, 15, 15)];
    magnifier.image = [UIImage imageNamed:@"Magnifier"];
    [_searchImageView addSubview:magnifier];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(magnifier.frame)+10, (28-20)/2, with-10-10-magnifier.frame.size.width, 20)];
    _searchTextField.placeholder = @"search";
    _searchTextField.delegate = self;
    _searchTextField.textColor =  UIColorFromRGB(0xffffff, 0.6);
    _searchTextField.backgroundColor = [UIColor clearColor];
    _searchTextField.font = [UIFont systemFontOfSize:16.0];
    _searchTextField.textAlignment = NSTextAlignmentLeft;
    [_searchImageView addSubview:_searchTextField];
    
    [self.view addSubview:_searchImageView];
}

- (void) requestDataWithDic:(NSMutableDictionary *)dic{
    
    [[HomeCityListRequest alloc] requestData:dic andBlock:^(HomeCityListRequest *responseData) {
        
        self.datas = (NSMutableArray *)responseData.responsedataArray;
        if (self.datas.count) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData._data options:NSJSONReadingMutableContainers error:nil];
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"citysListDic"];
            
            [_tableView reloadData];
        }
        
    } andFailureBlock:^(HomeCityListRequest *responseData) {
        if (TARGET_IPHONE_SIMULATOR) NSLog(@"选择城市页面请求失败");
    }];
}

- (void) initNav{
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor = [UIColor blackColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 20, 50, 44);
    [btn setImage:[UIImage imageNamed:@"ArrowLeft"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"ArrowLeft"] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(12, 15, 12, 25);//高20，宽10
    [btn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:btn];
    
    UILabel *titleLabe = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-(ScreenWidth-100))/2, 20+(44-30)/2, ScreenWidth-100, 30)];
    titleLabe.font = [UIFont systemFontOfSize:20.0];
    titleLabe.textColor = [UIColor whiteColor];
    titleLabe.textAlignment = NSTextAlignmentCenter;
    titleLabe.text = @"选择城市";
    [_navView addSubview:titleLabe];
    
    [self.view addSubview:_navView];
}

- (void) backToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HomeCityListTableViewCell class] forCellReuseIdentifier:@"ChinaTownHomeCityListTableViewCell"];
    [self.view addSubview:_tableView];
    
    NSString *location = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationName"];
    
    UIView *viewForHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    viewForHead.backgroundColor = kSystemGrayColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = location;
    UIFont *font = [UIFont fontWithName:@"Arial" size:16.0];
    label.font = font;
    CGSize labelSize = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    label.frame = CGRectMake(15, 10, labelSize.width, 30);
    
    UILabel *labelForGPS = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+5, label.mj_origin.y, ScreenWidth-30-CGRectGetMaxX(label.frame)-5, label.frame.size.height)];
    labelForGPS.text = @"当前定位城市";
    labelForGPS.font = [UIFont systemFontOfSize:16.0];
    labelForGPS.textColor = [UIColor grayColor];
    labelForGPS.textAlignment = NSTextAlignmentLeft;
    
    [viewForHead addSubview:label];
    [viewForHead addSubview:labelForGPS];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49, ScreenWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [viewForHead addSubview:line];
//    _tableView.tableHeaderView = viewForHead;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChinaTownHomeCityListTableViewCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenWidth*9/16;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(passCity:)]) {
        [self.delegate passCity:self.datas[indexPath.row]];
    }
    NSString *userLastChooseCity = [self.datas[indexPath.row] city_name];
    [[NSUserDefaults standardUserDefaults] setObject:userLastChooseCity forKey:@"userLastChooseCity"];
    NSString *userLastChooseCityId = [NSString stringWithFormat:@"%@",[self.datas[indexPath.row] city]];
    [[NSUserDefaults standardUserDefaults] setObject:userLastChooseCityId forKey:@"userLastChooseCityId"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50;
//}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchTextField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length == 0) {
        [_searchTextField resignFirstResponder];
        return NO;
    }
    _tableView.hidden = NO;
    [_noResultView removeFromSuperview];
    [self.searchResultArray removeAllObjects];
    
    //判断是否有与用户输入相同（一模一样的）
    for (int i = 0; i<self.datas.count; i++) {
        HomeCityListModel *model = self.datas[i];
        if ([textField.text isEqualToString:model.city_name]) {
            [self.searchResultArray addObject:model];
        }
    }
    
    if (self.searchResultArray.count) {
        [_datas removeAllObjects];
        [_datas addObjectsFromArray:self.searchResultArray];
        [_tableView reloadData];
    }else{
        [self.view addSubview:_noResultView];
        _tableView.hidden = YES;
    }
    [_searchTextField resignFirstResponder];
    return YES;
}

- (NSMutableArray *)searchResultArray{
    if (_searchResultArray == nil) {
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}

- (NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
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
