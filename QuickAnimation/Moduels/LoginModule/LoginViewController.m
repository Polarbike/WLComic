//
//  LoginViewController.m
//  QuickAnimation
//
//  Created by Weilian on 30/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegistForgetViewController.h"

@interface LoginViewController ()<UserNameDelegate>

@property(nonatomic,strong) LoginView *loginView;
@property(nonatomic,assign) BOOL isLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.loginView = [[LoginView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height))];
    self.loginView.backgroundColor = kRGB(251, 227, 76, 1);
    [self.view addSubview:self.loginView];
    [self.loginView.closeButton addTarget:self action:@selector(closeLoginClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.loginButton addTarget:self action:@selector(loginButtonClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.registerButton addTarget:self action:@selector(registerButtonClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.forgetPWButton addTarget:self action:@selector(forgetPWButtonClickAction) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark -- 登录页面关闭按钮点击方法
- (void)closeLoginClickAction {
    
    [self dismissViewControllerAnimated:YES completion:^{
        //预留
        
    }];    
}
#pragma mark -- 登录按钮点击方法
- (void)loginButtonClickAction {
    
    if ([self.loginView.passWordTF isFirstResponder]) {
        
        [self.loginView.passWordTF resignFirstResponder];
    }
    //取数据校验
    if ([self.loginView.nameTextFiled.text isEqualToString:@""]||[self.loginView.passWordTF.text isEqualToString:@""]) {
        
        [self showMBProgressHUDWithMessage:@"输入内容不能为空" showLabel:YES isShowTime:YES];
    }else{
        
        if ([self.loginView.nameTextFiled.text isEqualToString:@"qwerty"] && [self.loginView.passWordTF.text isEqualToString:@"123456"]) {
            
            NSString *string = self.loginView.nameTextFiled.text;
            NSString *password = self.loginView.passWordTF.text;
            self.isLogin = YES;
            [[NSUserDefaults standardUserDefaults] setObject:string forKey:kUser];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self getUserInfoDictionary]];
            [dic setObject:string forKey:kUser];
            [dic setObject:password forKey:kPassWord];
            [dic setObject:string forKey:kNickName];
            [self updateUserInfoWithDictionary:dic];
            //
            if ([_delegate respondsToSelector:@selector(getLoginViewLogStatus:name:)]) {
                
                [_delegate getLoginViewLogStatus:YES name:string];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            
            NSArray *user = [NSArray array];
            user = [[NSUserDefaults standardUserDefaults] objectForKey:kUserArray];
            //        NSMutableArray *forinUserArray = [NSMutableArray arrayWithArray:user];
            if (IsNilOrNull(user)) {
                
                [self showMBProgressHUDWithMessage:@"用户名或密码输入错误" showLabel:YES isShowTime:YES];
            }else{
                
                for (NSString *string in user) {
                    //
                    if ([self.loginView.nameTextFiled.text isEqualToString:string]) {
                        
                        NSInteger idx = [user indexOfObject:string];
                        NSArray *passWordArray = [[NSUserDefaults standardUserDefaults] objectForKey:kPassWordArray];
                        NSString *password = passWordArray[idx];
                        if ([self.loginView.passWordTF.text isEqualToString:password]) {
                            
                            self.isLogin = YES;
                            [[NSUserDefaults standardUserDefaults] setObject:string forKey:kUser];
                            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self getUserInfoDictionary]];
                            [dic setObject:string forKey:kUser];
                            [dic setObject:password forKey:kPassWord];
                            [dic setObject:string forKey:kNickName];
                            [self updateUserInfoWithDictionary:dic];
                            //
                            if ([_delegate respondsToSelector:@selector(getLoginViewLogStatus:name:)]) {
                                
                                [_delegate getLoginViewLogStatus:YES name:string];
                            }
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }else{
                            
                            [self showMBProgressHUDWithMessage:@"用户名或密码输入错误" showLabel:YES isShowTime:YES];
                        }
                    }else{
                        
                        self.isLogin = NO;
                    }
                }
                if (!self.isLogin) {
                    
                    [self showMBProgressHUDWithMessage:@"用户名或密码输入错误" showLabel:YES isShowTime:YES];
                }
            }
            
        }
    }
}
#pragma mark -- 注册按钮点击方法
- (void)registerButtonClickAction {
    
    RegistForgetViewController *registerForgetVC = [[RegistForgetViewController alloc] init];
    registerForgetVC.isRegister = YES;
    registerForgetVC.delegate = self;
    [self presentViewController:registerForgetVC animated:YES completion:nil];
}
#pragma mark -- 忘记密码按钮点击方法
- (void)forgetPWButtonClickAction {
    
    RegistForgetViewController *registerForgetVC = [[RegistForgetViewController alloc] init];
    registerForgetVC.isRegister = NO;
    registerForgetVC.delegate = self;
    [self presentViewController:registerForgetVC animated:YES completion:nil];
}
#pragma mark -- 注册或者忘记密码代理方法
- (void)getEditUserName:(NSString *)name {
    
    self.loginView.nameTextFiled.text = name;
    self.loginView.passWordTF.text = @"";
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
