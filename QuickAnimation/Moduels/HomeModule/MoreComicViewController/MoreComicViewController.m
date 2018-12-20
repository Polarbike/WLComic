//
//  MoreComicViewController.m
//  QuickAnimation
//
//  Created by Weilian on 12/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "MoreComicViewController.h"
#import "LLNetwork.h"
#import "ComicsModel.h"
#import "ClassDTableViewCell.h"
//导入漫画详情页
#import "RightDetailViewController.h"
#import "MHNetworking.h"



static NSString *const more_identifier = @"ClassDTableViewCell";

@interface MoreComicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;//更多漫画视图
//@property(nonatomic,strong) AFHTTPRequestOperation *moreComicOperation;//更多漫画操作
@property(nonatomic,strong) NSMutableArray *moreComicArray;//更多漫画数组

@end

@implementation MoreComicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建子视图
    [self createSubviews];
    //请求更多的数据
    [self fetchMoreComicData];
    
}

- (void)createSubviews {
    
    //更改详情页左侧返回按钮样子
    UIImage *backImage = [UIImage imageNamed:@"ic_nav_second_back_normal_17x17_"];
    backImage = [backImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:backImage style:(UIBarButtonItemStyleDone) target:self action:@selector(backItemClickAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    //
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height-64)) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    //tableView注册单元格
    UINib *nib = [UINib nibWithNibName:@"ClassDTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:more_identifier];
}
#pragma mark -- 返回按钮点击方法
- (void)backItemClickAction {
    //返回上个视图
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 请求更多按钮请求数据
- (void)fetchMoreComicData {
    
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [self.parameter setObject:self.acrCon forKey:@"argCon"];
    [self.parameter setObject:self.argName forKey:@"argName"];
    [self.parameter setObject:self.argValue forKey:@"argValue"];
    [self.parameter setObject:self.page forKey:@"page"];
//    self.moreComicOperation = [NCNetwork getHotDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getHotDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *)result;
        int code = [(dic[@"code"]) intValue];
        if (code == 1) {
            
            NSDictionary *totalDic = dic[@"data"];
            NSDictionary *returnDic = totalDic[@"returnData"];
            NSArray *array = returnDic[@"comics"];
            for (NSDictionary *dic in array) {
                
                ComicsModel *model = [[ComicsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.moreComicArray addObject:model];
            }
            //
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        }
        
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络请求错误请重试" showLabel:YES isShowTime:YES];
    }];
}

#pragma mark -- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.moreComicArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:more_identifier];
    ComicsModel *model = self.moreComicArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.cover];
    [cell.cellImage sd_setImageWithURL:url];
    cell.nameLabel.text = model.name;
    cell.autherLabel.text = model.author;
    cell.typeLabel.text = model.short_description;
    cell.descriptionLabel.text = model.a_description;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RightDetailViewController *rightDetailVC = [[RightDetailViewController alloc] init];
    ComicsModel *comicModel = self.moreComicArray[indexPath.row];
    rightDetailVC.comicId = [NSNumber numberWithLong:comicModel.comicId];
    rightDetailVC.title = comicModel.name;
    [self.navigationController pushViewController:rightDetailVC animated:YES];
}

#pragma mark -- 网络数据请求返回接口
////请求成功返回
//- (void)successCallBack:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject {
//    
//    int code = [(responseObject[@"code"]) intValue];
//    if (code == 1) {
//        
//        NSDictionary *totalDic = responseObject[@"data"];
//        NSDictionary *returnDic = totalDic[@"returnData"];
//        NSArray *array = returnDic[@"comics"];
//        for (NSDictionary *dic in array) {
//            
//            ComicsModel *model = [[ComicsModel alloc] init];
//            [model setValuesForKeysWithDictionary:dic];
//            [self.moreComicArray addObject:model];
//        }
//        //
//        [self.tableView reloadData];
//        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//    }
//}
////请求返回失败
//- (void)failureCallBack:(AFHTTPRequestOperation *)operation error:(NSError *)error {
//    
//    
//    
//    
//    
//}

#pragma mark -- 懒加载
- (NSMutableArray *)moreComicArray {
    
    if (!_moreComicArray) {
        
        _moreComicArray = [[NSMutableArray alloc] init];
    }
    return _moreComicArray;
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
