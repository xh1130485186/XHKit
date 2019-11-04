//
//  XHUICommonViewController.m
//  BSGrowthViewing
//
//  Created by 向洪 on 2017/8/11.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "XHUICommonViewController.h"
#import "UIView+XHRect.h"
#import "UIImage+XHColor.h"

@interface XHUICommonViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic) NSInteger topActivityIndicatorStartAnimationCount;  // 获取指示器调用次数

@end

@implementation XHUICommonViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}


#pragma mark - life cycle
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] && _interactivePopGestureRecognizerEnabled == NO) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self.navigationController.navigationBar addSubview:self.topActivityIndicatorView];
    [self updateTopActivityIndicatorViewLocation];
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    if (_interactivePopGestureRecognizerEnabled == NO) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    _topActivityIndicatorStartAnimationCount = 0;
    [_topActivityIndicatorView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _interactivePopGestureRecognizerEnabled = YES;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    [self initializedAppearance];

}


// 基本调用的方法，方便操作
- (void)initializedAppearance {
    
}

#pragma mark - 控制返回
// 返回事件
- (BOOL)navigationShouldPopOnBackButton {

    NSInteger count1 = self.navigationController.viewControllers.count;
    BOOL pop = [self navigationShouldPopOnBackBarButtonItemEvent];
    NSInteger count2 = self.navigationController.viewControllers.count;
    if (count1 == count2 && !pop) {
        
        for(UIView *subview in [self.navigationController.navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return pop;
}

- (BOOL)navigationShouldPopOnBackBarButtonItemEvent {

    return YES;
}

- (void)setInteractivePopGestureRecognizerEnabled:(BOOL)interactivePopGestureRecognizerEnabled {

    _interactivePopGestureRecognizerEnabled = interactivePopGestureRecognizerEnabled;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = _interactivePopGestureRecognizerEnabled;
    }
}


#pragma mark - 指示器
- (void)setTitle:(NSString *)title {

    [super setTitle:title];
    [self updateTopActivityIndicatorViewLocation];
}

- (void)topActivityIndicatorStartAnimating {

    _topActivityIndicatorStartAnimationCount ++;
    if (!self.topActivityIndicatorView.isAnimating) {
        [self.topActivityIndicatorView startAnimating];
    }
}

- (void)topActivityIndicatorStopAnimating {

    _topActivityIndicatorStartAnimationCount --;
    if (_topActivityIndicatorStartAnimationCount < 0) {
        _topActivityIndicatorStartAnimationCount = 0;
    }
    if (self.topActivityIndicatorView.isAnimating && _topActivityIndicatorStartAnimationCount == 0) {
        [self.topActivityIndicatorView stopAnimating];
    }
}


- (UIActivityIndicatorView *)topActivityIndicatorView {
    
    if (!_topActivityIndicatorView) {
        _topActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _topActivityIndicatorView.color = [UIColor whiteColor];
        [self updateTopActivityIndicatorViewLocation];
        
    }
    return _topActivityIndicatorView;
}

- (void)updateTopActivityIndicatorViewLocation {
    __weak __typeof(self)weakSelf = self;
    [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(IOS_DEVICE_VERSION_FLOATVALUE(11)) {
            
            if ([NSStringFromClass([obj class]) isEqualToString:@"_UINavigationBarContentView"]) {
                [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   
                    if ([obj isKindOfClass:[UILabel class]]) {
                        weakSelf.topActivityIndicatorView.center = CGPointMake(obj.xh_x - 15, UINavigationBarHeightAdapter * 0.5);
                    }
                }];
            }
            
        } else {
            if ([NSStringFromClass([obj class]) isEqualToString:@"UINavigationItemView"]) {
                weakSelf.topActivityIndicatorView.center = CGPointMake(obj.xh_x - 15, UINavigationBarHeightAdapter * 0.5);
            }
        }
    }];
}

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - 空数据

- (void)showEmptyView:(UIScrollView *)view {
    if (!view.emptyDataSetDelegate) {
        view.emptyDataSetSource = self;
        view.emptyDataSetDelegate = self;
        [view reloadEmptyDataSet];
    }
}

- (void)hideEmptyView:(UIScrollView *)view {
    [view reloadEmptyDataSet];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    UIImage *returnImage = XHKitImage(@"wushuju");
    return returnImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"亲，暂时没有任何数据!";
    UIColor *textColor = [UIColor grayColor];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:textColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 0;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self noDatabuttonEvent:scrollView];
}

- (void)noDatabuttonEvent:(UIScrollView *)scrollView {

}

@end
