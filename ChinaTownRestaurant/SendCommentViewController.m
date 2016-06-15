//
//  SendCommentViewController.m
//  ChinaTownRestaurant
//
//  Created by mobile_007 on 16/4/25.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "SendCommentViewController.h"
#import "SendCommentRequest.h"
#import "LPLevelView.h"


@interface SendCommentViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) LPLevelView *levelView;
@property (nonatomic,strong) UILabel *levelLabel;
@property (nonatomic,copy) NSString *decorationscore;//用户提交的评分
@end

@implementation SendCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    [self initTextField];
    
    [self setNav];
    
    [self setLevelView];
}

- (void) setLevelView{
    
    UIView *levelBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textField.frame)+10, ScreenWidth, 60)];
    
    self.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 100, 30)];
    _levelLabel.font = [UIFont systemFontOfSize:16.0];
    _levelLabel.textAlignment = NSTextAlignmentLeft;
    _levelLabel.textColor = [UIColor grayColor];
    _levelLabel.text = @"评分：5.0分";
    [levelBgView addSubview:_levelLabel];
    
    _levelView = [LPLevelView new];
    _levelView.frame = CGRectMake(CGRectGetMaxX(_levelLabel.frame)+20, 15, ScreenWidth-CGRectGetMaxX(_levelLabel.frame)-50, 30);
    _levelView.iconColor = UIColorFromRGB(0xffb300, 1.0);
    _levelView.iconSize = CGSizeMake(30, 30);
    _levelView.canScore = YES;
    _levelView.animated = YES;
    _levelView.level = 5.0;
    
    
    __weak typeof(_levelLabel) label = _levelLabel;
    [_levelView setScoreBlock:^(float level) {
        label.text = [NSString stringWithFormat:@"评分：%.1f分",level];
        _decorationscore = [NSString stringWithFormat:@"%.1f",level];
    }];
    
    [levelBgView addSubview:_levelView];
    [levelBgView addSubview:_levelLabel];
    [self.view addSubview:levelBgView];
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
    titleLabe.font = [UIFont systemFontOfSize:18.0];
    titleLabe.textColor = [UIColor whiteColor];
    titleLabe.textAlignment = NSTextAlignmentCenter;
    titleLabe.text = @"发表评论";
    [_navView addSubview:titleLabe];
    
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(ScreenWidth-60-15, 20+(44-34)/2, 60, 34);
    sendBtn.backgroundColor = UIColorFromRGB(0xffb300, 1.0);
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.cornerRadius = 2.0;
    [sendBtn setTitle:@"提交" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:sendBtn];
    
    [self.view addSubview:_navView];
}

- (void) sendMessage:(UIButton *)btn{
    [self textFieldShouldReturn:_textField];
}

- (void) backToLastPage:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initTextField{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 64+20, ScreenWidth-30, 180)];
    _textField.font = [UIFont systemFontOfSize:16.0];
    _textField.textColor = [UIColor blackColor];
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    [self.view addSubview:_textField];
    [_textField becomeFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (_textField.text.length>5) {
        
        if (TARGET_IPHONE_SIMULATOR) NSLog(@"提交评论");
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:_userID forKey:@"userid"];
        [dic setObject:self.thirdid forKey:@"thirdid"];
        [dic setObject:_textField.text forKey:@"commentsource"];
        if (_decorationscore == nil) {
            [dic setObject:@"5.0" forKey:@"decorationscore"];
        }else{
            [dic setObject:_decorationscore forKey:@"decorationscore"];
        }
        
        
//        http://i.vego.tv:2048/comment/saveOrUpdate.json?
//        userid=201&
//        thirdid=16820737&
//        commentsource=%E8%AF%84%E8%AE%BA%E5%86%85%E5%AE%B9&
//        %20avgrating=xx&
//        productscore=xx&
//        decorationscore=xx&
//        servicescore=xx&
//        %20avgprice=xx
        
        [[SendCommentRequest alloc] requestData:dic andBlock:^(SendCommentRequest *responseData) {
            
            if ([self.delegate respondsToSelector:@selector(sendMessageSuccessAndToRequestCommentData)]) {
                [self.delegate sendMessageSuccessAndToRequestCommentData];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } andFailureBlock:^(SendCommentRequest *responseData) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
        
        return YES;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的内容太少，请添加内容" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
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
