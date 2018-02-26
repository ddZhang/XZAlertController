//
//  XZAlertController.h
//  TDAlert
//
//  Created by yq on 2017/9/11.
//  Copyright © 2017年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZAlertController;

typedef void (^XZAlertActionBlock)(NSInteger buttonIndex, UIAlertAction * _Nonnull action, XZAlertController * _Nonnull alertSelf);

typedef void(^XZAlertAddTitle)(NSString * _Nonnull string);

@interface XZAlertController : UIAlertController

@property (nonatomic, copy) XZAlertAddTitle _Nullable addDefaultTitle;
@property (nonatomic, copy) XZAlertAddTitle _Nullable addCancelTitle;
@property (nonatomic, copy) XZAlertAddTitle _Nullable addDestructiveTitle;

@end

typedef void(^XZAlertAppearanceProcess)(XZAlertController * _Nonnull alertMaker);

@interface UIViewController (XZAlertController)

- (void)XZ_showAlertWithTitle:(NSString * _Nullable)title
                      message:(NSString * _Nullable)message
            appearanceProcess:(XZAlertAppearanceProcess _Nonnull)appearanceProcess
                 actionsBlock:(XZAlertActionBlock _Nonnull)actionBlock;

@end
