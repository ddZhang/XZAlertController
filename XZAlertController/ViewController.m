//
//  ViewController.m
//  XZAlertController
//
//  Created by yq on 2018/2/26.
//  Copyright © 2018年 yq. All rights reserved.
//

#import "ViewController.h"
#import "XZAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self XZ_showAlertWithTitle:@"tip" message:@"message" appearanceProcess:^(XZAlertController * _Nonnull alertMaker) {
        
        alertMaker.addDestructiveTitle(@"取消");
        alertMaker.addDefaultTitle(@"确定");
        
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, XZAlertController * _Nonnull alertSelf) {
        NSLog(@"%li",buttonIndex);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
