//
//  MineViewController.m
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineFooterView.h"
#import "MineTableViewCell.h"
#import "UserPolicy/UserPolicyViewController.h"

#import "MessageViewController.h"
#import "CollectionViewController.h"
#import "HistoryViewController.h"
#import "AttentionViewController.h"

#import "LoginViewController.h"
#import "EditUserViewController.h"



static NSString *const identifier = @"MineTableViewCell";

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,EditUserInfoDelegate,LoginStatusDelegate>

@property(nonatomic,strong) MineHeaderView *headerView;
@property(nonatomic,strong) UITableView *tableView;//tableView
@property(nonatomic,strong) NSArray *itemTitleArray;//title数组
@property(nonatomic,copy) NSArray *itemIconArray;//item图标数组

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //创建子视图
    [self createSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self prefersStatusBarHidden];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self prefersStatusBarHidden];
    
}
- (void)createSubviews {
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, -20, kSCREEN_Width, kSCREEN_Height-49)) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    //创建tableview的头部视图
    self.headerView = [[MineHeaderView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, 300))];
    [self.headerView setHeaderViewWithDictionary:[NSDictionary dictionary]];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userImageTapAction)];
    [self.headerView.userImage addGestureRecognizer:tapGesture];
    [self.headerView.loginBut addTarget:self action:@selector(loginButtonClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.tableView.tableHeaderView = self.headerView;
    //从用户信息里获取
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    if (![user isEqualToString:@""]) {
        
        NSDictionary *dic = [self getUserInfoDictionary];
        [self.headerView setHeaderViewWithDictionary:dic];
    }
    //创建tableview的脚部视图
//    MineFooterView *footerView = [[MineFooterView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, 54))];
//    self.tableView.tableFooterView = footerView;
//    [footerView.logoutButton addTarget:self action:@selector(logoutClickAction) forControlEvents:(UIControlEventTouchUpInside)];
#pragma mark -- 注册tableviewcell
    UINib *nib = [UINib nibWithNibName:@"MineTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    
}

#pragma mark -- tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemTitleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.itemLabel.text = self.itemTitleArray[indexPath.row];
    NSString *imageName = self.itemIconArray[indexPath.row];
    cell.itemIcon.image = [UIImage imageNamed:imageName];
    return cell;
}
#pragma mark -- cell被选中跳转方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *user = [[NSUserDefaults standardUserDefaults] valueForKey:kUser];
    if (IsNilOrNull(user)||[user isEqualToString:@""]) {
        if (indexPath.row == 4) {
            //用户协议
            UserPolicyViewController *policyVC = [[UserPolicyViewController alloc] init];
            policyVC.hidesBottomBarWhenPushed = YES;
            policyVC.title = @"用户协议";
            [self.navigationController pushViewController:policyVC animated:YES];
        }else{
            
            [self showMBProgressHUDWithMessage:@"请先登录" showLabel:YES isShowTime:YES];
        }
    }else{
        //信息视图
        MessageViewController  *messageVC = [[MessageViewController alloc] init];
        messageVC.hidesBottomBarWhenPushed = YES;
        //用户协议
        UserPolicyViewController *policyVC = [[UserPolicyViewController alloc] init];
        policyVC.hidesBottomBarWhenPushed = YES;
        policyVC.title = @"用户协议";
        //我的收藏
        CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
        collectionVC.hidesBottomBarWhenPushed = YES;
        //我的关注
        AttentionViewController *attentinVC = [[AttentionViewController alloc] init];
        attentinVC.hidesBottomBarWhenPushed = YES;
        //浏览历史
        HistoryViewController *historyVC = [[HistoryViewController alloc] init];
        historyVC.hidesBottomBarWhenPushed = YES;
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:messageVC animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:collectionVC animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:attentinVC animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:historyVC animated:YES];
                break;
            case 4:
                [self.navigationController pushViewController:policyVC animated:YES];
                break;
            case 5:
                [self logOutWithAlertView];
                break;
            default:
                break;
        }
        
    }
}
#pragma mark -- 退出登录按钮点击方法
- (void)logoutClickAction {
    //退出登录按钮点击方法，在这里判断是否登录，如果是登录状态退出，否则提示请登录
    
    [self showMBProgressHUDWithMessage:@"请先登录" showLabel:YES isShowTime:YES];
    
}
#pragma mark -- 退出登录alert view
- (void)logOutWithAlertView {
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    if (IsNilOrNull(user)||[user isEqualToString:@""]) {
        
        [self showMBProgressHUDWithMessage:@"请先登录" showLabel:YES isShowTime:YES];

    }else{
        
        WeakSelf(self);
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"确定退出登录吗" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //确定退出登录，刷新数据
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUser];
            [weakSelf showMBProgressHUDWithMessage:@"" showLabel:NO isShowTime:NO];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //            code to be executed after a specified delay
                //头部视图改变值和状态
                [weakSelf.headerView setHeaderViewWithDictionary:[NSDictionary new]];
                [weakSelf showMBProgressHUDWithMessage:@"已退出登录" showLabel:YES isShowTime:YES];
            });
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [alertView addAction:sureAction];
        [alertView addAction:cancelAction];
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
}
#pragma mark -- userImage点击方法
- (void)userImageTapAction {
    //判断如果已经登录，则去往编辑页面，没有登录进入登录页面
    NSString *user = [[NSUserDefaults standardUserDefaults] valueForKey:kUser];
//    user = @"";
    if (!IsNilOrNull(user)&&![user isEqualToString:@""]) {
        //去往编辑页面
        EditUserViewController *editUserVC = [[EditUserViewController alloc] init];
        editUserVC.image = self.headerView.userImage.image;
        editUserVC.userName = self.headerView.loginBut.titleLabel.text;
        editUserVC.editDelegate = self;
        [self presentViewController:editUserVC animated:YES completion:nil];
    }else{
        //显示登录页面
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:^{
            //预留
        }];
        
    }
}
#pragma mark -- 编辑页面代理返回方法
- (void)getEditUserImage:(UIImage *)image {
    
    self.headerView.userImage.image = image;
    NSData *data = UIImagePNGRepresentation(image);
    NSDictionary *dic = [self getUserInfoDictionary];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [userDic setObject:data forKey:kUserImage];
    [self updateUserInfoWithDictionary:userDic];
}
- (void)getUserNickName:(NSString *)string {
    
    [self.headerView.loginBut setTitle:string forState:(UIControlStateNormal)];
    NSDictionary *dic = [self getUserInfoDictionary];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [userDic setObject:string forKey:kNickName];
    [self updateUserInfoWithDictionary:userDic];
}
#pragma mark -- loginButton点击方法
- (void)loginButtonClickAction {
    //判断是否已经登录，如果登录进入编辑页面，没有进入登录页面
   NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    if (IsNilOrNull(user)||[user isEqualToString:@""]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        
        EditUserViewController *editUserVC = [[EditUserViewController alloc] init];
        editUserVC.image = self.headerView.userImage.image;
        editUserVC.userName = self.headerView.loginBut.titleLabel.text;
        editUserVC.editDelegate = self;
        [self presentViewController:editUserVC animated:YES completion:nil];
    }
}
#pragma mark -- loginview登录状态
- (void)getLoginViewLogStatus:(BOOL)status name:(NSString *)name {
    
    if (status) {
        //已经登录
        NSDictionary *dic = [self getUserInfoDictionary];
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [mutDic setObject:name forKey:@"name"];
        [self updateUserInfoWithDictionary:mutDic];
        [self.headerView setHeaderViewWithDictionary:mutDic];
    }
    
}
#pragma mark -- 懒加载
- (NSArray *)itemTitleArray {
    
    if (!_itemTitleArray) {
        
        _itemTitleArray = [NSArray arrayWithObjects:@"我的消息",@"我的收藏",@"我的关注",@"浏览历史",@"用户协议",@"退出登录", nil];
    }
    return _itemTitleArray;
}
- (NSArray *)itemIconArray {
    
    if (!_itemIconArray) {
        
        _itemIconArray = [NSArray arrayWithObjects:@"ic_me_item_message_20x20_",@"ic_me_item_collection_comic_20x20_",@"ic_me_item_collection_topic_20x20_",@"history_mine",@"userpolicy_mine",@"logout", nil];
    }
    return _itemIconArray;
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
