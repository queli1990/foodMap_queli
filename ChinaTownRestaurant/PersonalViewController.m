//
//  PersonalViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import "RecommendListNavView.h"
#import "ModeifyPersonalInfoRequest.h"
#import "MyCollectionViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) RecommendListNavView *navView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self initView];
    
}

- (void)setNav{
    self.navView = [[RecommendListNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor = [UIColor blackColor];
    _navView.titleLabel.text = @"我的";
    _navView.titleLabel.textColor = [UIColor whiteColor];
    _navView.searchBtn.hidden = YES;
    [_navView.backBtn addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
}

- (void) backToLastPage{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [_tableView registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:@"PersonalTableViewCell"];
    
    [self.view addSubview:_tableView];
}

//退出登录
- (void) quiteBtnClick:(UIButton *)btn{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userNickName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 80;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 20;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *viewForHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        viewForHeader.backgroundColor = [UIColor clearColor];
        return viewForHeader;
    }else{
        UIView *viewForHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        viewForHeader.backgroundColor = [UIColor clearColor];
        return viewForHeader;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *viewForHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        viewForHeader.backgroundColor = [UIColor clearColor];
        return viewForHeader;
    }
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    
    UIButton *quiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quiteBtn.frame = CGRectMake(30, 25, ScreenWidth-60, 50);
    quiteBtn.backgroundColor = [UIColor redColor];
    quiteBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    
    quiteBtn.clipsToBounds = YES;
    quiteBtn.layer.cornerRadius = 2.0;
    
    [quiteBtn setTitle:@"退出" forState:UIControlStateNormal];
    [quiteBtn setTintColor:[UIColor whiteColor]];
    [quiteBtn addTarget:self action:@selector(quiteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:quiteBtn];
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalTableViewCell" forIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell取消点中效果颜色
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"头像";
            cell.inputLabel.hidden = YES;
            return cell;
        }else if (indexPath.row == 1){
            cell.titleLabel.text = @"昵称";
            cell.headImg.hidden = YES;
            cell.inputLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userNickName"];
            
            UIFont *font = [UIFont fontWithName:@"Arial" size:16];
            cell.inputLabel.font = font;
            CGSize labelSize = [cell.inputLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
            cell.inputLabel.frame = CGRectMake(ScreenWidth-55-labelSize.width-5 , 5, labelSize.width, 50);
            return cell;
        }else {
            cell.titleLabel.text = @"修改密码";
            cell.headImg.hidden = YES;
            return cell;
        }
    }else{
        cell.titleLabel.text = @"我的收藏";
        cell.headImg.hidden = YES;
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"请输入新的昵称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertViewStyle=UIAlertViewStylePlainTextInput;
            alert.tag = 1001;
            [alert show];
        }else if (indexPath.row == 2){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"请输入新的密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertViewStyle=UIAlertViewStylePlainTextInput;
            alert.tag = 1002;
            [alert show];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MyCollectionViewController *vc = [[MyCollectionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {//昵称
        if(buttonIndex==0)//取消修改
        {
            
        }
        if(buttonIndex==1)//确定修改
        {
            // if()
            UITextField *textFiled=[alertView textFieldAtIndex:0];
            if(textFiled.text.length >= 3)
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"id"];
                [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"userNickName"] forKey:@"name"];
                [self requestWithDictionary:(NSMutableDictionary *)dic :1 :textFiled.text];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您输入的昵称太短，请重新输入" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        [alertView resignFirstResponder];
    } else if (alertView.tag == 1002){//密码
        if(buttonIndex==0)//取消修改
        {
            
        }
        if(buttonIndex==1)//确定修改
        {
            // if()
            UITextField*textFiled=[alertView textFieldAtIndex:0];
            if(textFiled.text.length >= 6)
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"id"];
                [dic setObject:textFiled.text forKey:@"password"];
                [dic setObject:textFiled.text forKey:@"repass"];
                [self requestWithDictionary:dic :2 :textFiled.text];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您输入的密码太短，请重新输入" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        [alertView resignFirstResponder];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void) requestWithDictionary:(NSMutableDictionary *)dic :(NSInteger) flag :(NSString *)str{
    ModeifyPersonalInfoRequest *request = [[ModeifyPersonalInfoRequest alloc] init];
    if (flag == 1) {
        request.requestFlag = 1;
        [request requestFlag:dic andBlock:^(NSString *flag) {
            if ([flag isEqualToString:@"1"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"userNickName"];
                [self.tableView reloadData];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } andFailureBlock:^(NSString *flag) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }else if (flag == 2){
        request.requestFlag = 2;
        [request requestFlag:dic andBlock:^(NSString *flag) {
            if ([flag isEqualToString:@"1"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        } andFailureBlock:^(NSString *flag) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
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
