//
//  HomeViewController.m
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "ScrollButton.h"
//关注tableview头部视图
#import "LeftTableVIewHeaderView.h"

#import "HotTableViewCell.h"
#import "LeftTableVIewCell.h"

#import "RightDetailViewController.h"
#import "HistoryViewController.h"

#import "LoginViewController.h"
//导入网络工具类
#import "LLNetwork.h"
//导入数据模型
#import "ReturnDataModel.h"//返回数据模型
#import "ComicsModel/ComicsModel.h"
#import "RightCollectionViewCell.h"
//
#import "RightSectionHeaderView.h"
#import "HomeModel.h"
#import "MoreComicViewController.h"//更多comic视图
#import "MHNetworking.h"


static NSString *const left_identifier = @"LeftTableVIewCell";
static NSString *const right_identifier = @"RightCollectionViewCell";
static NSString *const right_sectionHeader_identifier = @"RightSectionHeaderView";


@interface HomeViewController ()<ScrollButtonClickDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,LoginStatusDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) HomeView *homeView;
@property(nonatomic,strong) ScrollButton *scrollButton;
//@property(nonatomic,strong) AFHTTPRequestOperation *getHotOperation;//获取右侧热搜动漫
//@property(nonatomic,strong) AFHTTPRequestOperation *getGuessLikeOperation;//获取右侧热搜动漫
////修改后的首页数据
//@property(nonatomic,strong) AFHTTPRequestOperation *homeDataoperation;//获取右侧热搜动漫


@property(nonatomic,strong) LeftTableVIewHeaderView *leftHeaderView;

@property(nonatomic,copy) NSMutableArray *comicsArray;//漫画数组
@property(nonatomic,strong) NSMutableArray *guessLikeComicArray;//猜你喜欢的漫画数组
@property(nonatomic,strong) NSMutableArray *homepageArray;//首页数据


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setSubviewsInfo];
    //请求猜你喜欢的内容
    //请求网络数据
    [self getHomePageData];
    //设置子视图信息
    [self getGuessLikeDataOperation];
}
#pragma mark -- 网路请求
- (void)fetchComicData {
    
    //确定当前device各种信息 CFBundleShortVersionString
    UIDevice *device = [UIDevice currentDevice];
    NSLog(@"%@",device.model);
    NSDictionary *dic = [NSBundle mainBundle].infoDictionary;
    NSLog(@"%@",dic);
    //    parmeters["argCon"] = argCon
    //    if argName.count > 0 { parmeters["argName"] = argName }
    //    parmeters["argValue"] = argValue
    //    parmeters["page"] = max(1, page)
    [self.parameter setObject:@"0" forKey:@"argCon"];
    [self.parameter setObject:@"topic" forKey:@"argName"];
    [self.parameter setObject:@"8" forKey:@"argValue"];
    [self.parameter setObject:@"1" forKey:@"page"];
//    self.getHotOperation = [NCNetwork getHotDataWithDelegate:self parameters:self.parameter];
    
}
#pragma mark -- 获取到首页信息
- (void)getHomePageData {
    
    /*
     parmeters["sexType"] = sexType
     parmeters["v"] = 3320101
     */
//    [MBProgressHUD showHUDAddedTo:self.homeView.rightCollectionView animated:YES];
    NSNumber *number = [NSNumber numberWithInt:3320101];
    NSNumber *sexType = [NSNumber numberWithInt:1];
    [self.parameter setObject:number forKey:@"v"];
    [self.parameter setObject:sexType forKey:@"sexType"];
//    self.homeDataoperation = [NCNetwork getHomeDetailDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getHomeDetailDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *)result;
        int code = [dic[@"code"] intValue];
        if (code == 1) {
        //code等于1就是请求成功
        NSDictionary *totalDic = dic[@"data"];
        if ([totalDic[@"message"] isEqualToString:@"成功"]) {
        //
        NSDictionary *returnDic = totalDic[@"returnData"];
        NSArray *galleryList = returnDic[@"galleryItems"];
        NSArray *array = returnDic[@"comicLists"];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx >0) {
        //
                NSDictionary *dic = (NSDictionary *)obj;
                NSString *itemTitle = dic[@"itemTitle"];
                if (![itemTitle isEqualToString:@"专题"]) {
        
                        HomeModel *model = [[HomeModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        //添加到数组
                        [self.homepageArray addObject:model];
                    }
                }
            }];
                        [self.homeView.rightCollectionView reloadData];
                        [self.homeView.rightCollectionView.mj_header endRefreshing];
                        [MBProgressHUD hideHUDForView:self.homeView.rightCollectionView animated:YES];
                    }
                }
        
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络请求错误请检查网络" showLabel:YES isShowTime:YES];
    }];
}
#pragma mark -- 获取到猜你喜欢的信息
- (void)getGuessLikeDataOperation {
    //获取到猜你喜欢的页面信息
    [MBProgressHUD showHUDAddedTo:self.homeView.leftTableView animated:YES];
//    self.getGuessLikeOperation = [NCNetwork getGuessLikeDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getGuessLikeDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dic = (NSDictionary *) result;
        int code = [(dic[@"code"]) intValue];
        if (code == 1) {
        
            NSDictionary *totalDic = dic[@"data"];
            NSDictionary *returnDic = totalDic[@"returnData"];
            NSArray *array = returnDic[@"comics"];
            for (NSDictionary *dic in array) {
        
                ComicsModel *model = [[ComicsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.guessLikeComicArray addObject:model];
            }
            [MBProgressHUD hideHUDForView:self.homeView.leftTableView animated:YES];
            [self.homeView.leftTableView reloadData];
        }
        
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络请求错误请检查网络" showLabel:YES isShowTime:YES];
    }];
}
- (void)setSubviewsInfo {
    
    //设置导航栏
    self.scrollButton = [[ScrollButton alloc] initWithFrame:(CGRectMake(0, 0, 100, 34))];
    self.scrollButton.delegate = self;
    //为了取消右item的系统渲染
    UIImage *rightImage = [[UIImage imageNamed:@"history_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightImage style:(UIBarButtonItemStyleDone) target:self action:@selector(rightButtonClickAction)];
    //取消浏览历史按钮,所以注销
//    self.navigationItem.rightBarButtonItem = rightButton;
    //j将baritem 添加到bar上
    self.navigationItem.titleView = self.scrollButton;
    [self.navigationController.navigationBar setBarTintColor:kRGB(251, 227, 76, 1)];
    self.navigationController.navigationBar.translucent = NO;
    //设置homeView
    self.homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height-64-49)];
    self.homeView.contentSize = CGSizeMake(kSCREEN_Width*2, kSCREEN_Height-64-49);

    [self.view addSubview:self.homeView];
    
    [MBProgressHUD showHUDAddedTo:self.homeView.rightCollectionView animated:YES];

    //设置scrollview的代理  self.tabBarController.tabBar.bounds.size.height
    self.homeView.delegate = self;
    //设置home view包含的tableview的代理
    self.homeView.rightCollectionView.delegate = self;
    self.homeView.leftTableView.delegate = self;
    self.homeView.rightCollectionView.dataSource = self;
    self.homeView.leftTableView.dataSource = self;
    //注册tableview的cell
    [self.homeView.rightCollectionView registerNib:[UINib nibWithNibName:@"RightCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:right_identifier];//identifier与xib 一致
    //注册头部视图
    [self.homeView.rightCollectionView registerClass:[RightSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:right_sectionHeader_identifier];
    //
    [self.homeView.leftTableView registerNib:[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil] forCellReuseIdentifier:left_identifier];
#pragma mark -- 给左侧关注tableview 增加头部视图，判断是否登录
    self.leftHeaderView = [[LeftTableVIewHeaderView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, 100))];
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    if ([user isEqualToString:@""]) {
        
        [self.leftHeaderView setViewBaseInfoWithBool:NO];
    }else{
        
        [self.leftHeaderView setViewBaseInfoWithBool:YES];
    }
    self.homeView.leftTableView.tableHeaderView = self.leftHeaderView;
    [self.leftHeaderView.loginButton addTarget:self action:@selector(leftLoginButtonClickAction) forControlEvents:(UIControlEventTouchUpInside)];
#pragma mark -- 给右侧热门tableview 增加下拉刷新
    self.homeView.rightCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //正在刷新的时候执行的方法，这个时候应该是去重新请求数据,在请求新数据结束后的方法里结束refresh 动画，并刷新页面
        [self getHomePageData];
    } ];

}
#pragma mark -- 首页历史记录按钮点击事件
//首页右侧历史记录按钮点击事件
- (void)rightButtonClickAction {
    
    //导航条上右侧按钮点击事件,去往历史记录页面
    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
    historyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:historyVC animated:YES];
}
#pragma mark -- 首页左侧视图头部视图登录按钮点击方法
- (void)leftLoginButtonClickAction {
    //present出登录页面
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.delegate = self;
    [self.navigationController presentViewController:loginVC animated:YES completion:^{
        //预留接口
        
    }];
    
}
#pragma mark -- loginView登录状态代理方法返回
- (void)getLoginViewLogStatus:(BOOL)status name:(NSString *)name{
    
    
    [self.leftHeaderView setViewBaseInfoWithBool:status];
    
}
#pragma mark -- tableview的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if ([tableView isEqual:self.homeView.rightTableView]) {
//
//
//        return self.comicsArray.count;
//    }else{
    
        return self.guessLikeComicArray.count;
//    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        return kSCREEN_Width/0.76;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([tableView isEqual:self.homeView.rightTableView]) {
//
//        HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightTableCell"];
//        cell.praiseBut.tag = 1000+indexPath.row;
//        [cell.praiseBut addTarget:self action:@selector(cellPraiseClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        ComicsModel *model = self.comicsArray[indexPath.row];
//        cell.name.text = model.name;
//        cell.author.text = [NSString stringWithFormat:@"作者：%@",model.author];
//        cell.pageContent.text = model.short_description;
//        //imageUrl
//        NSURL *imageUrl = [NSURL URLWithString:model.cover];
//        [cell.cellImage sd_setImageWithURL:imageUrl];
//        return cell;
//    }else{
    
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:left_identifier];
        ComicsModel *model = self.guessLikeComicArray[indexPath.row];
        cell.namelabel.text = model.name;
        cell.descriptionLabel.text = model.short_description;
        //imageUrl
        NSURL *imageUrl = [NSURL URLWithString:model.cover];
        [cell.cellImage sd_setImageWithURL:imageUrl];
        return cell;
//    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //进入漫画详情页
    RightDetailViewController *rightDetailVC = [[RightDetailViewController alloc] init];
//    if ([tableView isEqual:self.homeView.rightTableView]) {
//
//        //找到数据
//        ComicsModel *model = self.comicsArray[indexPath.row];
//        rightDetailVC.comicId = [NSNumber numberWithLong:model.comicId];
//        rightDetailVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:rightDetailVC animated:YES];
//
//    }else if([tableView isEqual:self.homeView.leftTableView]) {
    
        //找到数据
        ComicsModel *model = self.guessLikeComicArray[indexPath.row];
        int comic_id = [model.comic_id intValue];
        rightDetailVC.comicId = [NSNumber numberWithInt:comic_id];
        rightDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rightDetailVC animated:YES];
//    }

}
#pragma mark -- collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.homepageArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    HomeModel *model = [[HomeModel alloc] init];
    model = self.homepageArray[section];
    NSArray *array = model.comicsData;
    
    return array.count;
}
//返回itemsize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    float  scanf = 0.625;
//    CGFloat makeWidth = (kSCREEN_Width-6)/2;
//    CGSize itemSize = CGSizeMake(makeWidth,makeWidth*scanf +60);
    
    HomeModel *model = self.homepageArray[indexPath.section];
    if (model.comicType == 11) {
        
        CGFloat width = floor((kSCREEN_Width - 6.0) / 2.0);
        return CGSizeMake(width, 80);
    }else{
        
        if (model.comicType == 5) {
            
            CGFloat width = floor((kSCREEN_Width - 5.0) / 2.0);
            return CGSizeMake(width, 120);
            
        }
        else if ([model.itemTitle isEqualToString:@"人气推荐作品"]){

            NSInteger count = model.comicsData.count;
            NSInteger warp = count%2 + 2;//行数
            CGFloat width = floor((kSCREEN_Width - 6 - (warp - 1) * 5.0)  / (warp));
            return CGSizeMake(width, (width/0.76)+50);

        }
        else{
            
            NSInteger count = model.comicsData.count;
            NSInteger warp = count%2 + 2;//行数
            CGFloat width = floor((kSCREEN_Width - 6 - (warp - 1) * 5.0)  / (warp));
            return CGSizeMake(width, warp*80+40);
        }
        
    }
//    return itemSize;
//    let comicList = comicLists[indexPath.section]
//    if comicList.comicType == .billboard {
//        let width = floor((screenWidth - 15.0) / 4.0)
//        return CGSize(width: width, height: 80)
//    }else {
//        if comicList.comicType == .thematic {
//            let width = floor((screenWidth - 5.0) / 2.0)
//            return CGSize(width: width, height: 120)
//        } else {
//            let count = comicList.comics?.takeMax(4).count ?? 0
//            let warp = count % 2 + 2
//            let width = floor((screenWidth - CGFloat(warp - 1) * 5.0) / CGFloat(warp))
//            return CGSize(width: width, height: CGFloat(warp * 80))
//        }
//    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:right_identifier forIndexPath:indexPath];
    HomeModel *homeModel = [[HomeModel alloc] init];
    homeModel = self.homepageArray[indexPath.section];
    NSArray *array = homeModel.comicsData;
    ComicsModel *model = [[ComicsModel alloc] init];
    model = array[indexPath.row];
    //
    NSURL *imageUrl = [NSURL URLWithString:model.cover];
    [cell.cellImage sd_setImageWithURL:imageUrl];
    cell.nameLabel.text = model.name;
    cell.typeLabel.text = model.subTitle;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *sectionHeaderView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        //将banner加在header view上
        RightSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:right_sectionHeader_identifier forIndexPath:indexPath];
        HomeModel *model = [[HomeModel alloc] init];
        model = self.homepageArray[indexPath.section];
        //
        NSURL *url = [NSURL URLWithString:model.titleIconUrl];
        [headerView.cellIcon sd_setImageWithURL:url];
        headerView.cellTittle.text = model.itemTitle;
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.moreButton.tag = indexPath.section+1000;
        [headerView.moreButton addTarget:self action:@selector(headerViewMoreButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        sectionHeaderView = headerView;
    }
    
    return sectionHeaderView;
}
//collectionViewItem被点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RightDetailViewController *rightDetailVC = [[RightDetailViewController alloc] init];
    //找到数据
    HomeModel *homeModel = [[HomeModel alloc] init];
    homeModel = self.homepageArray[indexPath.section];
    NSArray *array = homeModel.comicsData;
    ComicsModel *comicModel = [[ComicsModel alloc] init];
    comicModel = array[indexPath.row];
    rightDetailVC.comicId = [NSNumber numberWithLong:comicModel.comicId];
    rightDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rightDetailVC animated:YES];
    
}
#pragma mark -- scrollButton 代理方法
- (void)leftButtonClicked {
    
    [self.homeView  setContentOffset:CGPointMake(0, 0) animated:YES];
    
}
- (void)rightButtonClicked {
    
    [self.homeView setContentOffset:CGPointMake(kSCREEN_Width, 0) animated:YES];
    
}
#pragma mark -- cell上点赞按钮的点击方法
- (void)cellPraiseClickAction:(UIButton *)button {
    
//    NSInteger index = button.tag-1000;
//    //根据tag值可以找到cell的index，根绝index去确定对数组中的哪组数据赞，去执行动画并处理数据
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    HotTableViewCell *hotCell = [self.homeView.rightCollectionView cellForRowAtIndexPath:indexPath];
//    //将按钮选择状态取反
//    button.selected = !button.selected;
//    if (button.isSelected) {
//        //
//        [hotCell buttonSelectedAnimation];
//    }else{
//        //
//        [hotCell buttonCancelSelectedAnimation];
//    }
}
#pragma mark -- 更多按钮点击事件
- (void)headerViewMoreButtonClick:(UIButton *)button {
    
    NSInteger tag = button.tag-1000;
    HomeModel *model = [[HomeModel alloc] init];
    model = self.homepageArray[tag];
    //初始化更多按钮视图
    MoreComicViewController *moreComicVC = [[MoreComicViewController alloc] init];
    moreComicVC.argValue = [NSNumber numberWithLong:model.argValue];
    moreComicVC.argName = model.argName;
    moreComicVC.acrCon = [NSNumber numberWithLong:model.argType];
    moreComicVC.page = [NSNumber numberWithInt:1];
    moreComicVC.hidesBottomBarWhenPushed = YES;
    moreComicVC.title = @"更多";
    [self.navigationController pushViewController:moreComicVC animated:YES];
}
#pragma mark -- scrollView的代理方法
//开始执行refresh方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //MJRefresh 设置之后不用手动去beginningRefresh MJRefresh会自动监听scrollOffSet 的偏移量
    //所以这个方法预留
    
    
}
//已经完成减速的代理方法，在将要减速的时候判断offset，是向左滑动还是向右滑动的
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.homeView]) {//防止tableview发生偏移量影响
        
        CGFloat scroll_x = scrollView.contentOffset.x;
        CGFloat scroll_y = scrollView.contentOffset.y;
        NSLog(@"偏移量%f,y偏移量%f",scroll_x,scroll_y);
        if (scroll_x == kSCREEN_Width && scroll_y == 0) {//向右侧滑动
            //划过了整个屏幕时
            [self.scrollButton buttonScrollLeftToRight];
        }else if (scroll_x == 0 && scroll_y == 0){
            //滑到最左边的额时候
            [self.scrollButton buttonScrollRightToLeft];
        }
    }
}

#pragma mark -- 网络请求代理方法
//- (void)successCallBack:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject {
//    //请求成功会掉函数
////    long code = (long)responseObject[@"code"];
//    if ([operation isEqual:self.getHotOperation]) {
//
//        NSString *msg = responseObject[@"msg"];
//        if ([msg isEqualToString:@"执行成功"]) {
//            NSDictionary *totalDic = responseObject[@"data"];
//            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
//                NSDictionary *returnDic = totalDic[@"returnData"];
//                //返回数据字典
//                ReturnDataModel *returnModel = [[ReturnDataModel alloc] init];
//                [returnModel setValuesForKeysWithDictionary:returnDic];
//
//                self.comicsArray = [NSMutableArray arrayWithArray:returnModel.comics];
//                //取消菊花转
//                [MBProgressHUD hideHUDForView:self.homeView.rightCollectionView animated:YES];
//                //
//                [self.homeView.rightCollectionView reloadData];
//                [self.homeView.rightCollectionView.mj_header endRefreshing];
//            }
//        }
//    }else if([operation isEqual:self.getGuessLikeOperation]){
//
////        NSLog(@"%@",responseObject);
//        int code = [(responseObject[@"code"]) intValue];
//        if (code == 1) {
//
//            NSDictionary *totalDic = responseObject[@"data"];
//            NSDictionary *returnDic = totalDic[@"returnData"];
//            NSArray *array = returnDic[@"comics"];
//            for (NSDictionary *dic in array) {
//
//                ComicsModel *model = [[ComicsModel alloc] init];
//                [model setValuesForKeysWithDictionary:dic];
//                [self.guessLikeComicArray addObject:model];
//            }
//            [MBProgressHUD hideHUDForView:self.homeView.leftTableView animated:YES];
//            [self.homeView.leftTableView reloadData];
//        }
//
//    }else if ([operation isEqual:self.homeDataoperation]){
//
//        int code = [responseObject[@"code"] intValue];
//        if (code == 1) {
//            //code等于1就是请求成功
//            NSDictionary *totalDic = responseObject[@"data"];
//            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
//
//                NSDictionary *returnDic = totalDic[@"returnData"];
////                NSArray *galleryList = returnDic[@"galleryItems"];
//                NSArray *array = returnDic[@"comicLists"];
//                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    //
//                    if (idx >0) {
//
//                        NSDictionary *dic = (NSDictionary *)obj;
//                        NSString *itemTitle = dic[@"itemTitle"];
//                        if (![itemTitle isEqualToString:@"专题"]) {
//
//                            HomeModel *model = [[HomeModel alloc] init];
//                            [model setValuesForKeysWithDictionary:dic];
//                            //添加到数组
//                            [self.homepageArray addObject:model];
//                        }
//                    }
//                }];
//                [self.homeView.rightCollectionView reloadData];
//                [self.homeView.rightCollectionView.mj_header endRefreshing];
//                [MBProgressHUD hideHUDForView:self.homeView.rightCollectionView animated:YES];
//            }
//        }
//
//    }
//
//}
//- (void)failureCallBack:(AFHTTPRequestOperation *)operation error:(NSError *)error {
//
//    if (error) {
//
//        [self showMBProgressHUDWithMessage:@"网络错误请重试" showLabel:YES isShowTime:YES];
//        [MBProgressHUD hideHUDForView:self.homeView.leftTableView animated:YES];
//    }
//
//}
#pragma mark -- 懒加载
//- (NSMutableDictionary *)parameter {
//    
//    if (!_parameter) {
//        
//        _parameter = [[NSMutableDictionary alloc] init];
//        //获取当前时间戳
//        double date = [[NSDate date] timeIntervalSince1970];
//        NSNumber *number = [NSNumber numberWithDouble:date];
//        [_parameter setObject:number forKey:@"time"];
//        //设备uuid
//        NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
//        [_parameter setObject:uuid forKey:@"device_id"];
//        //apikey
//        [_parameter setObject:kAPIKey forKey:@"key"];
//        //设备model
//        NSString *model = [UIDevice currentDevice].model;
//        [_parameter setObject:model forKey:@"model"];
//        //target
//        [_parameter setObject:@"U17_4.0" forKey:@"target"];
//        //version
//        NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//        [_parameter setObject:version forKey:@"version"];
//        /*
//         "time": Int32(Date().timeIntervalSince1970),
//         "device_id": UIDevice.current.identifierForVendor!.uuidString,
//         "key": UApiKey.key,
//         "model": UIDevice.current.modelName,
//         "target": "U17_4.0",
//         "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
//         */
//    }
//    return _parameter;
//}
- (NSMutableArray *)homepageArray {
    
    if (!_homepageArray) {
        
        _homepageArray = [[NSMutableArray alloc] init];
    }
    return _homepageArray;
}
- (NSMutableArray *)comicsArray {
    
    if (!_comicsArray) {
        
        _comicsArray = [[NSMutableArray alloc] init];
    }
    return _comicsArray;
}
- (NSMutableArray *)guessLikeComicArray {
    
    if (!_guessLikeComicArray) {
        
        _guessLikeComicArray = [[NSMutableArray alloc] init];
    }
    return _guessLikeComicArray;
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
