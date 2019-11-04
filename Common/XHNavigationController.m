//
//  XHNavigationController.m
//  BSGrowthViewing
//
//  Created by 向洪 on 2017/8/14.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "XHNavigationController.h"

@interface XHNavigationController ()

@end

@implementation XHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
