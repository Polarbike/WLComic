//
//  RightDetailViewController.m
//  QuickAnimation
//
//  Created by Weilian on 29/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "RightDetailViewController.h"
#import "RightDetailHeader.h"
#import "RigthDetailTableViewCell.h"

#import "RightDetailVIew.h"
#import "DetailTittleButton.h"//在这里不到入detailbutton.h 无法找到delegate
//导入网络请求类
#import "LLNetwork.h"
//导入数据模型
#import "ComicDetailModel.h"
#import "ChapterModel.h"
//导入collection View的cell
#import "ChapterCollectionViewCell.h"
//导入评论tableview列表
#import "CommentTableViewCell.h"
//导入评论模型
#import "CommentModel.h"

#import "NSString+Height.h"
#import "CommentListTableViewCell.h"
//动画未完成
#import "KYBubbleInteractiveTransition.h"
//导入漫画详情页
#import "ComicDetailViewController.h"
#import "MHNetworking.h"



static NSString *rightDetail_identifier = @"RightDetailCell";
static NSString *chapter_identifier = @"ChapterCollectionViewCell";//
static NSString *const comment_identifier = @"CommentTableViewCell";


@interface RightDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DetailTittleClickDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) RightDetailHeader *detailHeaderView;//
@property(nonatomic,strong) RightDetailVIew *detailView;
@property(nonatomic,strong) UITableView *tableView;//tableView
//@property(nonatomic,strong) AFHTTPRequestOperation *comicDetailOperation;//漫画详情
//@property(nonatomic,strong) AFHTTPRequestOperation *commentDataOperation;//评论请求操作
//@property(nonatomic,strong) AFHTTPRequestOperation *comicRealTimeDataOperation;//评论请求操作


//
@property(nonatomic,strong) ComicDetailModel *comicDetailModel;
@property(nonatomic,strong) NSMutableArray *chapterArray;//章回model数组
@property(nonatomic,strong) NSMutableArray *commentArray;//评论model数组
@property(nonatomic,strong) NSMutableArray *commentHightArray;//comment内容高度数组

@property(nonatomic,assign) BOOL isHorizontal;
@property(nonatomic,strong) UIButton *collectionButton;
@property(nonatomic,assign) BOOL isRightSelected;//收藏按钮是否点击
@property(nonatomic,strong) NSMutableArray *nameArray;//判断漫画名字看是否已收藏
@end

@implementation RightDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载请求网络数据
    [self fetchDatailData];
    ////创建子视图
    [self createSubviews];
    self.extendedLayoutIncludesOpaqueBars = NO;
    //不添加这个方法会从最上面计算布局，不会从导航栏下计算布局
    self.navigationController.navigationBar.translucent = NO;
    
}
//#pragma mark -- 确保导航栏不被隐藏
//- (void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setHidden:NO];
//}

#pragma mark -- comic详情网络数据请求
- (void)fetchDatailData {
    /*
     parmeters["comicid"] = comicid
     parmeters["v"] = 3320101
     */
    NSNumber *number = [NSNumber numberWithInt:3320101];
    [self.parameter setObject:self.comicId forKey:@"comicid"];
    [self.parameter setObject:number forKey:@"v"];
//    self.comicDetailOperation = [NCNetwork getComicDetailDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getComicDetailDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *)result;
        int code = [dic[@"code"] intValue];
        if (code == 1) {
            //code等于1就是请求成功
            NSDictionary *totalDic = dic[@"data"];
            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
                
                NSDictionary *returnDic = totalDic[@"returnData"];
                NSDictionary *comicDic = returnDic[@"comic"];
                //comicDetailModel,设置页面基本信息
                [self.comicDetailModel setValuesForKeysWithDictionary:comicDic];
                //
                NSArray *collectArray = [[NSUserDefaults standardUserDefaults] objectForKey:kCollectionArray];
                NSMutableArray *array = [NSMutableArray arrayWithArray:collectArray];
                for (NSDictionary *dic in array) {
                    
                    NSString *name = dic[@"name"];
                    [self.nameArray addObject:name];
                }
                if ([self.nameArray containsObject:self.comicDetailModel.name]) {
                    
                    [self.collectionButton setImage:[UIImage imageNamed:@"ic_details_top_collection_prressed_21x21_"] forState:(UIControlStateNormal)];
                }
                //在detailModel赋值完成后就可以c刷新tableview
                [self.detailView.detailTableView reloadData];
                //对tableView的头部视图进行赋值
                self.detailHeaderView.comicModel = self.comicDetailModel;
                //ChapterModel,赋值模型信息
                NSArray *chapter = returnDic[@"chapter_list"];//章回列表
                for (NSDictionary *dic in chapter) {
                    
                    ChapterModel *model = [[ChapterModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.chapterArray addObject:model];
                }
                [MBProgressHUD hideHUDForView:self.view animated:YES];//隐藏
                //循环赋值完成后刷新章回信息列表
                [self.detailView.collectionView reloadData];
                //根据self.comicDetailModel的值进行评论数据请求
                [self fetchCommentData];
            }
        }
        
        
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络连接错误" showLabel:YES isShowTime:YES];
    }];
    [self showMBProgressHUDWithMessage:@"加载中" showLabel:YES isShowTime:NO];
//    self.comicRealTimeDataOperation = [NCNetwork getComicRealTimeDataWithDelegate:self parameters:self.parameter];
}
#pragma mark -- 评论数组网络请求
- (void)fetchCommentData {
    
//    parmeters["object_id"] = object_id
//    parmeters["thread_id"] = thread_id
//    parmeters["page"] = page
    //"comment/list"
    NSString *object_id = self.comicDetailModel.comic_id;
    NSString *thread_id = self.comicDetailModel.thread_id;
    NSString *page = @"-1";

    [self.parameter setObject:object_id forKey:@"object_id"];
    [self.parameter setObject:thread_id forKey:@"thread_id"];
    [self.parameter setObject:page forKey:@"page"];
//    self.commentDataOperation = [NCNetwork getComicCommentDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getComicCommentDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *)result;
        int code = [dic[@"code"] intValue];
        if (code == 1) {
            //code等于1就是请求成功
            NSDictionary *totalDic = dic[@"data"];
            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
                
                NSDictionary *returnDic = totalDic[@"returnData"];
                NSArray *commentList = returnDic[@"commentList"];
                for (NSDictionary *dic in commentList) {
                    
                    CommentModel *commentModel = [[CommentModel alloc] init];
                    [commentModel setValuesForKeysWithDictionary:dic];
                    [self.commentArray addObject:commentModel];
                    
                    NSString *content = commentModel.content_filter;
                    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
                    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@"k"];
                    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@"k"];
                    content = [content stringByReplacingOccurrencesOfString:@"" withString:@"k"];
                    CGFloat height = [self getCommentHeightWithString:content];
                    CGSize size = [content textSizeWithFont:[UIFont fontWithName:Font_Name_PFSCRe size:12] constrainedToSize:CGSizeMake(kSCREEN_Width-20, MAXFLOAT)];
                    height = ceilf(size.height)+1;
                    NSNumber *number = [NSNumber numberWithFloat:height];
                    [self.commentHightArray addObject:number];//根据计算高度
                }
                [self.detailView.commentTableView reloadData];
            }
    }
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络连接错误请重试" showLabel:YES isShowTime:YES];
    }];
}
#pragma mark -- 创建子视图
- (void)createSubviews {
    
    //创建头部视图
    self.detailHeaderView = [[RightDetailHeader alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, 300))];
    self.detailHeaderView.tittleButton.buttonDelegate = self;
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"岸本齐明",@"author",@"火影忍者",@"name", nil];
//    [self.detailHeaderView setContentWithDictionary:dic];
    [self.view addSubview:self.detailHeaderView];
    
    //更改详情页左侧返回按钮样子
    UIImage *backImage = [UIImage imageNamed:@"ic_nav_second_back_normal_17x17_"];
    backImage = [backImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:backImage style:(UIBarButtonItemStyleDone) target:self action:@selector(backItemClickAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    //添加右侧收藏按钮,使用button自定义。
    self.collectionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIImage *collectImage = [UIImage imageNamed:@"ic_details_top_collection_normal_21x21_"];
    [self.collectionButton setImage:collectImage forState:(UIControlStateNormal)];
    [self.collectionButton addTarget:self action:@selector(collectItemClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *collectBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.collectionButton];
//    collectImage = [collectImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//    UIBarButtonItem *collectBarItem = [[UIBarButtonItem alloc] initWithImage:collectImage style:(UIBarButtonItemStyleDone) target:self action:@selector(collectItemClickAction:)];
    self.navigationItem.rightBarButtonItem = collectBarItem;
    //rightDetailView包含tableview collectionview tableview
    self.detailView = [[RightDetailVIew alloc] initWithFrame:(CGRectMake(0, 300, kSCREEN_Width, kSCREEN_Height-300-64))];
    self.detailView.detailTableView.delegate = self;
    self.detailView.detailTableView.dataSource = self;
    self.detailView.collectionView.delegate = self;
    self.detailView.collectionView.dataSource = self;
    self.detailView.commentTableView.delegate = self;
    self.detailView.commentTableView.dataSource = self;
    //设置footerview
    self.detailView.detailTableView.tableFooterView = [UIView new];
    self.detailView.commentTableView.tableFooterView = [UIView new];
    //self.detail的代理方法delegate
    self.detailView.delegate = self;
    [self.view addSubview:self.detailView];
    //collectionView注册单元格
    UINib *chapter_nib = [UINib nibWithNibName:@"ChapterCollectionViewCell" bundle:nil];
    [self.detailView.collectionView registerNib:chapter_nib forCellWithReuseIdentifier:chapter_identifier];
    //详细信息注册xib的cell
    UINib *nib = [UINib nibWithNibName:@"RigthDetailTableViewCell" bundle:nil];
    [self.detailView.detailTableView registerNib:nib forCellReuseIdentifier:rightDetail_identifier];
    //comment评论列表cell注册xib
    UINib *comment_nib = [UINib nibWithNibName:@"CommentTableViewCell" bundle:nil];
    [self.detailView.commentTableView registerNib:comment_nib forCellReuseIdentifier:comment_identifier];
    //在创建完所有子视图后添加
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

#pragma mark -- tableview 的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.detailView.detailTableView]) {
        
        return 1;
    }else{
        
        return self.commentArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.detailView.detailTableView]) {
        
        return 280;
    }else{
        //解决cell高度问题
        NSNumber *height = self.commentHightArray[indexPath.row];
        CGFloat float_cell = [height floatValue]+70;
        return float_cell;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.detailView.detailTableView]) {
        
        RigthDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightDetail_identifier];
        cell.tittle.text = IsNilOrNull(self.comicDetailModel.name)?@"":self.comicDetailModel.name;
        cell.content.text = self.comicDetailModel.all_description;
        return cell;
    }else if([tableView isEqual:self.detailView.commentTableView]) {
        
//        CommentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:comment_identifier];
//
//        if (!cell) {
//
//            cell = [[CommentListTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:comment_identifier];
//        }
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:comment_identifier];
        CommentModel *model = [[CommentModel alloc] init];
        model = self.commentArray[indexPath.row];
        cell.commentModel = model;
        
        return cell;
    }else{
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    }
}
#pragma mark -- collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.chapterArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChapterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:chapter_identifier forIndexPath:indexPath];
    ChapterModel *model = [[ChapterModel alloc] init];
    model = self.chapterArray[indexPath.row];
    cell.chapterLabel.text = model.name;//
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //点开某一章漫画跳转到漫画详情页
    ComicDetailViewController *comicDetailVC = [[ComicDetailViewController alloc] init];
    ChapterModel *model = [[ChapterModel alloc] init];
    model = self.chapterArray[indexPath.row];
    comicDetailVC.chapter_id = model.chapter_id;
    [self.navigationController presentViewController:comicDetailVC animated:YES completion:nil];
    
}
#pragma mark -- 头部视图三个按钮点击方法代理方法
- (void)clickedButton:(UIButton *)button index:(NSInteger)index {
    //根据代理找到点击的按钮以及按钮的下标
    [self.detailView setContentOffset:CGPointMake(index*kSCREEN_Width, 0)];
}
#pragma mark -- 返回按钮点击方法
- (void)backItemClickAction {
    //在返回按钮里存储浏览历史
    NSArray *array = [NSArray array];
    array = [[NSUserDefaults standardUserDefaults] objectForKey:kHistoryArray];
    NSMutableArray *historyArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (!IsNilOrNull(self.comicDetailModel) && !IsNilOrNull(self.comicDetailModel.name)) {
        
        [dic setObject:self.comicDetailModel.name forKey:@"name"];
        [dic setObject:self.comicDetailModel.cover forKey:@"cover"];
        [dic setObject:self.comicDetailModel.comic_id forKey:@"comicId"];
        [dic setObject:self.comicDetailModel.author forKey:@"author"];
        [dic setObject:self.comicDetailModel.short_description forKey:@"shortDescription"];
        [historyArray addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:historyArray forKey:kHistoryArray];
    }
    //返回上个视图
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark -- 收藏按钮点击方法
- (void)collectItemClickAction:(UIButton *)button {
    //收藏
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    if (IsNilOrNull(user)||[user isEqualToString:@""]) {
        
        [self showAlertHUDWithMessage:@"请登录" showView:self.view];
    }else {
        //如果已经登录
        if (!self.isRightSelected) {
            
            self.isRightSelected = !self.isRightSelected;
            NSArray *collectArray = [[NSUserDefaults standardUserDefaults] objectForKey:kCollectionArray];
            NSMutableArray *array = [NSMutableArray arrayWithArray:collectArray];
            for (NSDictionary *dic in array) {
                
                NSString *name = dic[@"name"];
                [self.nameArray addObject:name];
            }
            if ([self.nameArray containsObject:self.comicDetailModel.name]) {
                
                [self showMBProgressHUDWithMessage:@"已经收藏过" showLabel:YES isShowTime:YES];

            }else{
                
                NSMutableDictionary *modelDic = [[NSMutableDictionary alloc] init];
                [modelDic setObject:self.comicDetailModel.name forKey:@"name"];
                [modelDic setObject:self.comicDetailModel.cover forKey:@"cover"];
                [modelDic setObject:self.comicDetailModel.comic_id forKey:@"comicId"];
                [modelDic setObject:self.comicDetailModel.author forKey:@"author"];
                [modelDic setObject:self.comicDetailModel.short_description forKey:@"shortDescription"];
                [array addObject:modelDic];
                [[NSUserDefaults standardUserDefaults] setObject:array forKey:kCollectionArray];
                //            [button setImage:[UIImage imageNamed:@"ic_details_top_collection_prressed_21x21_"] forState:(UIControlStateNormal)];
                [button setImage:[UIImage imageNamed:@"ic_details_top_collection_prressed_21x21_"] forState:(UIControlStateNormal)];
                [self showAlertHUDWithMessage:@"收藏成功" showView:self.view];
                
            }
        }else{
            
            [self showAlertHUDWithMessage:@"已经收藏过了" showView:self.view];
            
        }
    }
}
#pragma mark -- scrollview的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
    if(translatedPoint.x < 0 && translatedPoint.y == 0){
        
//        CGFloat contentOffset_x = scrollView.contentOffset.x;
//        CGFloat scanf = contentOffset_x/kSCREEN_Width*3;
//        CGFloat anim_x = scanf * kSCREEN_Width;
        //        CGRect rect = CGRectMake(anim_x, 0, 0, 0);
        //        [self.detailHeaderView.tittleButton scrollBarScrollAnimation:rect];
        self.isHorizontal = YES;
        NSLog(@"右滑");
    }else if(translatedPoint.x > 0 && translatedPoint.y == 0){
        
//        CGFloat contentOffset_x = scrollView.contentOffset.x;
//        CGFloat scanf = contentOffset_x/kSCREEN_Width*3;
//        CGFloat anim_x = scanf * kSCREEN_Width;
        self.isHorizontal = YES;
//        CGRect rect = CGRectMake(anim_x, 0, 0, 0);
//        [self.detailHeaderView.tittleButton scrollBarScrollAnimation:rect];
        NSLog(@"左滑");
    }else{
        
        //self.isHorizontal = NO;
        /*
         UIImageView *blurImgv = [[UIImageView alloc]initWithFrame:CGRectMake(50, 500, 150, 150)];
         blurImgv.image = image;
         [self.view addSubview:blurImgv];
         UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
         UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
         view.frame = blurImgv.frame;
         [self.view addSubview:view];
         */
    }

    //同理通过translatedPoint.y 进行判断上下滑动
}

//在scrollview已经完成减速的时候改变按钮的状态
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.isHorizontal) {//如果是水平方向滚动
     
        CGFloat offset_x = scrollView.contentOffset.x;
        NSInteger num = offset_x/kSCREEN_Width;
        CGFloat button_width = kSCREEN_Width/3;
        //
        CGRect rect = CGRectMake(button_width*num, 0, 0, 0);
        [self.detailHeaderView.tittleButton quicklyScrollBarScrollAnimation:rect];
        //在完成滑动后将是否水平滑动 置为no
        self.isHorizontal = NO;
    }
    
}

#pragma mark -- 网络请求返回代理方法
//- (void)successCallBack:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject {
//
//    if ([operation isEqual:self.comicDetailOperation]) {
//
//        int code = [responseObject[@"code"] intValue];
//        if (code == 1) {
//            //code等于1就是请求成功
//            NSDictionary *totalDic = responseObject[@"data"];
//            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
//
//                NSDictionary *returnDic = totalDic[@"returnData"];
//                NSDictionary *comicDic = returnDic[@"comic"];
//                //comicDetailModel,设置页面基本信息
//                [self.comicDetailModel setValuesForKeysWithDictionary:comicDic];
//                //
//                NSArray *collectArray = [[NSUserDefaults standardUserDefaults] objectForKey:kCollectionArray];
//                NSMutableArray *array = [NSMutableArray arrayWithArray:collectArray];
//                for (NSDictionary *dic in array) {
//
//                    NSString *name = dic[@"name"];
//                    [self.nameArray addObject:name];
//                }
//                if ([self.nameArray containsObject:self.comicDetailModel.name]) {
//
//                    [self.collectionButton setImage:[UIImage imageNamed:@"ic_details_top_collection_prressed_21x21_"] forState:(UIControlStateNormal)];
//                }
//                //在detailModel赋值完成后就可以c刷新tableview
//                [self.detailView.detailTableView reloadData];
//                //对tableView的头部视图进行赋值
//                self.detailHeaderView.comicModel = self.comicDetailModel;
//                //ChapterModel,赋值模型信息
//                NSArray *chapter = returnDic[@"chapter_list"];//章回列表
//                for (NSDictionary *dic in chapter) {
//
//                    ChapterModel *model = [[ChapterModel alloc] init];
//                    [model setValuesForKeysWithDictionary:dic];
//                    [self.chapterArray addObject:model];
//                }
//                [MBProgressHUD hideHUDForView:self.view animated:YES];//隐藏
//                //循环赋值完成后刷新章回信息列表
//                [self.detailView.collectionView reloadData];
//                //根据self.comicDetailModel的值进行评论数据请求
//                [self fetchCommentData];
//            }
//        }
//
//    }else if ([operation isEqual:self.commentDataOperation]) {//评论网络请求返回
//
//        int code = [responseObject[@"code"] intValue];
//        if (code == 1) {
//            //code等于1就是请求成功
//            NSDictionary *totalDic = responseObject[@"data"];
//            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
//
//                NSDictionary *returnDic = totalDic[@"returnData"];
//                NSArray *commentList = returnDic[@"commentList"];
//                for (NSDictionary *dic in commentList) {
//
//                    CommentModel *commentModel = [[CommentModel alloc] init];
//                    [commentModel setValuesForKeysWithDictionary:dic];
//                    [self.commentArray addObject:commentModel];
//
//                    NSString *content = commentModel.content_filter;
//                    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
//                    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@"k"];
//                    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@"k"];
//                    content = [content stringByReplacingOccurrencesOfString:@"" withString:@"k"];
//                    CGFloat height = [self getCommentHeightWithString:content];
//                    CGSize size = [content textSizeWithFont:[UIFont fontWithName:Font_Name_PFSCRe size:12] constrainedToSize:CGSizeMake(kSCREEN_Width-20, MAXFLOAT)];
//                    height = ceilf(size.height)+1;
//                    NSNumber *number = [NSNumber numberWithFloat:height];
//                    [self.commentHightArray addObject:number];//根据计算高度
//                }
//                [self.detailView.commentTableView reloadData];
//            }
//        }
//
//
//    }
//
//}

/**
 网络请求失败回调函数

 @param operation 请求操作
 @param error 错误信息
 */
//- (void)failureCallBack:(AFHTTPRequestOperation *)operation error:(NSError *)error {
//    
//    
//    [self showMBProgressHUDWithMessage:@"网络错误请重试" showLabel:YES isShowTime:YES];
//    
//}
#pragma mark -- 懒加载
- (ComicDetailModel *)comicDetailModel {
    
    if (!_comicDetailModel) {
        
        _comicDetailModel = [[ComicDetailModel alloc] init];
    }
    return _comicDetailModel;
}
- (NSMutableArray *)chapterArray {
    
    if (!_chapterArray) {
        
        _chapterArray = [[NSMutableArray alloc] init];
    }
    
    return _chapterArray;
}
- (NSMutableArray *)commentArray {
    
    if (!_commentArray) {
        
        _commentArray = [[NSMutableArray alloc] init];
    }
    return _commentArray;
}
- (NSMutableArray *)commentHightArray {
    
    if (!_commentHightArray) {
        
        _commentHightArray = [[NSMutableArray alloc] init];
    }
    return _commentHightArray;
}
- (NSMutableArray *)nameArray {
    
    if (!_nameArray) {
        
        _nameArray = [[NSMutableArray alloc] init];
    }
    return _nameArray;
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
