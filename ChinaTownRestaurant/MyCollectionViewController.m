//
//  MyCollectionViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/5/6.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionRequest.h"

@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic) CGFloat cellHeight;

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self requestData];
    
    
}

- (void) requestData{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr = [NSString stringWithFormat:@"api/collects/userid/%@.json",userId];
    
    MyCollectionRequest *request = [[MyCollectionRequest alloc]init];
    request.requestUrl = urlStr;
    [request requestData:nil andBlock:^(MyCollectionRequest *responseData) {
        
        self.datas = (NSMutableArray *)responseData.models;
        
        [self initTableView];
        
    } andFailureBlock:^(MyCollectionRequest *responseData) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    _cellHeight = [cell homeCellHeight];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell取消点中效果颜色
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenWidth*9/16+50;
}


- (void) initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[MyCollectionViewCell class] forCellReuseIdentifier:@"MyCollectionViewCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void) setNav{
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
    titleLabe.text = @"我的收藏";
    [_navView addSubview:titleLabe];
    
    [self.view addSubview:_navView];
}

- (NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
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
