//
//  WorldViewController.m
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "WorldViewController.h"
#import "LLNetwork.h"
#import "CollectionViewCell.h"
#import "ClassModel/ClassModel.h"
#import "ClassDetailViewController.h"

#import "MHNetworking.h"
#import "GalleryItemModel.h"
#import "CollectionHeaderView.h"
#import "SDCycleScrollView.h"
#import "RightDetailViewController.h"



static NSString *const class_identifier = @"ClassCollectionViewCell";
static NSString *const collectionHeader_identifier = @"CollectionHeaderView";
@interface WorldViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;//
//@property(nonatomic,strong) AFHTTPRequestOperation *classDataOperation;//分类数据请求
@property(nonatomic,strong) NSMutableArray *classModelArray;//存储数据model数组
@property(nonatomic,strong) NSMutableArray *galleryArray;//存放banner数据
@property(nonatomic,strong) NSMutableArray *bannerUrlArray;//图片数组方便穿件轮播图
@property(nonatomic,strong) SDCycleScrollView *scrollView;//banner无限轮播


@end

@implementation WorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //
    self.title = @"分类";
    [self createSubviews];
    //获取banner数据
    [self fetchDiscoverData];
    //进行网络请求
    [self fetchClassDataOperation];
    //创建子视图
}


- (void)createSubviews{
    
    //
    [self.navigationController.navigationBar setBarTintColor:kRGB(251, 227, 76, 1)];
    self.navigationController.navigationBar.translucent = NO;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kSCREEN_Width/2-4, 200);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 2;
    flowLayout.headerReferenceSize = CGSizeMake(kSCREEN_Width, 200);
//    flowLayout.headerReferenceSize = CGSizeMake(kSCREEN_Width, 200);
    self.collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height-self.tabBarController.tabBar.bounds.size.height-64)) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    //
    [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    //collectionView注册单元格
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:class_identifier];
    //注册头部视图
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeader_identifier];
    
}
#pragma mark -- 进行分类的网络请求
- (void)fetchClassDataOperation {
    //根据分类信息将分类信息请求下来，network里实现
    NSNumber *number = [NSNumber numberWithInt:2];
    [self.parameter setObject:number forKey:@"v"];
//    self.classDataOperation = [NCNetwork getClassDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getClassParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *)result;
        int code = [dic[@"code"] intValue];
        if (code == 1) {
            //code等于1就是请求成功
            NSDictionary *totalDic = dic[@"data"];
            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
                
                NSDictionary *returnDic = totalDic[@"returnData"];
                NSArray *array = returnDic[@"rankingList"];
                for (NSDictionary *dic in array) {
                    
                    ClassModel *model = [[ClassModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.classModelArray addObject:model];
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
#pragma mark -- 获取banner数据
- (void)fetchDiscoverData {
    
    //    parmeters["sexType"] = sexType
    //    parmeters["v"] = 3320101
//    [self showMBProgressHUDWithMessage:@"加载中" showLabel:YES isShowTime:NO];
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
#pragma mark -- collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.classModelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:class_identifier forIndexPath:indexPath];
    ClassModel *model = [[ClassModel alloc] init];
    model = self.classModelArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.cover];
    [cell.cellImage sd_setImageWithURL:url];
    cell.className.text = IsNilOrNull(model.sortName)?@"":model.sortName;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassDetailViewController *classDetailVC = [[ClassDetailViewController alloc] init];
    //数据参数传递
    ClassModel *model = self.classModelArray[indexPath.row];
    NSNumber *argValue = [NSNumber numberWithLong:(long)model.argValue];
    classDetailVC.argValue = argValue;
    classDetailVC.argName = model.argName;
    classDetailVC.hidesBottomBarWhenPushed = YES;
    classDetailVC.title = model.sortName;
    [self.navigationController pushViewController:classDetailVC animated:YES];
    
}
//头部视图代理
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
#pragma mark -- 网络请求返回函数
//- (void)successCallBack:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject {
//
//    NSLog(@"%@",responseObject);
//    int code = [responseObject[@"code"] intValue];
//    if (code == 1) {
//        //code等于1就是请求成功
//        NSDictionary *totalDic = responseObject[@"data"];
//        if ([totalDic[@"message"] isEqualToString:@"成功"]) {
//
//            NSDictionary *returnDic = totalDic[@"returnData"];
//            NSArray *array = returnDic[@"rankingList"];
//            for (NSDictionary *dic in array) {
//
//                ClassModel *model = [[ClassModel alloc] init];
//                [model setValuesForKeysWithDictionary:dic];
//                [self.classModelArray addObject:model];
//            }
//            [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
//            [self.collectionView reloadData];
//        }
//    }
//
//}
//
//- (void)failureCallBack:(AFHTTPRequestOperation *)operation error:(NSError *)error {
//
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [self showMBProgressHUDWithMessage:@"网络错误请重试" showLabel:YES isShowTime:YES];
//
//}
#pragma mark -- 懒加载
- (NSMutableArray *)classModelArray {
    
    if (!_classModelArray) {
        
        _classModelArray = [[NSMutableArray alloc] init];
    }
    
    return _classModelArray;
}
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
