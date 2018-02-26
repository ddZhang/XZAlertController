# XZAlertController
使用链式语法对系统alertController进行封装

核心思想是灵活运用block实现正反传值

'''

调用方法如下：

    [self XZ_showAlertWithTitle:@"tip" message:@"message" appearanceProcess:^(XZAlertController * _Nonnull alertMaker) {
        
        alertMaker.addDestructiveTitle(@"取消");
        alertMaker.addDefaultTitle(@"确定");
        
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, XZAlertController * _Nonnull alertSelf) {
        NSLog(@"%li",buttonIndex);
    }];
    
'''






