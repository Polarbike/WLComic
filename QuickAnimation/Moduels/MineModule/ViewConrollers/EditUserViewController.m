//
//  EditUserViewController.m
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "EditUserViewController.h"
#import "JQImagePicker.h"

@interface EditUserViewController ()<JQImagePickerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *alertTittle;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UITextField *nickInput;

@property (weak, nonatomic) IBOutlet UIButton *cancel;

@property (weak, nonatomic) IBOutlet UIButton *save;

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setEditPageInfo];
    //
    self.view.backgroundColor = kRGB(251, 227, 76, 1);
}

#pragma mark -- 设置页面基本信息
- (void)setEditPageInfo {
    
    self.userImage.image = self.image;
    self.userImage.layer.cornerRadius = self.userImage.bounds.size.width/2;
    self.userImage.layer.masksToBounds = YES;
    self.alertTittle.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
    self.alertTittle.textColor = kRGB(80, 80, 80, 0.8);
    self.alertTittle.text = @"点击头像编辑";
    self.nickName.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
    self.nickName.textColor = kRGB(40, 40, 40, 1);
    self.nickName.text = @"昵称";
    self.nickInput.text = self.userName;
    //
    self.cancel.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
    self.cancel.titleLabel.textColor = kRGB(40, 40, 40, 1);
    //
    self.save.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
    self.cancel.titleLabel.textColor = kRGB(40, 40, 40, 1);
    //
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editUserImageAction)];
    [self.userImage addGestureRecognizer:tapGesture];
}

- (IBAction)cancelButtonClickAction:(id)sender {
    //q取消编辑，dismiss页面
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)saveButtonClickAction:(id)sender {
    //使用代理返回编辑的数据
    if ([_editDelegate respondsToSelector:@selector(getEditUserImage:)]) {
        
        [_editDelegate getEditUserImage:self.userImage.image];
    }
    if ([_editDelegate respondsToSelector:@selector(getUserNickName:)]) {
        
        [_editDelegate getUserNickName:self.nickInput.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 点击头像执行方法
- (void)editUserImageAction {
    
    //在这里选择图片
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择图片" message:@"选择照片方式" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //
        JQImagePicker *picker = [JQImagePicker sharedInstance];
        picker.delegate = self;
        [picker showOriginalImagePickerWithType:(ImagePickerCamera) InViewController:self];
    }];
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //
        JQImagePicker *picker = [JQImagePicker sharedInstance];
        picker.delegate = self;
        [picker showOriginalImagePickerWithType:(ImagePickerPhoto) InViewController:self];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertVC addAction:cameraAction];
    [alertVC addAction:libraryAction];
    [alertVC addAction:cancel];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark -- 图片选择代理返回数据
- (void)imagePickerDidCancel:(JQImagePicker *)imagePicker {
    
    NSLog(@"取消");
}

- (void)imagePicker:(JQImagePicker *)imagePicker didFinished:(UIImage *)editedImage {
    
    self.userImage.image = editedImage;
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
