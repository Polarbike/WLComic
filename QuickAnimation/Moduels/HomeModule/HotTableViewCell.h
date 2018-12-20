//
//  HotTableViewCell.h
//  QuickAnimation
//
//  Created by Weilian on 29/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *author;

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (weak, nonatomic) IBOutlet UILabel *pageContent;

@property (weak, nonatomic) IBOutlet UIButton *praiseBut;

@property (weak, nonatomic) IBOutlet UILabel *praiseNum;


- (void)buttonSelectedAnimation;

- (void)buttonCancelSelectedAnimation;

@end

NS_ASSUME_NONNULL_END
