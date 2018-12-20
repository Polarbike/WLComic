//
//  RegistForgetViewController.m
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "RegistForgetViewController.h"
#import "UserPolicyViewController.h"


@interface RegistForgetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UITextField *repassWordTF;

@property (weak, nonatomic) IBOutlet UIButton *makeSureButton;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *userPolicy;



@end

@implementation RegistForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createSubviewsWithStatus:self.isRegister];
}

- (void)createSubviewsWithStatus:(BOOL)isRegister {
    
    if (isRegister) {//如果是注册改变按钮tittle和用户协议
        
        [self.makeSureButton setTitle:@"注册" forState:(UIControlStateNormal)];
    }else{
        
        [self.makeSureButton setTitle:@"确认" forState:(UIControlStateNormal)];
        self.contentLabel.hidden = YES;
        self.userPolicy.hidden = YES;
    }
    [self.makeSureButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
}



- (IBAction)backClickAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)userPolicyButtonClick:(id)sender {
    //模态显示出用户协议,解决无导航条dismiss的问题
    UserPolicyViewController *userPolicyVC = [[UserPolicyViewController alloc] init];
    [self presentViewController:userPolicyVC animated:YES completion:nil];
}

- (IBAction)makeSureButtonClickAction:(id)sender {
    
    if ([self.nameTF.text isEqualToString:@""]||[self.passwordTF.text isEqualToString:@""]||
        [self.repassWordTF.text isEqualToString:@""]) {
        
        [self showMBProgressHUDWithMessage:@"内容不能为空" showLabel:YES isShowTime:YES];
    }else{
        
        if (![self.passwordTF.text isEqualToString:self.repassWordTF.text]) {
            
            [self showMBProgressHUDWithMessage:@"密码不一致请确认" showLabel:YES isShowTime:YES];
        }else{
            //判断是忘记密码还是注册
            if (self.isRegister) {
                //如果是注册，加入用户
                NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:kUserArray];
                NSMutableArray *userArray = [NSMutableArray arrayWithArray:array];
                [userArray addObject:self.nameTF.text];
                [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:kUserArray];
                //
                NSArray *passArray = [[NSUserDefaults standardUserDefaults] valueForKey:kPassWordArray];
                NSMutableArray *userPassArray = [NSMutableArray arrayWithArray:passArray];
                [userPassArray addObject:self.passwordTF.text];
                [[NSUserDefaults standardUserDefaults] setObject:userPassArray forKey:kPassWordArray];
                if ([_delegate respondsToSelector:@selector(getEditUserName:)]) {
                    
                    [_delegate getEditUserName:self.nameTF.text];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                //找回密码
                NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:kUserArray];
                NSInteger index = [array indexOfObject:self.nameTF.text];
                //
                NSArray *passArray = [[NSUserDefaults standardUserDefaults] valueForKey:kPassWordArray];
                NSMutableArray *userPassArray = [NSMutableArray arrayWithArray:passArray];
                [userPassArray replaceObjectAtIndex:index withObject:self.passwordTF.text];
                [[NSUserDefaults standardUserDefaults] setObject:userPassArray forKey:kPassWordArray];
                if ([_delegate respondsToSelector:@selector(getEditUserName:)]) {
                    
                    [_delegate getEditUserName:self.nameTF.text];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
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
