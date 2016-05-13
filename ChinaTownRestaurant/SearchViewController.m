//
//  SearchViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/15.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "SearchViewController.h"
#import "RecommendListController.h"
#import "SearchModel.h"
#import "SearchTableViewCell.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableArray *userSearchWordArray;
@end

@implementation SearchViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_searchTextField becomeFirstResponder];
    [self prepareData];
    [_tableView reloadData];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self setTableView];
}

- (void) prepareData{
    if (self.datas.count) {
        [self.datas removeAllObjects];
    }
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchWords"];
    for ( int i = 0; i<array.count; i++) {
        SearchModel *model = [[SearchModel alloc] init];
        NSDictionary *dic = array[i];
        model.searchWord = dic[@"searchWord"];
        [self.datas addObject:model];
    }
    if (_datas.count) _tableView.hidden = NO;
}

- (CGRect) initWith:(CGFloat)With height:(CGFloat)Hegith fatherViewTotalWith:(CGFloat)totalWith fatherViewTotalHeight:(CGFloat)totalHeight
{
    CGRect rect = CGRectMake((totalWith-With)/2, (totalHeight-Hegith)/2, With,Hegith);
    return rect;
}

- (void) setTableView{
    [self prepareData];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:@"SearchTableViewCell"];
    [self.view addSubview:_tableView];
    _tableView.hidden = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    deleteButton.frame = CGRectMake((ScreenWidth-233*0.8)/2, (80-46*0.8)/2, 233*0.8, 46*0.8);
    CGRect frame = [self initWith:233*0.8 height:46*0.8 fatherViewTotalWith:ScreenWidth fatherViewTotalHeight:80];
    deleteButton.frame = frame;
    
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [deleteButton setTitleColor:kSystemOrangeColor forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [deleteButton setTitle:@"删除记录" forState:UIControlStateNormal];
    deleteButton.tintColor = [UIColor clearColor];
    [deleteButton setBackgroundImage:[[UIImage imageNamed:@"Search_DeleteAllImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:[[UIImage imageNamed:@"Search_DeleteAllImage_highted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    
//    deleteButton.layer.borderColor = [UIColor grayColor].CGColor;
//    
//    deleteButton.titleLabel.textColor = [UIColor grayColor];
//    
//    deleteButton.layer.cornerRadius = 16.0;
//    
//    deleteButton.layer.borderWidth = 1.0;
//    
//    deleteButton.layer.masksToBounds = YES;
    
    
    [deleteButton addTarget:self action:@selector(DeleteUserDefaults:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:deleteButton];
    self.tableView.tableFooterView = view;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (_searchTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入内容" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    
    NSInteger t = self.datas.count>9 ? 9:self.datas.count;
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = t-1; i>=0; i--) {
        [array addObject:_datas[i]];
    }
    [_datas removeAllObjects];
    [_datas addObjectsFromArray:array];
    
    
    SearchModel *model = [[SearchModel alloc] init];
    model.searchWord = textField.text;
    [self.datas addObject:model];
    
    for (NSInteger i = 0; i<self.datas.count-1; i++) {
        SearchModel *model = _datas[i];
        if ([model.searchWord isEqualToString:textField.text]) {
            [_datas removeObject:model];
            i = self.datas.count;
        }
    }
    
    for ( int i = (int)self.datas.count-1; i>=0; i--) {
        SearchModel *model = self.datas[i];
        NSDictionary *dic = @{@"searchWord":model.searchWord};
        [self.userSearchWordArray addObject:dic];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:self.userSearchWordArray forKey:@"searchWords"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_userSearchWordArray removeAllObjects];
    
    RecommendListController *vc = [[RecommendListController alloc] init];
    vc.searchWord = _searchTextField.text;
    vc.cityId = self.cityId;
    vc.isFormSearchPage = YES;
    vc.chooseCategoryCount = self.chooseCount;
    vc.chooseCategoryArray = self.chooseArray;
    [self.navigationController pushViewController:vc animated:YES];
    return YES;
}


- (void) DeleteUserDefaults:(UIButton *)btn{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"searchWords"];
    [self.datas removeAllObjects];
    [self.userSearchWordArray removeAllObjects];
    [_tableView reloadData];
    _tableView.hidden = YES;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchModel *model = _datas[indexPath.row];
    _searchTextField.text = model.searchWord;
    [self textFieldShouldReturn:_searchTextField];
}


- (void) setNav{
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor = [UIColor blackColor];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 20+(44-30)/2, ScreenWidth-40-15-15-15, 30)];
    _searchTextField.backgroundColor = kSystemGrayColor;
    _searchTextField.textColor = [UIColor blackColor];
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _searchTextField.layer.masksToBounds = YES;
//    _searchTextField.layer.cornerRadius = 0.6;
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
    [_navView addSubview:_searchTextField];
    
    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleBtn.frame = CGRectMake(ScreenWidth-40-15, 20+(44-30)/2, 40, 30);
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:kSystemOrangeColor forState:UIControlStateNormal];
    [_cancleBtn addTarget:self action:@selector(popToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_cancleBtn];
    
    [self.view addSubview:_navView];
}

- (void) popToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSMutableArray *)userSearchWordArray{
    if (_userSearchWordArray == nil) {
        _userSearchWordArray = [NSMutableArray array];
    }
    return _userSearchWordArray;
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
