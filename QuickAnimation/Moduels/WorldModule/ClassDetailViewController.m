//
//  ClassDetailViewController.m
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "LLNetwork.h"
#import "ClassDTableViewCell.h"
#import "ComicsModel.h"
#import "RightDetailViewController.h"
#import "MHNetworking.h"


static NSString *const cd_identifier = @"ClassDTableViewCell";
@interface ClassDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

//@property(nonatomic,strong) AFHTTPRequestOperation *classDetailOperation;//
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *comicDataArray;//漫画数据数组

@end

@implementation ClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //发起网络请求
    [self fetchClassDetailData];
    //创建子视图
    [self createSubViews];
}

#pragma mark -- 获取网络请求分类详细信息
- (void)fetchClassDetailData {
    
    /*
     parmeters["argCon"] = argCon
     if argName.count > 0 { parmeters["argName"] = argName }
     parmeters["argValue"] = argValue
     parmeters["page"] = max(1, page)
     */
    [self.parameter setObject:self.argName forKey:@"argName"];
    [self.parameter setObject:self.argValue forKey:@"argValue"];
    NSNumber *argCon = [NSNumber numberWithInt:0];
    [self.parameter setObject:argCon forKey:@"argCon"];
    NSNumber *page = [NSNumber numberWithInt:1];
    [self.parameter setObject:page forKey:@"page"];
//    self.classDetailOperation = [NCNetwork getHotDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getHotDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *)result;
        //请求成功会掉函数
        NSString *msg = dic[@"msg"];
        //    long code = (long)responseObject[@"code"];
        if ([msg isEqualToString:@"执行成功"]) {
            NSDictionary *totalDic = dic[@"data"];
            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
                NSDictionary *returnDic = totalDic[@"returnData"];
                //返回数据字典
                NSArray *array = returnDic[@"comics"];
                for (NSDictionary *dic in array) {
                    
                    ComicsModel *model = [[ComicsModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.comicDataArray addObject:model];
                }
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.tableView reloadData];
            }
        }
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络请求错误请重试" showLabel:YES isShowTime:YES];
    }];
    
}
#pragma mark -- 创建子视图
- (void)createSubViews {
    
    //更改详情页左侧返回按钮样子
    UIImage *backImage = [UIImage imageNamed:@"ic_nav_second_back_normal_17x17_"];
    backImage = [backImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:backImage style:(UIBarButtonItemStyleDone) target:self action:@selector(backItemClickAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;

    //添加tableview
    _tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height)) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [UIView new];
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"ClassDTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cd_identifier];
    //
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
#pragma mark -- 返回按钮点击方法
- (void)backItemClickAction {
    //返回上个视图
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.comicDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cd_identifier];
    ComicsModel *model = self.comicDataArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.cover];
    [cell.cellImage sd_setImageWithURL:url];
    cell.nameLabel.text = model.name;
    cell.autherLabel.text = model.author;
    cell.typeLabel.text = model.short_description;
    cell.descriptionLabel.text = model.a_description;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ComicsModel *model = self.comicDataArray[indexPath.row];
    RightDetailViewController *rightDetailVC = [[RightDetailViewController alloc] init];
    rightDetailVC.comicId = [NSNumber numberWithLong:model.comicId];
    [self.navigationController pushViewController:rightDetailVC animated:YES];
}
#pragma mark -- 网络请求返回接口
//- (void)successCallBack:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject {
//
//    NSLog(@"%@",responseObject);
//    //请求成功会掉函数
//    NSString *msg = responseObject[@"msg"];
//    //    long code = (long)responseObject[@"code"];
//    if ([msg isEqualToString:@"执行成功"]) {
//        NSDictionary *totalDic = responseObject[@"data"];
//        if ([totalDic[@"message"] isEqualToString:@"成功"]) {
//            NSDictionary *returnDic = totalDic[@"returnData"];
//            //返回数据字典
//            NSArray *array = returnDic[@"comics"];
//            for (NSDictionary *dic in array) {
//
//                ComicsModel *model = [[ComicsModel alloc] init];
//                [model setValuesForKeysWithDictionary:dic];
//                [self.comicDataArray addObject:model];
//            }
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self.tableView reloadData];
//        }
//    }
//
//
//}
//- (void)failureCallBack:(AFHTTPRequestOperation *)operation error:(NSError *)error {
//
//
//    [self showMBProgressHUDWithMessage:@"网络错误请重试" showLabel:YES isShowTime:YES];
//
//}
#pragma mark -- 懒加载
- (NSMutableArray *)comicDataArray {
    
    if (!_comicDataArray) {
        
        _comicDataArray = [[NSMutableArray alloc] init];
    }
    
    return _comicDataArray;
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
