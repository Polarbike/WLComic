//
//  HomeView.m
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _leftTableView = [[UITableView alloc] init];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.showsVerticalScrollIndicator = NO;
        [self addSubview:_leftTableView];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        /*
         lt.minimumInteritemSpacing = 5
         lt.minimumLineSpacing = 10
         let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
         cw.backgroundColor = UIColor.background
         cw.delegate = self
         cw.dataSource = self
         cw.alwaysBounceVertical = true
         cw.contentInset = UIEdgeInsetsMake(screenWidth * 0.467, 0, 0, 0)
         cw.scrollIndicatorInsets = cw.contentInset
         */
        flowLayout.minimumLineSpacing = 2;
        flowLayout.minimumInteritemSpacing = 2;
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        flowLayout.headerReferenceSize = CGSizeMake(kSCREEN_Width, 44);
        _rightCollectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, kSCREEN_Width, kSCREEN_Height-64-49)) collectionViewLayout:flowLayout];
        [self addSubview:_rightCollectionView];
        //设置scrollView的一些属性
        _rightCollectionView.showsVerticalScrollIndicator = NO;
        self.contentSize = CGSizeMake(kSCREEN_Width*2, kSCREEN_Height-64-49);
        self.pagingEnabled = YES;
        [self setContentOffset:CGPointMake(kSCREEN_Width, 0)];
    }
    return self;
}
//布局
- (void)layoutSubviews {
    
    _leftTableView.frame = CGRectMake(0, 0, kSCREEN_Width, self.frame.size.height);
    _rightCollectionView.frame = CGRectMake(kSCREEN_Width, 0, kSCREEN_Width, self.frame.size.height);
    //
    self.leftTableView.backgroundColor = kRGB(243, 243, 243, 1);
    self.rightCollectionView.backgroundColor = [UIColor whiteColor];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
