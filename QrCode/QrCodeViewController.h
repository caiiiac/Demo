//
//  QrCodeViewController.h
//  Demo
//
//  Created by caiiiac on 15-4-17.
//  Copyright (c) 2015年 sun3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QrCodeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

- (IBAction)createQrCode:(id)sender;

- (IBAction)responder:(id)sender;



@end
