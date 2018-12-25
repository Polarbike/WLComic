//
//  ComicDetailViewController.m
//  QuickAnimation
//
//  Created by Weilian on 07/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "ComicDetailViewController.h"
#import "ChapterDetailTableViewCell.h"
#import "LLNetwork.h"
#import "ImagesDataModel.h"
#import "MHNetworking.h"


static NSString *chapter_identifier = @"chapterDetailCell";

@interface ComicDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *tableView;//tableView
@property(nonatomic,assign) BOOL isVisible;//是否是显示状态
@property(nonatomic,strong) UIButton *backButton;//返回按钮

//@property(nonatomic,strong) AFHTTPRequestOperation *chapterDataOperation;//根据章节ID请求章节详细信息
@property(nonatomic,strong) NSMutableArray *imageModelArray;//图片数组

//返回按钮

@end

@implementation ComicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //发起网络请求
    [self fetchComicChapterData];
    //创建子视图
    [self createSubviews];
    //设置invisible默认是显示状态
    self.isVisible = YES;
}


- (void)createSubviews {
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height)) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    //
    UINib *nib = [UINib nibWithNibName:@"ChapterDetailTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:chapter_identifier];
    //_tableView.backgroundColor = [UIColor grayColor];
    
    self.backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.backButton.frame = CGRectMake(20, 32, 40, 40);
    [self.backButton setImage:[UIImage imageNamed:@"ic_nav_back_normal_11x19_"] forState:(UIControlStateNormal)];
    [self.backButton addTarget:self action:@selector(backButtonClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    //数据请求结束之前不能点击返回按钮
    [self.view addSubview:self.backButton];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //更改详情页左侧返回按钮样子
//    UIImage *backImage = [UIImage imageNamed:@"ic_nav_back_normal_11x19_"];
//    backImage = [backImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:backImage style:(UIBarButtonItemStyleDone) target:self action:@selector(backButtonClickAction)];
//    self.navigationItem.leftBarButtonItem = leftBarItem;
    
}
#pragma mark -- 请求章节信息
- (void)fetchComicChapterData {
    
    [self showMBProgressHUDWithMessage:@"正在加载" showLabel:NO isShowTime:NO];
    [self.parameter setObject:self.chapter_id forKey:@"chapter_id"];
//    self.chapterDataOperation = [NCNetwork getComicChapterDetailDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getComicChapterDetailDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *)result;
        int code = [dic[@"code"] intValue];
        if (code == 1) {
            //code等于1就是请求成功
            NSDictionary *totalDic = dic[@"data"];
            int statusCode = [totalDic[@"stateCode"] intValue];
            if (statusCode == 1) {
                
                NSDictionary *returnDic = totalDic[@"returnData"];
                NSArray *imageList = returnDic[@"image_list"];
                for (NSDictionary *dic in imageList) {
                    
                    ImagesDataModel *imageModel = [[ImagesDataModel alloc] init];
                    [imageModel setValuesForKeysWithDictionary:dic];
                    [self.imageModelArray addObject:imageModel];
                }
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络请求错误" showLabel:YES isShowTime:YES];
    }];
}
#pragma mark -- 返回按钮点击方法
- (void)backButtonClickAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark -- 返回按钮的动画
- (void)hiddenBackButtonWithAnimation {
    
    [UIView animateWithDuration:0.25 animations:^{
        //
        self.backButton.frame = CGRectMake(-40, 32, 40, 40);
    } completion:^(BOOL finished) {
        //
        
    }];
    
}
- (void)visibleBackButtonWithAnimation {
    
    [UIView animateWithDuration:0.25 animations:^{
        //
        self.backButton.frame = CGRectMake(20, 32, 40, 40);
    } completion:^(BOOL finished) {
        //
    }];
    
}
#pragma mark -- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.imageModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ImagesDataModel *model = self.imageModelArray[indexPath.row];
    CGFloat height = [model.height floatValue];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChapterDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chapter_identifier forIndexPath:indexPath];
    ImagesDataModel *model = [[ImagesDataModel alloc] init];
    model = self.imageModelArray[indexPath.row];
//    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
//  forHTTPHeaderField:@"Accept"];
    NSURL *imageUrl = [NSURL URLWithString:model.img05];
//    cell.comicImage.yy_imageURL = imageUrl;
    [cell.comicImage yy_setImageWithURL:imageUrl options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
//    [cell.comicImage sd_setImageWithURL:[NSURL URLWithString:model.img05] placeholderImage:[UIImage imageNamed:@"nurto.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //在这里输出下error
//
//    }];

//    [cell.comicImage sd_setImageWithURL:[NSURL URLWithString:model.img05] placeholderImage:[UIImage imageNamed:@"nurto.jpg"]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isVisible) {
        
        [self hiddenBackButtonWithAnimation];
        self.isVisible = NO;
    }else{
        
        [self visibleBackButtonWithAnimation];
        self.isVisible = YES;
    }
    
}
#pragma mark -- scrollview代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.isVisible) {
        
        [self hiddenBackButtonWithAnimation];
        self.isVisible = NO;
    }
    
}
//判断是否是滑动到最上部
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    
    if (!self.isVisible) {
        
        [self visibleBackButtonWithAnimation];
    }
}
#pragma mark -- 章节网络请求结果
//- (void)successCallBack:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject {
//
//
//    int code = [responseObject[@"code"] intValue];
//    if (code == 1) {
//        //code等于1就是请求成功
//        NSDictionary *totalDic = responseObject[@"data"];
//        int statusCode = [totalDic[@"stateCode"] intValue];
//        if (statusCode == 1) {
//
//            NSDictionary *returnDic = totalDic[@"returnData"];
//            NSArray *imageList = returnDic[@"image_list"];
//            for (NSDictionary *dic in imageList) {
//
//                ImagesDataModel *imageModel = [[ImagesDataModel alloc] init];
//                [imageModel setValuesForKeysWithDictionary:dic];
//                [self.imageModelArray addObject:imageModel];
//            }
//            [self.tableView reloadData];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
////            //comicDetailModel,设置页面基本信息
////            [self.comicDetailModel setValuesForKeysWithDictionary:comicDic];
////            //在detailModel赋值完成后就可以c刷新tableview
////            [self.detailView.detailTableView reloadData];
////            //对tableView的头部视图进行赋值
////            self.detailHeaderView.comicModel = self.comicDetailModel;
////            //ChapterModel,赋值模型信息
////            NSArray *chapter = returnDic[@"chapter_list"];//章回列表
////            for (NSDictionary *dic in chapter) {
////
////                ChapterModel *model = [[ChapterModel alloc] init];
////                [model setValuesForKeysWithDictionary:dic];
////                [self.chapterArray addObject:model];
////            }
////            //循环赋值完成后刷新章回信息列表
////            [self.detailView.collectionView reloadData];
////            //根据self.comicDetailModel的值进行评论数据请求
////            [self fetchCommentData];
//              with animation complete ;
//              jiushitianqihao 
//        }
//    }
//
//
//
//
//}
//- (void)failureCallBack:(AFHTTPRequestOperation *)operation error:(NSError *)error {
//
//
//    [self showMBProgressHUDWithMessage:@"网络错误，请重试" showLabel:YES isShowTime:YES];
//
//}
#pragma mark -- 懒加载
- (NSMutableArray *)imageModelArray {
    
    if (!_imageModelArray) {
        
        _imageModelArray = [[NSMutableArray alloc] init];
    }
    return _imageModelArray;
}
#pragma mark -- 点击视图执行方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.isVisible) {
        
        [self hiddenBackButtonWithAnimation];
        self.isVisible = NO;
    }else{
        
        [self visibleBackButtonWithAnimation];
        self.isVisible = YES;
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
