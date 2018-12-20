//
//  HotTableViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 29/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "HotTableViewCell.h"

@implementation HotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.name.font = [UIFont fontWithName:Font_Name_PFSC size:16];
    self.author.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
    self.pageContent.font = [UIFont fontWithName:Font_Name_PFSCRe size:16];
}
//点赞按钮点击方法
- (void)buttonSelectedAnimation {
    
    [UIView animateWithDuration:0.3 animations:^{
        //
        self.praiseBut.transform = CGAffineTransformMakeScale(1.6, 1.6);
    } completion:^(BOOL finished) {
        //
        [UIView animateWithDuration:0.3 animations:^{
            //在放大后改变图片
            [self.praiseBut setImage:[UIImage imageNamed:@"praise_sele"] forState:(UIControlStateNormal)];
            //
            self.praiseBut.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }];
    
}
//取消点赞按钮动画
- (void)buttonCancelSelectedAnimation {
    
    [UIView animateWithDuration:0.3 animations:^{
        //
        self.praiseBut.transform = CGAffineTransformMakeScale(1.6, 1.6);
    } completion:^(BOOL finished) {
        //
        [UIView animateWithDuration:0.3 animations:^{
            //在缩放后改变图片
            [self.praiseBut setImage:[UIImage imageNamed:@"praise"] forState:(UIControlStateNormal)];
            //
            self.praiseBut.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
