//
//  DiscoverViewController.m
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "DiscoverViewController.h"
#import "SDCycleScrollView.h"
#import "DiscoverTableViewCell.h"
#import "DiscoverCollectionViewCell.h"
#import "DiscoverDetailViewController/Dis_DetailViewController.h"
#import "LLNetwork.h"
#import "GalleryItemModel.h"
//
#import "CollectionHeaderView.h"
#import "ComicsModel.h"
//
#import "RightDetailViewController.h"
#import "MHNetworking.h"


NSString *const collectionHeader_identifier = @"CollectionViewHeader";
NSString *const collection_identifier = @"DiscoverCollectionViewCell";

@interface DiscoverViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) SDCycleScrollView *scrollView;//banner无限轮播
@property(nonatomic,strong) UICollectionView *collectionView;//
//@property(nonatomic,strong) AFHTTPRequestOperation *botiqueOperation;//推荐operation操作
//@property(nonatomic,strong) AFHTTPRequestOperation *recommendOperation;//推荐operation操作


@property(nonatomic,strong) NSMutableArray *galleryArray;//banner数组
@property(nonatomic,strong) NSMutableArray *bannerUrlArray;//
//吃完饭回来将tableView改成collectionView。完成collectionView头部视图，今天必须完成这两个页面
@property(nonatomic,strong) NSMutableArray *comicArray;//漫画数组

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //获取banner信息
    [self fetchDiscoverData];
    //直接获取到人气推荐漫画
    [self fetchRecommendData];
    //设置子视图
    [self setUpSubViews];
}
#pragma mark -- 创建子视图
- (void)setUpSubViews {
//    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height)) style:(UITableViewStylePlain)];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:self.tableView];
    //
    [self.navigationController.navigationBar setBarTintColor:kRGB(251, 227, 76, 1)];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"发现";
    //
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((kSCREEN_Width-6)/2, 200);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 2;
    flowLayout.headerReferenceSize = CGSizeMake(kSCREEN_Width, 200);
    self.collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height-self.tabBarController.tabBar.bounds.size.height-64)) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    //在创建视图后添加等待转
    [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    //注册头部视图
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeader_identifier];
    //注册单元格
    [self.collectionView registerClass:[DiscoverCollectionViewCell class] forCellWithReuseIdentifier:collection_identifier];
//    NSArray *imageArray = [NSArray arrayWithObjects:@"nurto.jpg",@"nurto.jpg",@"nurto.jpg", nil];
#pragma mark -- tableView注册单元格
//    UINib *nib = [UINib nibWithNibName:@"DiscoverTableViewCell" bundle:nil];
//    [self.tableView registerClass:[DiscoverTableViewCell class] forCellReuseIdentifier:table_identifier];

}
#pragma mark -- tableView设置头部视图
- (void)setTableViewHeaderView {
    
    //    NSArray *imageArray = [NSArray arrayWithObjects:@"nurto.jpg",@"nurto.jpg",@"nurto.jpg", nil];
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:(CGRectMake(0, 0, kSCREEN_Width, 200)) imageURLStringsGroup:self.bannerUrlArray];
    self.scrollView.delegate = self;
//    self.tableView.tableHeaderView = self.scrollView;
}
//#pragma mark -- 视图将要出现的时候 隐藏本身的导航条 加载自定义的导航条
//- (void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setHidden:YES];
////    [self prefersStatusBarHidden];
//}
//- (void)viewWillDisappear:(BOOL)animated {
//
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setHidden:NO];
//}
#pragma mark -- 请求发现页面接口
- (void)fetchDiscoverData {
    
//    parmeters["sexType"] = sexType
//    parmeters["v"] = 3320101
    [self showMBProgressHUDWithMessage:@"加载中" showLabel:YES isShowTime:NO];
    [self.parameter setObject:@"1" forKey:@"sexType"];
    [self.parameter setObject:@"3320101" forKey:@"v"];
//    self.botiqueOperation = [NCNetwork getComicBoutiqueDetailDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getComicBoutiqueDetailDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *)result;
        int code = [dic[@"code"] intValue];
        if (code == 1) {
            //code等于1就是请求成功
            NSDictionary *totalDic = dic[@"data"];
            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
                
                NSDictionary *returnDic = totalDic[@"returnData"];
                NSArray *galleryList = returnDic[@"galleryItems"];
                for (NSDictionary *dic in galleryList) {
                    
                    GalleryItemModel *model = [[GalleryItemModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.galleryArray addObject:model];
                    [self.bannerUrlArray addObject:model.cover];
                }
                [self.collectionView reloadData];
            }
        }
        
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络请求错误请重试" showLabel:YES isShowTime:YES];
    }];
    
}
- (void)fetchRecommendData {
    
    /*
     parmeters["argCon"] = argCon
     if argName.count > 0 { parmeters["argName"] = argName }
     parmeters["argValue"] = argValue
     parmeters["page"] = max(1, page)
     argName    String    "topic"
     argCon    Int    0
     argValue    Int    9
     page    Int    1
     */
    NSNumber *argCon = [NSNumber numberWithInt:0];
    [self.parameter setObject:argCon forKey:@"argCon"];
    NSNumber *argValue = [NSNumber numberWithInt:9];
    [self.parameter setObject:argValue forKey:@"argValue"];
    NSNumber *page = [NSNumber numberWithInt:1];
    [self.parameter setObject:page forKey:@"page"];
    [self.parameter setObject:@"topic" forKey:@"argName"];
//    self.recommendOperation = [NCNetwork getRecommendDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getRecommendDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *)result;
        int code = [dic[@"code"] intValue];
        if (code == 1) {
            //code等于1就是请求成功
            NSDictionary *totalDic = dic[@"data"];
            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
                
                NSDictionary *returnDic = totalDic[@"returnData"];
                NSArray *array = returnDic[@"comics"];
                for (NSDictionary *dic in array) {
                    
                    ComicsModel *model = [[ComicsModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.comicArray addObject:model];
                }
                [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
                [self.collectionView reloadData];
            }
        }
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络请求错误请重试" showLabel:YES isShowTime:YES];
    }];
}
#pragma mark -- scrollView代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

    //轮播图按下标贝点击了跳转到相应页面,根据index去找
    RightDetailViewController *rightDetailVC = [[RightDetailViewController alloc] init];
    rightDetailVC.hidesBottomBarWhenPushed = YES;
    GalleryItemModel *model = self.galleryArray[index];
    NSString *comic_id = IsNilOrNull(model.comicId)?@"":model.comicId;
    rightDetailVC.comicId = @([comic_id integerValue]);
    [self.navigationController pushViewController:rightDetailVC animated:YES];
}
#pragma mark -- tableView代理方法
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//
//    return 6;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//
//    return 160;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//  DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:table_identifier];
//    DiscoverTableViewCell *cell = [[DiscoverTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:collection_identifier];
//    cell.collectionView.delegate = self;
//    cell.collectionView.dataSource = self;
//    [cell.collectionView registerClass:[DiscoverCollectionViewCell class] forCellWithReuseIdentifier:collection_identifier];
//
//    return cell;
//}
#pragma mark -- collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.comicArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DiscoverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collection_identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    ComicsModel *model = self.comicArray[indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:model.cover];
    [cell.imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage new]];
    cell.topLabel.text = model.name;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
       CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeader_identifier forIndexPath:indexPath];
        self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:(CGRectMake(0, 0, kSCREEN_Width, 200)) imageURLStringsGroup:self.bannerUrlArray];
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:self.scrollView];
        return headerView;
    }
    return [UICollectionReusableView new];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RightDetailViewController *rightDetailVC = [[RightDetailViewController alloc] init];
    rightDetailVC.hidesBottomBarWhenPushed = YES;
    ComicsModel *model = self.comicArray[indexPath.row];
    rightDetailVC.comicId = [NSNumber numberWithLong:model.comicId];
    [self.navigationController pushViewController:rightDetailVC animated:YES];
}

#pragma mark -- 网络亲求返回
//- (void)successCallBack:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject {
//
//    if ([operation isEqual:self.botiqueOperation]) {
//
//        int code = [responseObject[@"code"] intValue];
//        if (code == 1) {
//            //code等于1就是请求成功
//            NSDictionary *totalDic = responseObject[@"data"];
//            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
//
//                NSDictionary *returnDic = totalDic[@"returnData"];
//                NSArray *galleryList = returnDic[@"galleryItems"];
//                for (NSDictionary *dic in galleryList) {
//
//                    GalleryItemModel *model = [[GalleryItemModel alloc] init];
//                    [model setValuesForKeysWithDictionary:dic];
//                    [self.galleryArray addObject:model];
//                    [self.bannerUrlArray addObject:model.cover];
//                }
//                [self.collectionView reloadData];
//            }
//        }
//
//    }else if ([operation isEqual:self.recommendOperation]){
//
//        int code = [responseObject[@"code"] intValue];
//        if (code == 1) {
//            //code等于1就是请求成功
//            NSDictionary *totalDic = responseObject[@"data"];
//            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
//
//                NSDictionary *returnDic = totalDic[@"returnData"];
//                NSArray *array = returnDic[@"comics"];
//                for (NSDictionary *dic in array) {
//
//                    ComicsModel *model = [[ComicsModel alloc] init];
//                    [model setValuesForKeysWithDictionary:dic];
//                    [self.comicArray addObject:model];
//                }
//                [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
//                [self.collectionView reloadData];
//            }
//        }
//
//    }
//
//}
//
//- (void)failureCallBack:(AFHTTPRequestOperation *)operation error:(NSError *)error {
//
//    [self showMBProgressHUDWithMessage:@"网络错误请重试" showLabel:YES isShowTime:YES];
//
//}
#pragma mark -- 懒加载
- (NSMutableArray *)galleryArray {
    
    if (!_galleryArray) {
        
        _galleryArray = [[NSMutableArray alloc] init];
    }
    
    return _galleryArray;
}
- (NSMutableArray *)bannerUrlArray {
    
    if (!_bannerUrlArray) {
        
        _bannerUrlArray = [[NSMutableArray alloc] init];
    }
    
    return _bannerUrlArray;
}
- (NSMutableArray *)comicArray {
    
    if (!_comicArray) {
        
        _comicArray = [[NSMutableArray alloc] init];
    }
    
    return _comicArray;
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
