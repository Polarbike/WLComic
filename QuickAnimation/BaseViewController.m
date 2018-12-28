//
//  BaseViewController.m
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //这个类作为所有view controller的父类，在子类加载viewdidload的时候仍然会先加载这个父类的这个类
    //
    //
}

//隐藏导航条
- (void)hiddenNavigationBar {
    
    [self.navigationController.navigationBar setHidden:YES];
    
}
//显示导航条
- (void)visibelNavigationBar {
    
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)showMBProgressHUDWithMessage:(NSString *)message showLabel:(BOOL)isShowLabel isShowTime:(BOOL)isShowTime
{
    if(!hud)
    {
        hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
    }
    hud.label.text = nil;
    hud.minShowTime = 0;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.font = [UIFont systemFontOfSize:12];
    if(isShowLabel)
    {
        hud.mode = MBProgressHUDModeCustomView;
        UIFont *labelFont = [UIFont systemFontOfSize:12];
        CGSize labelSize = [message sizeWithFont:labelFont constrainedToSize:CGSizeMake(self.view.frame.size.width - 80, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
        
        UILabel *label = [[UILabel alloc] init];
        [label setFrame:CGRectMake((self.view.frame.size.width - labelSize.width) / 2, 500, labelSize.width, labelSize.height)];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:message];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setNumberOfLines:0];
        [label setTextColor:kRGB(57, 63, 77, 1)];
        hud.customView = label;
    }
    else
    {
        hud.label.text = message;
    }
    if(isShowTime)
    {
        hud.minShowTime = 1;
    }
    [hud showAnimated:YES];
    
    if(isShowTime)
    {
        [self hideMBProgressHUD];
    }
}


- (void)hideMBProgressHUD
{
    if(hud)
    {
        [hud hideAnimated:YES];
    }
}

- (void)showAlertHUDWithMessage:(NSString *)message showView:(UIView *)view {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minShowTime = 1.0;
    UIFont *labelFont = [UIFont systemFontOfSize:12];
    CGSize labelSize = [message sizeWithFont:labelFont constrainedToSize:CGSizeMake(self.view.frame.size.width - 80, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFrame:CGRectMake((self.view.frame.size.width - labelSize.width) / 2, 500, labelSize.width, labelSize.height)];
    [label setFont:[UIFont systemFontOfSize:14]];
    [label setText:message];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setNumberOfLines:0];
    [label setTextColor:kRGB(57, 63, 77, 1)];
    hud.customView = label;
    [hud hideAnimated:YES afterDelay:1.0];
}

#pragma mark -- 根据传递的内容信息返回size的高度
/**
 根据评论的内容返回cell的高度
 
 @param string 评论内容
 @return 返回评论内容的高度
 */
- (CGFloat)getCommentHeightWithString:(NSString *)string {
    
    CGSize size = CGSizeMake(kSCREEN_Width-20, MAXFLOAT);
    CGSize labelsize  = [string
                         boundingRectWithSize:size
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:[UIFont fontWithName:Font_Name_PFSCRe size:12]}
                         context:nil].size;
    
    //两种方式
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont fontWithName:Font_Name_PFSCRe size:12],
                                NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize textSize = [string boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return ceilf(labelsize.height);
    
    
//    return labelsize.height;
}
#pragma mark -- 懒加载
- (NSMutableDictionary *)parameter {
    
    if (!_parameter) {
        
        _parameter = [[NSMutableDictionary alloc] init];
        //获取当前时间戳
        double date = [[NSDate date] timeIntervalSince1970];
        NSNumber *number = [NSNumber numberWithDouble:date];
        [_parameter setObject:number forKey:@"time"];
        //设备uuid
        NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
        [_parameter setObject:uuid forKey:@"device_id"];
        //apikey
        [_parameter setObject:kAPI_Key forKey:@"key"];
        //设备model
        NSString *model = [UIDevice currentDevice].model;
        [_parameter setObject:model forKey:@"model"];
        //target
        [_parameter setObject:@"U17_4.0" forKey:@"target"];
        //version
        NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        [_parameter setObject:version forKey:@"version"];
    }
        /*
         "time": Int32(Date().timeIntervalSince1970),
         "device_id": UIDevice.current.identifierForVendor!.uuidString,
         "key": UApiKey.key,
         "model": UIDevice.current.modelName,
         "target": "U17_4.0",
         "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
         */
    return _parameter;
}
//
- (NSDictionary *)getUserInfoDictionary {
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    dic = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    
    return dic;
}
//更新用户信息字典
- (void)updateUserInfoWithDictionary:(NSDictionary *)dic {
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kUserInfo];
    
}
//
- (void)createAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //
        self.makeSureAction();
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //team leader
        NSLog(@"取消操作");
    }];
    //添加的先后顺序决定从左到右的顺序
    [alertVC addAction:cancelAction];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
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
