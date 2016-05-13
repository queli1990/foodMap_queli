//
//  RegistViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/13.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "RegistViewController.h"
#import "RecommendListNavView.h"
#import "RegistRequest.h"
#import "LoginOrRegistNav.h"


@interface RegistViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) LoginOrRegistNav *navView;
@property (nonatomic,strong) UITextField *nickNameTextField;
@property (nonatomic,strong) UITextField *passWordTextField;
@property (nonatomic,strong) UITextField *repassWordTextField;

@property (nonatomic,strong) UIAlertController *nickNameAlert;
@property (nonatomic,strong) UIAlertController *passWordAlert;
@end

@implementation RegistViewController

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
    
    self.nickNameAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的用户名长度太短，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
    self.passWordAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的密码太短，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [_nickNameAlert addAction:okAction];
    [_passWordAlert addAction:okAction];
    [_nickNameAlert.view setNeedsLayout];
    [_passWordAlert.view setNeedsLayout];
}

- (void) initTextField{
    UIView *inputView1 = [[UIView alloc] initWithFrame:CGRectMake(30, 64+30, ScreenWidth-60, 40)];
//    inputView1.layer.masksToBounds = YES;
//    inputView1.layer.borderWidth = 1.0;
//    inputView1.layer.borderColor = [UIColor grayColor].CGColor;
    //    inputView1.layer.cornerRadius = 14.0;
    inputView1.backgroundColor = [UIColor clearColor];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, ScreenWidth-60, 1)];
    lineView1.backgroundColor = [UIColor whiteColor];
    [inputView1 addSubview:lineView1];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (40-28)/2, 28, 28)];
    headImageView.image = [UIImage imageNamed:@"personal"];
    [inputView1 addSubview:headImageView];
    
    self.nickNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15, 5, ScreenWidth-60-headImageView.frame.size.width-30-10-5-20, 30)];
    _nickNameTextField.placeholder = @"请输入用户名";
    //设置placeholder的颜色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:_nickNameTextField.placeholder attributes:dict];
    [_nickNameTextField setAttributedPlaceholder:attribute];
    _nickNameTextField.textColor = [UIColor whiteColor];
    _nickNameTextField.font = [UIFont systemFontOfSize:16.0];
    _nickNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    //    _nickNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nickNameTextField.delegate = self;
    [inputView1 addSubview:_nickNameTextField];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(CGRectGetMaxX(_nickNameTextField.frame)+5, 10, 20, 20);
    [clearBtn setImage:[UIImage imageNamed:@"personal_clearBtn"] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearInput:) forControlEvents:UIControlEventTouchUpInside];
    [inputView1 addSubview:clearBtn];
    
    [self.view addSubview:inputView1];
    
    
    UIView *inputView2 = [[UIView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(inputView1.frame)+20, ScreenWidth-60, 40)];
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
    
    
    UIView *inputView3 = [[UIView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(inputView2.frame)+20, ScreenWidth-60, 40)];
//    inputView3.layer.masksToBounds = YES;
//    inputView3.layer.borderWidth = 1.0;
//    inputView3.layer.borderColor = [UIColor grayColor].CGColor;
    //    inputView2.layer.cornerRadius = 14.0;
    inputView3.backgroundColor = [UIColor clearColor];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, ScreenWidth-60, 1)];
    lineView3.backgroundColor = [UIColor whiteColor];
    [inputView3 addSubview:lineView3];
    
    
    UIImageView *repasswordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (40-26)/2, 26, 26)];
    repasswordImageView.image = [UIImage imageNamed:@"personal_lock"];
    [inputView3 addSubview:repasswordImageView];
    
    self.repassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordImageView.frame)+15, 5, _nickNameTextField.frame.size.width, 40)];
    _repassWordTextField.textColor = [UIColor whiteColor];
    _repassWordTextField.placeholder = @"请确认密码";
    //设置placeholder的颜色
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    dict3[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attribute3 = [[NSAttributedString alloc] initWithString:_repassWordTextField.placeholder attributes:dict3];
    [_repassWordTextField setAttributedPlaceholder:attribute3];
    
    _repassWordTextField.font = [UIFont systemFontOfSize:16.0];
    //    _passWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _repassWordTextField.delegate = self;
    [inputView3 addSubview:_repassWordTextField];
    
    [self.view addSubview:inputView3];
    
    
    CGFloat scal = (ScreenWidth-20-20)/630;
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(20, CGRectGetMaxY(inputView3.frame)+20, ScreenWidth-20-20, 104*scal);
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"loginAndRegistBg"] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}

- (void) clearInput:(UIButton *)btn{
    _nickNameTextField.text = nil;
}

- (void) regist:(UIButton *)btn{
    if (_nickNameTextField.text.length <3) {
        [self presentViewController:_nickNameAlert animated:YES completion:nil];
        [_nickNameTextField resignFirstResponder];
        return;
    }
    if (_passWordTextField.text.length>6) {
        [self presentViewController:_passWordAlert animated:YES completion:nil];
        [_passWordTextField resignFirstResponder];
        return;
    }
    if (![_passWordTextField.text isEqualToString:_repassWordTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您两次输入的密码不一致" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_nickNameTextField.text forKey:@"name"];
    [dic setObject:_passWordTextField.text forKey:@"password"];
    [dic setObject:@"headImg" forKey:@"avatar"];
    
    [[RegistRequest alloc] requestFlag:dic andBlock:^(NSString *flag) {
        if ([flag isEqualToString:@"1"]) {
            UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"您已成功注册" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [success show];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"注册失败" message:@"未能成功注册" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [fail show];
        }
    } andFailureBlock:^(NSString *flag) {
        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"注册失败" message:@"未能成功注册" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
//    [_navView.loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _navView.loginBtn.hidden = YES;
    [_navView.registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _navView.registBtn.frame = CGRectMake(CGRectGetMaxX(_navView.backBtn.frame), _navView.backBtn.frame.origin.y, ScreenWidth-_navView.backBtn.frame.size.width*2-15*2, _navView.backBtn.frame.size.height);
    
    [_navView.loginBtn addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    
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
