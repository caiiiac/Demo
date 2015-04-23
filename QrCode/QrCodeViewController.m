//
//  QrCodeViewController.m
//  Demo
//
//  Created by caiiiac on 15-4-17.
//  Copyright (c) 2015年 sun3d. All rights reserved.
//

#import "QrCodeViewController.h"
#import "QRCodeGenerator.h"

@interface QrCodeViewController ()

@end

@implementation QrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)createQrCode:(id)sender {
    /*字符转二维码
     导入 libqrencode文件
     引入头文件#import "QRCodeGenerator.h" 即可使用
     */
    _imgView.image = [QRCodeGenerator qrImageForString:_textField.text imageSize:_imgView.bounds.size.width];
    _imgView.backgroundColor = [UIColor whiteColor];
}

- (IBAction)responder:(id)sender {
    
    //键盘释放
    [_textField resignFirstResponder];
}

- (BOOL)shouldAutorotate
{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
@end
