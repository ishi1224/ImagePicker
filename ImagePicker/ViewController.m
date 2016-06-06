//
//  ViewController.m
//  ImagePicker
//
//  Created by zhangwenqiang on 16/4/7.
//  Copyright © 2016年 zhangwenqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    UIButton* buttonCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCamera.frame = CGRectMake(0, 0, 100, 50);
    buttonCamera.center = CGPointMake(width/2, height/2);
    [buttonCamera setTitle:@"打开相机" forState:UIControlStateNormal];
    [buttonCamera setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonCamera addTarget:self action:@selector(openCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonCamera];
    
    UIButton* buttonAblum = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonAblum.frame = CGRectMake(0, 0, 100, 50);
    buttonAblum.center = CGPointMake(width/2, height/2-80);
    [buttonAblum setTitle:@"打开相册" forState:UIControlStateNormal];
    [buttonAblum setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonAblum addTarget:self action:@selector(openAblum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonAblum];
}

//打开本地相册
-(void)openAblum:(UIButton*)button{
    [UIApplication sharedApplication].statusBarHidden = YES;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;//***
    [self presentViewController:picker animated:YES completion:nil];
}

//开始拍照
-(void)openCamera:(UIButton*)button{
    NSLog(@"相机");
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [UIApplication sharedApplication].statusBarHidden = YES;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        picker.modalPresentationStyle = UIModalPresentationCurrentContext;
        picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
        [self presentViewController:picker animated:YES completion:^{}];
    }
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [UIApplication sharedApplication].statusBarHidden = NO;
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //当选择的类型是图片
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        if ([type isEqualToString:@"public.image"]){
            NSLog(@"打开相册返回");
            //先把图片转成NSData
            
            //这里要处理打开相册返回的图片
        }
    } else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        NSLog(@"打开相机返回");
        //这里处理拍照后返回的图片
        [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    }
    NSLog(@"打开相");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) saveImage:(UIImage*)image{
    NSLog(@"保存照片");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
