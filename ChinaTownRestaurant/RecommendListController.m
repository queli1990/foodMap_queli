//
//  ChinaTownListController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "RecommendListController.h"
#import "RecommendListNavView.h"
#import "ChooseBtn.h"
#import "RecommendListTableViewCell.h"
#import "JSDropDownMenu.h"
#import "DetailController.h"
#import "ChinaTownListRequest.h"
#import "SearchViewController.h"
#import "NoResultView.h"
#import "SearchModel.h"

#import "RecommendCityListModel.h"
#import "HomeHeadModel.h"


@interface RecommendListController ()<UITableViewDelegate,UITableViewDataSource,JSDropDownMenuDataSource,JSDropDownMenuDelegate,UITextFieldDelegate>
@property (nonatomic,strong) RecommendListNavView *navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic) BOOL isDeleteOriginalData;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) GMDCircleLoader *loader;

@property (nonatomic,strong) NSMutableArray *locationArray;
@property (nonatomic,strong) NSMutableArray *evaluateArray;
@property (nonatomic,strong) NSMutableArray *categoryArray;

@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) UIView *blackShadeViewForSearch;
@property (nonatomic,strong) NoDataView *nodataView;
@property (nonatomic,strong) NoResultView *noResultView;
@property (nonatomic) BOOL isSearch;
@property (nonatomic) BOOL isMenuRequestData;
@end

@implementation RecommendListController{
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    JSDropDownMenu *menu;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_loader) {
        [_loader start];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i<self.chooseCategoryArray.count; i++) {
        HomeHeadModel *model = _chooseCategoryArray[i];
        if ([model.category_name isEqualToString:@"全部"]) {
            [_chooseCategoryArray removeObject:model];
            [_chooseCategoryArray insertObject:model atIndex:0];
            i = (int)_chooseCategoryArray.count;
        }
    }
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    background.image = [[UIImage imageNamed:@"HomeBackground"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:background];
    
    [self setNav];
    
    [self initTableView];
    
    [self setMenu];
    
    [self addLoader];
    [self initNodataView];
    [self initNoResultView];
    
    _isMenuRequestData = YES;
    
    _page = 1;
    _size = 10;
    [self setParams];
    
    [self requestWithDictionary:_params];
    
    
    if (!_isFormSearchPage) {
        menu.currentSelectedMenudIndex = 0;
        menu.leftSelectedRow = 0;
        switch (_chooseCategoryCount) {
            case 0:
                [menu confiMenuWithSelectRow:1 leftOrRight:0];
                break;
            case 1:
                [menu confiMenuWithSelectRow:2 leftOrRight:0];
                break;
            case 2:
                [menu confiMenuWithSelectRow:3 leftOrRight:0];
                break;
            case 3:
                [menu confiMenuWithSelectRow:4 leftOrRight:0];
                break;
            case 4:
                [menu confiMenuWithSelectRow:5 leftOrRight:0];
                break;
            case 5:
                [menu confiMenuWithSelectRow:0 leftOrRight:0];
                break;
            default:
                break;
        }
        
        menu.currentSelectedMenudIndex = 1;
        [menu confiMenuWithSelectRow:0 leftOrRight:1];
    }
}

- (void) addLoader{
    _loader = [[GMDCircleLoader alloc] initWithFrame:CGRectMake((ScreenWidth-50)/2, (ScreenHeight-50)/2, 50, 50)];
    [_loader start];
    [self.view addSubview:_loader];
}

- (void) initNodataView{
    _nodataView = [[NoDataView alloc] initWithFrame:CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-40)];
    [_nodataView.requestBtn addTarget:self action:@selector(requestData:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) initNoResultView{
    self.noResultView = [[NoResultView alloc] initWithFrame:CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-40)];
}

- (void) setParams{
    _params = [NSMutableDictionary dictionary];
    [_params setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"page"];
    [_params setObject:[NSString stringWithFormat:@"%d",_size] forKey:@"rows"];
    [_params setObject:_cityId forKey:@"cityid"];
//    [_params setObject:_cityName forKey:@"city"];
    
    if (_foodCategory.length) {
        [_params setObject:self.foodCategory forKey:@"category"];
    }
    
    if (_chooseRegion.length > 0) {
        if ([_chooseRegion isEqualToString:@"全部"]) {
            [_params removeObjectForKey:@"regions"];
        }else{
            [_params setObject:_chooseRegion forKey:@"regions"];
        }
    }
    
    if (_order.length > 0) {
        if ([_order isEqualToString:@"0"]) {
            [_params removeObjectForKey:@"order"];
        }else{
            [_params setObject:_order forKey:@"order"];
        }
    }
    
    if (_searchWord.length) {
        [_params setObject:_searchWord forKey:@"business"];
        if (_isSearch) {
            [_params removeObjectForKey:@"regions"];
            [_params removeObjectForKey:@"order"];
            _isSearch = NO;
        }
    }
}

- (void) requestData:(UIButton *)btn{
    [self setParams];
    [self requestWithDictionary:_params];
}

- (void) requestWithDictionary:(NSMutableDictionary *)dic{
    [_nodataView removeFromSuperview];
    [_noResultView removeFromSuperview];
    
    [self.view addSubview:_loader];
    [_loader start];
    
    [[ChinaTownListRequest alloc] requestData:dic andBlock:^(ChinaTownListRequest *responseData) {
        
        [_loader removeFromSuperview];
        
//        if (!self.locationArray.count) {
//            if (responseData.cityListArray.count) {
//                [self.locationArray addObjectsFromArray:responseData.cityListArray];
//                RecommendCityListModel *model = [[RecommendCityListModel alloc] init];
//                model.name = @"全部";
//                [self.locationArray insertObject:model atIndex:0];
//                [self setMenu];
//            }
//        }
        
        
        if (responseData.responsedataArray.count) {
            if (_isDeleteOriginalData) {
                [_datas removeAllObjects];
            }
            
            [self.datas addObjectsFromArray:responseData.responsedataArray];
            
            if (_tableView.hidden) _tableView.hidden = NO;
            
            [_tableView reloadData];
            
            [_tableView.mj_header endRefreshing];
            
            int count;
            if (responseData.count.intValue % self.size == 0) {
                count = responseData.count.intValue / self.size;
            }else{
                count = responseData.count.intValue / self.size + 1;
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
    } andFailureBlock:^(ChinaTownListRequest *responseData) {
        _tableView.hidden = YES;
        [_loader removeFromSuperview];
        [self.view addSubview:_nodataView];
        
        if (TARGET_IPHONE_SIMULATOR) NSLog(@"列表页请求失败");
        _isDeleteOriginalData = NO;
    }];
}

- (void) addTableViewFooter{
    _page ++;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self setParams];
        
        [self requestWithDictionary:_params];
    }];
}

- (void) setMenu{
    //指定默认选中
//    _currentData1Index = _chooseCategoryCount;
    if (_isFormSearchPage) {
        _currentData1Index = 0;
    }else{
        if (_chooseCategoryCount == 5) {
            _currentData1Index = 0;
        }else{
            _currentData1Index = _chooseCategoryCount+1;
        }
    }
    
    _currentData2Index = 0;
    
    menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];//箭头颜色
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];//分割线颜色
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];//字体颜色
    
    menu.backgroundColor = [UIColor clearColor];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
}

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    return 2;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    if (column==0) {
        return _currentData1Index;
    }
    if (column==1) {
        return _currentData2Index;
    }
    if (column == 2) {
        return _currentData3Index;
    }
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
//        return self.locationArray.count;
        return self.chooseCategoryArray.count;
    }else if (column == 1){
        return self.evaluateArray.count;
    }else{
        return self.categoryArray.count;
    }
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    if (column == 0) {
//        RecommendCityListModel *model = self.locationArray[_currentData1Index];
        HomeHeadModel *model = self.chooseCategoryArray[_currentData1Index];
        return model.category_name;
    }else if (column == 1){
        return self.evaluateArray[_currentData2Index];
    }else{
        return self.categoryArray[_currentData3Index];
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
//        RecommendCityListModel *model = self.locationArray[indexPath.row];
        HomeHeadModel *model = self.chooseCategoryArray[indexPath.row];
        return model.category_name;
    } else if (indexPath.column == 1){
        return self.evaluateArray[indexPath.row];
    }else {
        return self.categoryArray[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
//        _chooseRegion = [self.locationArray[indexPath.row] name];
        _chooseRegion = [self.chooseCategoryArray[indexPath.row] category_name];
        
        if (!(_currentData1Index == indexPath.row) && _isMenuRequestData) {
            [self.view addSubview:_loader];
            [_loader start];
            
            _page = 1;
            [self setParams];
            [self requestWithDictionary:_params];
            _tableView.contentOffset = CGPointMake(0, 0);
        }
        _currentData1Index = indexPath.row;
        
    } else if (indexPath.column == 1 && _isMenuRequestData){
        
        _order = [NSString stringWithFormat:@"%ld",indexPath.row];
        
        if (!(_currentData2Index == indexPath.row)) {
            [self.view addSubview:_loader];
            [_loader start];
            
            _page = 1;
            [self setParams];
            [self requestWithDictionary:_params];
            _tableView.contentOffset = CGPointMake(0, 0);
        }
        _currentData2Index = indexPath.row;
        
    } else {
        _currentData3Index = indexPath.row;
    }
    _isDeleteOriginalData = YES;
    _isMenuRequestData = YES;
}



- (void) initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[RecommendListTableViewCell class] forCellReuseIdentifier:@"ChinaTownListTableViewCell"];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChinaTownListTableViewCell" forIndexPath:indexPath];
    cell.model = _datas[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailController *vc =[[DetailController alloc] init];
    vc.businessId = [NSString stringWithFormat:@"%@",[_datas[indexPath.row] businessId]];
//    vc.businessId = @"3094270";//有照片的
    [self.navigationController pushViewController:vc animated:YES];
}


- (void) textFieldResignFirstResponder:(UITapGestureRecognizer *)tap{
    [_blackShadeViewForSearch removeFromSuperview];
    [_searchTextField resignFirstResponder];
}

- (void) setNav{
    if (self.isFormSearchPage) {
        
        if (ScreenWidth == 320) {
            _blackShadeViewForSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-253)];
        }else if (ScreenWidth == 375){
            _blackShadeViewForSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-258)];
        }else{
            _blackShadeViewForSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-271)];
        }
        _blackShadeViewForSearch.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldResignFirstResponder:)];
        [_blackShadeViewForSearch addGestureRecognizer:tap];
        
        
        UIView *viewForNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        viewForNav.backgroundColor = [UIColor blackColor];
        
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 20, 50, 44);
        [backBtn setImage:[UIImage imageNamed:@"ArrowLeft"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"ArrowLeft"] forState:UIControlStateHighlighted];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 15, 14, 25);//高20，宽10
        [backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
        [viewForNav addSubview:backBtn];
        
        
        self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 20+(44-30)/2, ScreenWidth-100, 30)];
        _searchTextField.backgroundColor = kSystemGrayColor;
        _searchTextField.textColor = [UIColor blackColor];
        _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
        _searchTextField.placeholder = @"输入商户名、地点";
        _searchTextField.font = [UIFont systemFontOfSize:16.0];
        _searchTextField.textAlignment = NSTextAlignmentLeft;
        _searchTextField.adjustsFontSizeToFitWidth = YES;
        //设置placeholder的颜色
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSForegroundColorAttributeName] = [UIColor grayColor];
        NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:_searchTextField.placeholder attributes:dict];
        [_searchTextField setAttributedPlaceholder:attribute];
        
        _searchTextField.minimumFontSize = 12;
        _searchTextField.clearButtonMode = UITextFieldViewModeNever;
        _searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.delegate = self;
        _searchTextField.text = self.searchWord;
        [viewForNav addSubview:_searchTextField];
        
        [self.view addSubview:viewForNav];
        
    }else{
        self.navView = [[RecommendListNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        _navView.titleLabel.textColor = [UIColor whiteColor];
        _navView.titleLabel.text = @"商铺列表";
        [_navView.searchBtn addTarget:self action:@selector(goToSearchPage:) forControlEvents:UIControlEventTouchUpInside];
        [_navView.backBtn addTarget:self action:@selector(backToLastPage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_navView];
    }
}

- (void) goToSearchPage:(UIButton *)btn{
    SearchViewController *vc = [[SearchViewController alloc] init];
    vc.cityId = self.cityId;
    vc.chooseArray = self.chooseCategoryArray;
    vc.chooseCount = self.chooseCategoryCount;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    [self.view addSubview:_blackShadeViewForSearch];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入内容" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    _searchWord = textField.text;
    _page = 1;
    _isDeleteOriginalData = YES;
    _isSearch = YES;
    [self setParams];
    [self requestWithDictionary:_params];
    [_blackShadeViewForSearch removeFromSuperview];
    [_searchTextField resignFirstResponder];
    
    
    menu.currentSelectedMenudIndex = 0;
    menu.leftSelectedRow = 0;
    [menu confiMenuWithSelectRow:0 leftOrRight:0];
    menu.currentSelectedMenudIndex = 1;
    [menu confiMenuWithSelectRow:0 leftOrRight:1];
    
    
#warning 不清楚判断是为了什么,如果是选择城市的时候肯定有用
    if (_locationArray.count) {
        _isMenuRequestData = NO;
        
        JSIndexPath *indexPath = [[JSIndexPath alloc] init];
        indexPath.column = 0;
        [self menu:menu didSelectRowAtIndexPath:indexPath];
        
        JSIndexPath *indexPath1 = [[JSIndexPath alloc] init];
        indexPath1.column = 1;
        [self menu:menu didSelectRowAtIndexPath:indexPath1];
    }
    
    
    NSMutableArray *searchWords = [NSMutableArray array];
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchWords"];
        for ( int i = 0; i<array.count; i++) {
            SearchModel *model = [[SearchModel alloc] init];
            NSDictionary *dic = array[i];
            model.searchWord = dic[@"searchWord"];
            [searchWords addObject:model];
        }
        
        NSInteger t = searchWords.count>9 ? 9:searchWords.count;
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = t-1; i>=0; i--) {
            [arr addObject:searchWords[i]];
        }
        [searchWords removeAllObjects];
        [searchWords addObjectsFromArray:arr];
        
        
        SearchModel *model = [[SearchModel alloc] init];
        model.searchWord = textField.text;
        [searchWords addObject:model];
        
        for (NSInteger i = 0; i<searchWords.count-1; i++) {
            SearchModel *model = searchWords[i];
            if ([model.searchWord isEqualToString:textField.text]) {
                [searchWords removeObject:model];
                i = searchWords.count;
            }
        }
        
        NSMutableArray *userSearchWordArray = [NSMutableArray array];
        for ( int i = (int)searchWords.count-1; i>=0; i--) {
            SearchModel *model = searchWords[i];
            NSDictionary *dic = @{@"searchWord":model.searchWord};
            [userSearchWordArray addObject:dic];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:userSearchWordArray forKey:@"searchWords"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    

    return YES;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchTextField resignFirstResponder];
}

- (void) backToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (NSMutableArray *)evaluateArray{
    if (_evaluateArray == nil) {
        _evaluateArray = [NSMutableArray arrayWithObjects:@"智能排序", @"评价最高", @"口味最佳", @"环境最好",@"服务最优", nil];
    }
    return _evaluateArray;
}

- (NSMutableArray *)categoryArray{
    if (_categoryArray == nil) {
        _categoryArray = [NSMutableArray arrayWithObjects:@"小吃面点",@"粤菜",@"川菜",@"东北菜",@"江浙菜",@"全部", nil];
    }
    return _categoryArray;
}

- (NSMutableArray *)locationArray{
    if (_locationArray == nil) {
        _locationArray = [NSMutableArray array];
    }
    return _locationArray;
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
