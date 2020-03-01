//
//  XYHPhotoVC.m
//  PhotoShare
//
//  Created by yuhangxi on 2020/1/16.
//  Copyright © 2020 yuhangxi. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "XYHPhotoVC.h"
#import "XYHEdictVC.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width*1.0
#define kScreenH [UIScreen mainScreen].bounds.size.height*1.0

@interface XYHPhotoVC ()<AVCaptureDepthDataOutputDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;

@property (weak, nonatomic) IBOutlet UIButton *albumBtn;

//设备:后摄，前摄，麦克风
@property (strong, nonatomic) AVCaptureDevice *device;
//输入设备
@property (strong, nonatomic) AVCaptureDeviceInput  *input;
//输出图片
@property (strong, nonatomic) AVCaptureStillImageOutput  *imageOutput;
//结合输入输出，开启捕获
@property (strong, nonatomic) AVCaptureSession  *session;
//图层预览
@property (strong, nonatomic) AVCaptureVideoPreviewLayer  *previewlayer;



@end

@implementation XYHPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initializeCamera];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [self.session startRunning];
}

-(void)setupUI{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(-6, 8, 21, 24)];
    imageview.image = [UIImage imageNamed:@"publish-icon-1"];
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:24];
    lable.text = @"发布";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentLeft;
    [lable sizeToFit];
    lable.frame = CGRectMake(20, 1, 60, 40);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [view addSubview:imageview];
    [view addSubview:lable];
    self.navigationItem.titleView = view;
    [self.photoBtn addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [self.albumBtn addTarget:self action:@selector(openPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)initializeCamera{
   
    //    AVCaptureDevicePositionBack  后置摄像头
    //    AVCaptureDevicePositionFront 前置摄像头
       self.device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
     
        self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
        self.session = [[AVCaptureSession alloc] init];
        //     拿到的图像的大小可以自行设定
        //    AVCaptureSessionPreset320x240
        //    AVCaptureSessionPreset352x288
        //    AVCaptureSessionPreset640x480
        //    AVCaptureSessionPreset960x540
        //    AVCaptureSessionPreset1280x720
        //    AVCaptureSessionPreset1920x1080
        //    AVCaptureSessionPreset3840x2160
        self.session.sessionPreset = AVCaptureSessionPreset640x480;
        //输入输出设备结合
        if ([self.session canAddInput:self.input]) {
            [self.session addInput:self.input];
        }
        if ([self.session canAddOutput:self.imageOutput]) {
            [self.session addOutput:self.imageOutput];
        }
        //预览层的生成
        self.previewlayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    //64 240
        self.previewlayer.frame = CGRectMake(0, 0, kScreenW, kScreenH-289);
        self.previewlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer addSublayer:self.previewlayer];
        //设备取景开始
        [self.session startRunning];
        if ([_device lockForConfiguration:nil]) {
        //自动闪光灯，
            if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
                [_device setFlashMode:AVCaptureFlashModeAuto];
                
            }
            //自动白平衡,但是好像一直都进不去
            if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
                [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
            }
            [_device unlockForConfiguration];
        }
     
    }


- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    /*
     'devicesWithMediaType:' is deprecated: first deprecated in iOS 10.0 - Use AVCaptureDeviceDiscoverySession instead.
     */
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}

-(void)takePicture{
//    NSLog(@"点击了拍照");
    AVCaptureConnection *conntion = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
      }
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
        if (imageDataSampleBuffer == nil) {
            return ;
          }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        [self.session stopRunning];
        XYHEdictVC *edictvc = [[XYHEdictVC alloc] init];
        edictvc.accimage = [UIImage imageWithData:imageData];
        [self.navigationController pushViewController:edictvc animated:YES];
    } ];
}

-(void)openPhotoAlbum{
//    XYHLog(@"点击了相册");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        XYHEdictVC *edictvc = [[XYHEdictVC alloc] init];
        edictvc.accimage = image;
        [self.navigationController pushViewController:edictvc animated:YES];
    }];
    
}

@end
