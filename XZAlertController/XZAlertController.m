//
//  XZAlertController.m
//  TDAlert
//
//  Created by yq on 2017/9/11.
//  Copyright © 2017年 yq. All rights reserved.
//

#import "XZAlertController.h"

#pragma mark - —— XZAlertActionModel ——

@interface XZAlertActionModel : NSObject

@property (nonatomic, copy) NSString * title;

@property (nonatomic, assign) UIAlertActionStyle style;

@end

@implementation XZAlertActionModel

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"";
        self.style = UIAlertActionStyleDefault;
    }
    return self;
}

@end

#pragma mark - —— XZAlertController ——

@interface XZAlertController ()

//AlertActionModel数组
@property (nonatomic, strong) NSMutableArray <XZAlertActionModel *>* XZ_alertActionArray;
//action配置
@property (nonatomic, copy) void (^XZAlertActionsConfig)(XZAlertActionBlock);

@end

@implementation XZAlertController

- (instancetype)initAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    if (title == nil) {
        title = @"1";
    }
    if (message == nil) {
        message = @"1";
    }
    
    self = [[self class] alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (!self) return nil;
    
    return self;
}

- (void (^)(XZAlertActionBlock))XZAlertActionsConfig
{
    return ^(XZAlertActionBlock actionBlock) {
        
        if (self.XZ_alertActionArray.count > 0) {
            
            __weak typeof(self)weakSelf = self;
            [self.XZ_alertActionArray enumerateObjectsUsingBlock:^(XZAlertActionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                UIAlertAction *action = [UIAlertAction actionWithTitle:obj.title style:obj.style handler:^(UIAlertAction * _Nonnull action) {
                    
                    __strong typeof(weakSelf)strongSelf = weakSelf;
                    
                    if (actionBlock) {
                        actionBlock(idx,action,strongSelf);
                    }
                }];
                [weakSelf addAction:action];
            }];
        }
        else {
            NSLog(@"没有action");
        }
    };
}

- (XZAlertAddTitle)addDefaultTitle
{
    return ^(NSString *string){
        
        XZAlertActionModel *model = [[XZAlertActionModel alloc] init];
        model.title = string;
        model.style = UIAlertActionStyleDefault;
        [self.XZ_alertActionArray addObject:model];
    };
}

- (XZAlertAddTitle)addCancelTitle
{
    return ^(NSString *string){
        
        XZAlertActionModel *model = [[XZAlertActionModel alloc] init];
        model.title = string;
        model.style = UIAlertActionStyleCancel;
        [self.XZ_alertActionArray addObject:model];
    };
}

- (XZAlertAddTitle)addDestructiveTitle
{
    return ^(NSString *string){
        
        XZAlertActionModel *model = [[XZAlertActionModel alloc] init];
        model.title = string;
        model.style = UIAlertActionStyleDestructive;
        [self.XZ_alertActionArray addObject:model];
    };
}

- (NSMutableArray<XZAlertActionModel *> *)XZ_alertActionArray
{
    if (!_XZ_alertActionArray) {
        _XZ_alertActionArray = [NSMutableArray array];
    }
    return _XZ_alertActionArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    
    NSLog(@"alert dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

#pragma mark - —— UIViewController 扩展 ——

@implementation UIViewController (TDAlertController)

- (void)XZ_showAlertWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message appearanceProcess:(XZAlertAppearanceProcess)appearanceProcess actionsBlock:(XZAlertActionBlock)actionBlock
{
    if (appearanceProcess)
    {
        XZAlertController *alertMaker = [[XZAlertController alloc] initAlertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        //防止nil
        if (!alertMaker) {
            return ;
        }
        //加工链
        appearanceProcess(alertMaker);
        //配置响应
        alertMaker.XZAlertActionsConfig(actionBlock);
        
        [self presentViewController:alertMaker animated:YES completion:nil];
    }
}

- (void)XZ_showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(XZAlertAppearanceProcess)appearanceProcess actionsBlock:(XZAlertActionBlock)actionBlock
{
    [self XZ_showAlertWithPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}

@end
