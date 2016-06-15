//
//  LoginViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "LoginViewController.h"
#import "RecommendListNavView.h"
#import "RegistViewController.h"
#import "LoginRequest.h"
#import "PersonalViewController.h"
#import "LoginOrRegistNav.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) LoginOrRegistNav *navView;
@property (nonatomic,strong) UITextField *nickNameTextField;
@property (nonatomic,strong) UITextField *passWordTextField;

@end

@implementation LoginViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_nickNameTextField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self initTextField];
}

- (void) initTextField{
    
    UIView *inputView1 = [[UIView alloc] initWithFrame:CGRectMake(30, 64+50, ScreenWidth-60, 40)];
//    inputView1.layer.masksToBounds = YES;
//    inputView1.layer.borderWidth = 1.0;
//    inputView1.layer.borderColor = [UIColor grayColor].CGColor;
//    inputView1.layer.cornerRadius = 14.0;
    inputView1.backgroundColor = [UIColor clearColor];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, ScreenWidth-60, 1)];
    lineView1.backgroundColor = [UIColor whiteColor];
    [inputView1 addSubview:lineView1];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (40-28)/2, 28, 28)];
    headImageView.image = [UIImage imageNamed:@"personal"];
    [inputView1 addSubview:headImageView];
    
    self.nickNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15, 5, ScreenWidth-60-headImageView.frame.size.width-30-10-5-20, 30)];
    _nickNameTextField.placeholder = @"请输入用户名";
    _nickNameTextField.backgroundColor = [UIColor clearColor];
    //设置placeholder的颜色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:_nickNameTextField.placeholder attributes:dict];
    [_nickNameTextField setAttributedPlaceholder:attribute];
    _nickNameTextField.textColor = [UIColor whiteColor];
    _nickNameTextField.font = [UIFont systemFontOfSize:16.0];
//    _nickNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    
    //    _nickNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nickNameTextField.delegate = self;
    [inputView1 addSubview:_nickNameTextField];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(CGRectGetMaxX(_nickNameTextField.frame)+5, 10, 20, 20);
    [clearBtn setImage:[UIImage imageNamed:@"personal_clearBtnNormal"] forState:UIControlStateNormal];
    [clearBtn setImage:[UIImage imageNamed:@"personal_clearBtnHeighted"] forState:UIControlStateHighlighted];
    [clearBtn addTarget:self action:@selector(clearInput:) forControlEvents:UIControlEventTouchUpInside];
    [inputView1 addSubview:clearBtn];
    
    [self.view addSubview:inputView1];
    
    
    UIView *inputView2 = [[UIView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(inputView1.frame)+30, ScreenWidth-60, 40)];
//    inputView2.layer.masksToBounds = YES;
//    inputView2.layer.borderWidth = 1.0;
//    inputView2.layer.borderColor = [UIColor grayColor].CGColor;
//    inputView2.layer.cornerRadius = 14.0;
    inputView2.backgroundColor = [UIColor clearColor];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, ScreenWidth-60, 1)];
    lineView2.backgroundColor = [UIColor whiteColor];
    [inputView2 addSubview:lineView2];
    
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (40-26)/2, 26, 26)];
    passwordImageView.image = [UIImage imageNamed:@"personal_lock"];
    [inputView2 addSubview:passwordImageView];
    
    self.passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordImageView.frame)+15, 5, _nickNameTextField.frame.size.width, 30)];
    _passWordTextField.textColor = [UIColor whiteColor];
    _passWordTextField.placeholder = @"请输入6位数以上密码";
    //设置placeholder的颜色
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    dict2[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attribute2 = [[NSAttributedString alloc] initWithString:_passWordTextField.placeholder attributes:dict2];
    [_passWordTextField setAttributedPlaceholder:attribute2];
    _passWordTextField.font = [UIFont systemFontOfSize:16.0];
    //    _passWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTextField.delegate = self;
    [inputView2 addSubview:_passWordTextField];
    
    [self.view addSubview:inputView2];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat scal = (ScreenWidth-20-20)/630;
    loginBtn.frame = CGRectMake(20, CGRectGetMaxY(inputView2.frame)+40, ScreenWidth-20-20, 104*scal);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginAndRegistBg"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(20, CGRectGetMaxY(loginBtn.frame)+20, ScreenWidth-20-20, 40);
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [registBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"personalBgNormal"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"personalBgHeighted"] forState:UIControlStateHighlighted];
    
//    [self.view addSubview:registBtn];
    
}

- (void) clearInput:(UIButton *)btn{
    _nickNameTextField.text = nil;
}

- (void) regist:(UIButton *)btn{
    RegistViewController *vc = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void) login:(UIButton *)btn{
    
    if (_nickNameTextField.text.length <3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的用户名不符合" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [_nickNameTextField resignFirstResponder];
        return;
    }
    if (_passWordTextField.text.length<6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的密码名不符合" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [_passWordTextField resignFirstResponder];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_nickNameTextField.text forKey:@"name"];
    [dic setObject:_passWordTextField.text forKey:@"password"];
    
    [[LoginRequest alloc] requestData:dic andBlock:^(LoginRequest *responseData) {
        
        if ([responseData.flag isEqualToString:@"1"]) {
            NSString *name = responseData.responsedataDic[@"name"];
            NSString *userId = [NSString stringWithFormat:@"%@",responseData.responsedataDic[@"id"]];
            [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"userNickName"];
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
            PersonalViewController *vc = [[PersonalViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"警告" message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [success show];
        }
        
        
    } andFailureBlock:^(LoginRequest *responseData) {
        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"警告" message:@"登录失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [fail show];
    }];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_passWordTextField resignFirstResponder];
    [_nickNameTextField resignFirstResponder];
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
//    [UIView animateWithDuration:0.2 animations:^{
//        if (ScreenWidth == 320) {
//            _fullView.frame = CGRectMake(0, (ScreenHeight-64-120-40-80-80)/2-253-10, ScreenWidth, ScreenHeight-64);
//        }else if (ScreenWidth == 375){
//            _fullView.frame = CGRectMake(0, (ScreenHeight-64-120-40-80-80)/2-200-10, ScreenWidth, ScreenHeight-64);
//        }else{
//            _fullView.frame = CGRectMake(0, (ScreenHeight-64-120-40-80-80)/2-271-10, ScreenWidth, ScreenHeight-64);
//        }
//    }];
}


- (void) setNav{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgImageView.image = [[UIImage imageNamed:@"HomeBackground"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:bgImageView];
    
    
    self.navView = [[LoginOrRegistNav alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor = [UIColor clearColor];
//    [_navView.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _navView.loginBtn.hidden = YES;
    
    _navView.registBtn.frame = CGRectMake(ScreenWidth-15-40, 20+(44-49.0*0.5)/2, 40, 49.0*0.5);
    [_navView.registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_navView.registBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    
    [_navView.backBtn addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];

}

- (void) backToLastPage {
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
