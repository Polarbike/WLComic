//
//  Dis_DetailViewController.m
//  QuickAnimation
//
//  Created by Weilian on 04/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "Dis_DetailViewController.h"

@interface Dis_DetailViewController ()

@end

@implementation Dis_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发现详情";
    //设置导航上的返回按钮
    UIImage *leftImage = [[UIImage imageNamed:@"ic_nav_second_back_normal_17x17_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftImage style:(UIBarButtonItemStyleDone) target:self action:@selector(backButtonClickAction)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setHidden:NO];
    
}

#pragma mark -- 左侧返回按钮点击事件
- (void)backButtonClickAction {
    
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
