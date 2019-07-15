//
//  scanQRCodeController.m
//  YYUIKit
//
//  Created by Michael on 2019/7/15.
//  Copyright © 2019年 winwayworld. All rights reserved.
//

#import "scanQRCodeController.h"
#import <AVFoundation/AVFoundation.h>

@interface scanQRCodeController ()<AVCaptureMetadataOutputObjectsDelegate>
//输入输出的中间桥梁
@property(nonatomic, strong)AVCaptureSession *session;
@end

@implementation scanQRCodeController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //300为正方形扫描区域边长
    [self startScanWithSize:300];
}

#pragma mark -- 开始扫描
- (void)startScanWithSize:(CGFloat)sizeValue
{
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //判断输入流是否可用
    if (input) {
        //创建输出流
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
        //设置代理,在主线程里刷新,注意此时self需要签AVCaptureMetadataOutputObjectsDelegate协议
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //初始化连接对象
        self.session = [[AVCaptureSession alloc]init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        [_session addInput:input];
        [_session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        //扫描区域大小的设置:(这部分也可以自定义,显示自己想要的布局)
        AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        //设置为宽高为200的正方形区域相对于屏幕居中
        layer.frame = CGRectMake((self.view.bounds.size.width - sizeValue) / 2.0, (self.view.bounds.size.height - sizeValue) / 2.0, sizeValue, sizeValue);
        [self.view.layer insertSublayer:layer atIndex:0];
        //开始捕获图像:
        [_session startRunning];
    }
}

#pragma mark - 扫面结果在这个代理方法里获取到
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        //获取到信息后停止扫描:
        [self playSoundMusic];
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metaDataObject = [metadataObjects objectAtIndex:0];
        //输出扫描字符串:
        NSLog(@"%@", metaDataObject.stringValue);
        //移除扫描视图:
        AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)[[self.view.layer sublayers] objectAtIndex:0];
        [layer removeFromSuperlayer];
    }
}

#pragma mark - 播放音乐
- (void)playSoundMusic
{

}


@end
