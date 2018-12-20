//
//  CollectionViewController.m
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//  我的收藏

#import "CollectionViewController.h"
#import "ClassDTableViewCell.h"
#import "RightDetailViewController.h"

static NSString *const collect_identifier = @"ClassDTableViewCell";
@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *collectionArray;//收藏数组

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建子视图
    self.title = @"我的收藏";
    //不添加这个方法会从最上面计算布局，不会从导航栏下计算布局
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUser];
    NSString *user = [[NSUserDefaults standardUserDefaults] valueForKey:kUser];
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:kCollectionArray];
    if (array.count>0&&![user isEqualToString:@""]) {
        
        self.collectionArray = [NSMutableArray arrayWithArray:array];
        [self createSuviews];
        
    }else{
        
        [self createNullView];
        
    }
    
}

- (void)createSuviews {
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height-64)) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"ClassDTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:collect_identifier];
    //
    [self setNavigationBarLeftButton];
}
- (void)createNullView {
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 44, kSCREEN_Width-20, 20);
    label.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
    label.textColor = kRGB(60, 60, 60, 0.6);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"还没有收藏";
    [self.view addSubview:label];
    //设置返回按钮
    [self setNavigationBarLeftButton];
    
}
#pragma mark -- 设置导航左侧返回按钮
- (void)setNavigationBarLeftButton {
    
    //设置导航上的返回按钮
    UIImage *leftImage = [[UIImage imageNamed:@"ic_nav_second_back_normal_17x17_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftImage style:(UIBarButtonItemStyleDone) target:self action:@selector(backButtonClickAction)];
    self.navigationItem.leftBarButtonItem = leftButton;
}
#pragma mark -- 自定义返回按钮点击方法
- (void)backButtonClickAction {
    //返回视图
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark -- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.collectionArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 260;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collect_identifier];
    NSDictionary *dic = self.collectionArray[indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:dic[@"cover"]];
    [cell.cellImage sd_setImageWithURL:imageUrl];
    cell.nameLabel.text = dic[@"name"];
    cell.autherLabel.text = dic[@"author"][@"name"];
    cell.descriptionLabel.text = dic[@"shortDescription"];
    cell.typeLabel.text = @"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RightDetailViewController *rightDetailVC = [[RightDetailViewController alloc] init];
    NSDictionary *dic = self.collectionArray[indexPath.row];
    int intId = [dic[@"comicId"] intValue];
    rightDetailVC.comicId = [NSNumber numberWithInt:intId];
    [self.navigationController pushViewController:rightDetailVC animated:YES];
    
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
