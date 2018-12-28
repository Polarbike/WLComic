//
//  ReportViewController.m
//  QuickAnimation
//
//  Created by Weilian on 26/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportView.h"


@interface ReportViewController ()<UITextViewDelegate>

@property(nonatomic,strong) ReportView *reportView;//

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubviews];
}


- (void)createSubviews {
    
    self.reportView = [[ReportView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height))];
    self.reportView.inputView.delegate = self;
    [self.reportView.backButton addTarget:self action:@selector(backButtonClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.reportView.submitButton addTarget:self action:@selector(submitButtonClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.reportView];
}


- (void)backButtonClickAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitButtonClickAction {
    
    if ([self.reportView.inputView isFirstResponder]) {
        
        [self.reportView.inputView resignFirstResponder];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hud hideAnimated:YES];
        [self showMBProgressHUDWithMessage:@"提交成功" showLabel:YES isShowTime:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    if ([self.reportView.inputView isFirstResponder]) {
        
        [self.reportView.inputView resignFirstResponder];
    }
    
}
#pragma mark -- textView代理方法
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (![textView.text isEqualToString:@""]) {
        
        textView.text = @"";
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@""]) {
        
        textView.text = @"请输入举报原因...";
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
