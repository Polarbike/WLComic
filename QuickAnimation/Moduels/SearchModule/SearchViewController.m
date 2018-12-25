//
//  SearchViewController.m
//  QuickAnimation
//
//  Created by Weilian on 21/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchSectionHeaderView.h"
//
#import "SearchCollectionViewCell.h"
#import "MHNetworking.h"
//
#import "HotSearchModel.h"
#import "NSString+Height.h"
//跳转到漫画详情
#import "RightDetailViewController.h"
//导入comicModel
#import "ComicsModel.h"
//搜索动漫结果
#import "ClassDTableViewCell.h"




static NSString *const searchCellIdentifier = @"SearchCellIdentifier";
static NSString *const search_identifier = @"searchCell";
static NSString *const search_resultIdentifier = @"searchResultIdentifier";
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate> {
 
    
}

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UISearchBar *searchBar;//搜索框
@property(nonatomic,strong) NSMutableArray *searchHistoryArray;//搜索历史记录
@property(nonatomic,strong) NSMutableArray *hotSearchArray;//大家都在搜
@property(nonatomic,strong) NSMutableArray *searchResultArray;//关系搜索结果数组
@property(nonatomic,strong) NSMutableArray *comicResultArray;//根据关系搜索结果搜索动漫数组

@property(nonatomic,strong) SearchSectionHeaderView *firstHeaderView;

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubviews];
    //初始化时让搜索状态为搜索前
    self.searchStatus = SearchBeforeStatus;
    //请求大家热搜内容
    [self fetchHotSearchData];
//    self.extendedLayoutIncludesOpaqueBars = NO;
    //不添加这个方法会从最上面计算布局，不会从导航栏下计算布局
//    self.navigationController.navigationBar.translucent = NO;
    [self addObserver:self forKeyPath:@"searchHistoryArray" options:(NSKeyValueObservingOptionOld||NSKeyValueChangeNewKey) context:nil];
}



- (void)createSubviews {

//    SearchBar *bar = [[SearchBar alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, 64))];
//    bar.backgroundColor = [UIColor redColor];
//    self.navigationController.navigationItem.titleView = bar;
//    [self.navigationController.navigationItem.titleView sizeToFit];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, kSCREEN_Width, kSCREEN_Height-self.tabBarController.tabBar.frame.size.height-64)) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    ///
    //隐藏导航栏上的返回按钮
    [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationController.navigationBar setBarTintColor:kRGB(251, 227, 76, 1)];
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = false;
    //用来放searchBar的View
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    //创建searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];
    //默认提示文字
    searchBar.placeholder = @"搜索内容";
    //背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    //代理
    searchBar.delegate = self;
    //显示右侧取消按钮
    searchBar.showsCancelButton = YES;
    //光标颜色
    searchBar.tintColor = [UIColor darkGrayColor];
    //拿到searchBar的输入框
    UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
    //字体大小
    searchTextField.font = [UIFont systemFontOfSize:15];
    //输入框背景颜色
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    //拿到取消按钮
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    //设置按钮上的文字
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:15];
    //设置按钮上文字的颜色
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
}
#pragma mark -- 获取大家热搜数据请求
- (void)fetchHotSearchData {
    /*
     parmeters["comicid"] = comicid
     parmeters["v"] = 3320101
     */
//    NSNumber *number = [NSNumber numberWithInt:3320101];
//    [self.parameter setObject:number forKey:@"v"];
    //    self.comicDetailOperation = [NCNetwork getComicDetailDataWithDelegate:self parameters:self.parameter];
    [MHNetworking getHotSearchDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //["inputText"]
        NSDictionary *dic = (NSDictionary *)result;
        int code = [dic[@"code"] intValue];
        if (code == 1) {
            //code等于1就是请求成功
            NSDictionary *totalDic = dic[@"data"];
            if ([totalDic[@"message"] isEqualToString:@"成功"]) {
                
                NSDictionary *returnDic = totalDic[@"returnData"];
                NSArray *array = returnDic[@"hotItems"];
                for (NSDictionary *dic in array) {
                    
                    HotSearchModel *hotModel = [[HotSearchModel alloc] init];
                    [hotModel setValuesForKeysWithDictionary:dic];
                    [self.hotSearchArray addObject:hotModel];
                }
                [self.collectionView reloadData];
            }
        }
        
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"网络连接错误" showLabel:YES isShowTime:YES];
    }];
//    [self showMBProgressHUDWithMessage:@"加载中" showLabel:YES isShowTime:NO];
    //  self.comicRealTimeDataOperation = [NCNetwork getComicRealTimeDataWithDelegate:self parameters:self.parameter];
}
#pragma mark -- 搜索关系结果网络数据请求
- (void)fetchRelativeSearchDataWithInputString:(NSString *)string {
    
    [self.parameter setObject:string forKey:@"inputText"];
    [MHNetworking getSearchDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dataDic = (NSDictionary *)result[@"data"];
        NSNumber *stateCode = (NSNumber *)dataDic[@"stateCode"];
        if (stateCode&&[NSNumber numberWithLong:1] == stateCode) {
            
            [self.searchResultArray removeAllObjects];
            NSArray *array = dataDic[@"returnData"];
            for (NSDictionary *dic in array) {
                
                HotSearchModel *model = [[HotSearchModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.searchResultArray addObject:model];
            }
            self.searchStatus = SearchingStatus;
            [self.tableView reloadData];
        }
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"请求错误请重试" showLabel:YES isShowTime:YES];
    }];
}
#pragma mark -- 根据关系搜索获取结果网络数据请求
- (void)fetchResultSearchDataWithComicQ:(NSString *)string {
    //parmeters["argCon"] = argCon
    //parmeters["q"] = q
    NSNumber *argCon = [NSNumber numberWithInt:0];
    [self.parameter setObject:argCon forKey:@"argCon"];
    [self.parameter setObject:string forKey:@"q"];
    //
    WeakSelf(self);
    //
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [MHNetworking getResultSearchDataWithParameters:self.parameter success:^(id  _Nonnull result) {
        //
        NSDictionary *dataDic = (NSDictionary *)result[@"data"];
        NSNumber *stateCode = (NSNumber *)dataDic[@"stateCode"];
        if (stateCode&&[NSNumber numberWithLong:1] == stateCode) {
            
            [weakSelf.searchResultArray removeAllObjects];
            //如果大于零清除，避免重复添加，searchResultArray不判断因为变化大不用o判断
            if (weakSelf.comicResultArray.count > 0) {
                
                [weakSelf.comicResultArray removeAllObjects];
            }
            NSDictionary *returnDic = dataDic[@"returnData"];
            NSArray *array = returnDic[@"comics"];
            for (NSDictionary *dic in array) {
                
                ComicsModel *comicModel = [[ComicsModel alloc] init];
                [comicModel setValuesForKeysWithDictionary:dic];
                [weakSelf.comicResultArray addObject:comicModel];
            }
            weakSelf.searchStatus = SearchResultStatus;
            [weakSelf.tableView reloadData];
            //隐藏
            [hud hideAnimated:YES];
        }
    } failure:^(id  _Nonnull error) {
        //
        [self showMBProgressHUDWithMessage:@"请求错误请重试" showLabel:YES isShowTime:YES];
    }];
}
#pragma mark -- 观察者模式
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (self.searchStatus == SearchBeforeStatus) {
        //在被观察属性发生变化的时候调用
        if ([keyPath isEqualToString:@"searchHistoryArray"]) {
            
            if ([self mutableArrayValueForKeyPath:keyPath].count>0) {
                
                self.firstHeaderView.headerButton.hidden = NO;
            }else{
                
                self.firstHeaderView.headerButton.hidden = YES;
            }
        }
    }
//    [self.tableView reloadData];
}
#pragma mark -- searchBar 代理方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
        
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder]; //searchBar失去焦点
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES; //把enabled设置为yes
    NSLog(@"SearchButton");
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
    if ([searchTextField isFirstResponder]) {
        
        [searchTextField resignFirstResponder];
        self.searchBar.text = @"";
    }
    //改变搜索状态,重新加载
    if (self.searchStatus != SearchBeforeStatus) {
        
        self.searchBar.text = @"";
        self.searchStatus = SearchBeforeStatus;
        [self.tableView reloadData];
    }

}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *inputStr = searchText;
    //
    self.searchStatus = SearchingStatus;
    [self fetchRelativeSearchDataWithInputString:inputStr];
    
}
#pragma mark -- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
   if (self.searchStatus == SearchBeforeStatus) {
        
        return 2;
    }else{
        
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchStatus == SearchingStatus) {
        
        return self.searchResultArray.count;
        
    }else if(self.searchStatus == SearchBeforeStatus){
        
        if (section == 0) {
            
            return self.searchHistoryArray.count;
        }else {
            
            return 1;
        }
    }else{
        
        return self.comicResultArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchStatus == SearchResultStatus) {
        
        return 300;
    }else{
        
        if (indexPath.section == 1) {
            
            return 200;
        }else{
            
            return 28;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchStatus == SearchResultStatus) {
        
        UINib *nib = [UINib nibWithNibName:@"ClassDTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:search_resultIdentifier];
        ClassDTableViewCell *classDTCell = [tableView dequeueReusableCellWithIdentifier:search_resultIdentifier];

        ComicsModel *model = self.comicResultArray[indexPath.row];
        NSURL *url = [NSURL URLWithString:model.cover];
        [classDTCell.cellImage sd_setImageWithURL:url];
        classDTCell.nameLabel.text = model.name;
        classDTCell.autherLabel.text = model.author;
        classDTCell.typeLabel.text = model.short_description;
        classDTCell.descriptionLabel.text = model.a_description;
        return classDTCell;
    }else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:search_identifier];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:search_identifier];
            cell.textLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
            cell.textLabel.textColor = kRGB(40, 40, 40, 1);
        }
        if (self.searchStatus == SearchingStatus) {
            
            [self.collectionView removeFromSuperview];
            HotSearchModel *model = [[HotSearchModel alloc] init];
            model = self.searchResultArray[indexPath.row];
            cell.textLabel.text = model.name;
            
        }else if(self.searchStatus == SearchBeforeStatus){
            
            if (indexPath.section == 0 && self.searchHistoryArray.count > 0) {
                
                HotSearchModel *model = self.searchHistoryArray[indexPath.row];
                cell.textLabel.text = model.name;
            }
            if (indexPath.section == 1) {
                
                [cell.contentView addSubview:self.collectionView];
                [self.collectionView reloadData];
            }
            
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.searchStatus == SearchBeforeStatus) {
        
        return 64;
    }else{
        
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SearchSectionHeaderView *headerView = [[SearchSectionHeaderView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, 44))];
    [headerView.headerButton addTarget:self action:@selector(headerButtonClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    switch (section) {
        case 0:
            //
            if (self.searchHistoryArray.count > 0 && self.searchStatus == SearchBeforeStatus) {
                
                headerView.headerButton.hidden = NO;
            }
            headerView.content.text = @"搜索历史记录";
            self.firstHeaderView = headerView;
            break;
        case 1:
            //
            headerView.content.text = @"热搜内容";
            headerView.headerButton.hidden = YES;
            break;
        default:
            break;
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchStatus == SearchingStatus) {
        
        HotSearchModel *model = [[HotSearchModel alloc] init];
        model = self.searchResultArray[indexPath.row];
        [[self mutableArrayValueForKey:@"searchHistoryArray"] addObject:model];
        //给search bar赋值
        self.searchBar.text = model.name;
        [self.searchBar resignFirstResponder];
        UIButton *cancelBtn = [self.searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
        cancelBtn.enabled = YES; //把enabled设置为yes
        //改变搜索状态刷新tableview
        [self fetchResultSearchDataWithComicQ:model.name];
    }else if (self.searchStatus == SearchResultStatus){
        
        ComicsModel *model = [[ComicsModel alloc] init];
        model = self.comicResultArray[indexPath.row];
        RightDetailViewController *rightDetailVC = [[RightDetailViewController alloc] init];
        rightDetailVC.comicId = [NSNumber numberWithLong:model.comicId];
        [self.navigationController pushViewController:rightDetailVC animated:YES];
        
    }else{
        
        HotSearchModel *model = [[HotSearchModel alloc] init];
        model = self.searchHistoryArray[indexPath.row];
        self.searchBar.text = model.name;
        [self.searchBar resignFirstResponder];
        UIButton *cancelBtn = [self.searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
        cancelBtn.enabled = YES; //把enabled设置为yes
        //改变搜索状态刷新tableview
        [self fetchResultSearchDataWithComicQ:model.name];
    }
}
#pragma mark -- UICollectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.hotSearchArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:searchCellIdentifier forIndexPath:indexPath];
    HotSearchModel *model = [[HotSearchModel alloc] init];
    model = self.hotSearchArray[indexPath.row];
    cell.itemLabel.text = model.name;
    return cell;
}
//返回itemsize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    CGFloat itemWidth = 90.f;
    HotSearchModel *model = [[HotSearchModel alloc] init];
    model = self.hotSearchArray[indexPath.row];
    NSString *name = model.name;
    //
    UIFont *font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
    CGSize defaultSize = CGSizeMake(MAXFLOAT, itemHeight);
    CGSize size = [name textSizeWithFont:font constrainedToSize:defaultSize];
    return CGSizeMake(size.width+6, itemHeight+6);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HotSearchModel *model = [[HotSearchModel alloc] init];
    model = self.hotSearchArray[indexPath.row];
    RightDetailViewController *rightDetailVC = [[RightDetailViewController alloc] init];
    rightDetailVC.comicId = (NSNumber *)model.comic_id;
    [self.navigationController pushViewController:rightDetailVC animated:YES];
}

#pragma mark -- 头部视图按钮点击方法
- (void)headerButtonClickAction:(UIButton *)button {
    
    [[self mutableArrayValueForKey:@"searchHistoryArray"] removeAllObjects];
    [self.tableView reloadData];
}
#pragma mark -- 懒加载
- (NSMutableArray *)searchHistoryArray {
    
    if (!_searchHistoryArray) {
        
        _searchHistoryArray = [[NSMutableArray alloc] init];
    }
    
    return _searchHistoryArray;
}

- (NSMutableArray *)hotSearchArray {
    
    if (!_hotSearchArray) {
        
        _hotSearchArray = [[NSMutableArray alloc] init];
    }
    
    return _hotSearchArray;
}

- (NSMutableArray *)searchResultArray {
    
    if (!_searchResultArray) {
        
        _searchResultArray = [[NSMutableArray alloc] init];
    }
    
    return _searchResultArray;
}

- (NSMutableArray *)comicResultArray {
    
    if (!_comicResultArray) {
        
        _comicResultArray = [[NSMutableArray alloc] init];
    }
    
    return _comicResultArray;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 14;//垂直间距
        flowLayout.minimumInteritemSpacing = 12;
        _collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, 300)) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //collectionVeiw selected
        [_collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:searchCellIdentifier];
    }
    return _collectionView;
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"searchHistoryArray"];
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
