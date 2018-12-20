//
//  MessageViewController.m
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setSubViews];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"我的消息";
}

- (void)setSubViews{
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 44, kSCREEN_Width-20, 20);
    label.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
    label.textColor = kRGB(60, 60, 60, 0.6);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"还没有消息";
    [self.view addSubview:label];
    //设置导航上的返回按钮
    UIImage *leftImage = [[UIImage imageNamed:@"ic_nav_second_back_normal_17x17_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftImage style:(UIBarButtonItemStyleDone) target:self action:@selector(backButtonClickAction)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
}

#pragma mark -- 自定义返回按钮点击方法
- (void)backButtonClickAction {
    //返回视图
    [self.navigationController popViewControllerAnimated:YES];
    
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
