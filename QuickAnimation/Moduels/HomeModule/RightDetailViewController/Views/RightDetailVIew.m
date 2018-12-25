//
//  RightDetailVIew.m
//  QuickAnimation
//
//  Created by Weilian on 06/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "RightDetailVIew.h"
#import "CommentInputView.h"


@implementation RightDetailVIew


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //设置scrollview子视图及基本属性
        _detailTableView = [[UITableView alloc] init];
        _detailTableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_detailTableView];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kSCREEN_Width/2-5, 24);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        
        _commentTableView = [[UITableView alloc] init];
        _commentTableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_commentTableView];
        //
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(kSCREEN_Width*3, frame.size.height);
        self.backgroundColor = [UIColor whiteColor];
        //
        
    }
    
    return self;
}

- (void)layoutSubviews {
    
    self.detailTableView.frame = CGRectMake(0, 0, kSCREEN_Width, self.frame.size.height);
    self.collectionView.frame = CGRectMake(kSCREEN_Width, 0, kSCREEN_Width, self.frame.size.height);
    self.commentTableView.frame = CGRectMake(kSCREEN_Width*2, 0, kSCREEN_Width, self.frame.size.height-44);
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
