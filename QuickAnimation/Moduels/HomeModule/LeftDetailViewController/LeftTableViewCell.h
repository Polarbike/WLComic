//
//  LeftTableViewCell.h
//  QuickAnimation
//
//  Created by Weilian on 11/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;



@end

NS_ASSUME_NONNULL_END
