//
//  XHContainer.m
//  BSGrowthViewing
//
//  Created by 向洪 on 2017/8/15.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "XHContainerControl.h"

#define UIScreen_Frame _displayView.frame
#define KEYWINDOW [[[UIApplication sharedApplication] delegate] window]

@interface XHContainerControl ()

@property (nonatomic, weak) UIView *displayView;
@property (nonatomic, strong) UIVisualEffectView *effectView; // 高斯模糊
@property (nonatomic, strong) UIButton *mask; // 遮罩
@property (nonatomic) CGSize size;

@property (nonatomic, strong) NSMutableArray *constraintsCache;

@end

@implementation XHContainerControl

- (instancetype)initWithSize:(CGSize)size style:(XHContainerStyle)style {
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        _style = style;
        [self initialize_container];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithSize:frame.size style:XHContainerCenter];
}

- (void)initialize_container {
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithWhite:243/255.f alpha:0.8];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 模糊效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self insertSubview:self.effectView atIndex:0];
    self.effectView.translatesAutoresizingMaskIntoConstraints = NO;
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_effectView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_effectView)]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_effectView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_effectView)]];
    [self addConstraints:constraints];
    
}

#pragma mark - 显示和隐藏

- (void)show {
    [self show:nil];
}

- (void)show:(UIView *)displayView {
    
    if (!displayView) {
        displayView = KEYWINDOW;
    }
    self.displayView = displayView;
    if (self.style == XHContainerCenter) {
        self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1);
    }
    [displayView endEditing:YES];
    [UIView animateWithDuration:0.25 delay:0 options:7<<16 animations:^{
        
        self.mask.alpha = 0.3;
        if (self.style == XHContainerCenter) {
            self.alpha = 1;
            self.layer.transform = CATransform3DIdentity;
        } else if (self.style == XHContainerBottom) {

            NSLayoutConstraint *contstraint = self.constraintsCache[3];
            contstraint.constant = 0;
            [self.displayView layoutIfNeeded];
        }
    } completion:^(BOOL finished) {
    }];
    
}

- (void)hide {
    [self endEditing:YES];
    [self.displayView layoutIfNeeded];
    [UIView animateWithDuration:0.25 delay:0 options:8<<16 animations:^{
        
        self.mask.alpha = 0;
        
        if (self.style == XHContainerCenter) {
            self.alpha = 0;
        } else if (self.style == XHContainerBottom) {
            
            NSLayoutConstraint *contstraint = self.constraintsCache[3];
            contstraint.constant = -self.size.height;
            [self.displayView layoutIfNeeded];
        }
        
    } completion:^(BOOL finished) {
        self.displayView = nil;
    }];
    
    if (self.hiddenProcessingHandler) {
        self.hiddenProcessingHandler();
    }
}

#pragma mark - Setter Methods

- (void)setStyle:(XHContainerStyle)style {

    _style = style;
    if (self.superview) {
        switch (_style) {
            case XHContainerCenter:
            {
                [self.displayView removeConstraints:self.constraintsCache];
                NSMutableArray *constraints = [NSMutableArray array];
                [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[self(%lf)]", self.size.width] options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
                [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[self(%lf)]", self.size.height] options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
                [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
                [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
                
                self.constraintsCache = constraints;
                [self.displayView addConstraints:constraints];
                [self.displayView layoutIfNeeded];
            
            }
                break;
            case XHContainerBottom: {
            
                [self.displayView removeConstraints:self.constraintsCache];
                NSMutableArray *constraints = [NSMutableArray array];
                [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[self]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
                [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[self(%lf)]-(%lf)-|", self.size.height, -self.size.height] options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
                self.constraintsCache = constraints;
                [self.displayView addConstraints:constraints];
                [self.displayView layoutIfNeeded];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)setDisplayView:(UIView *)displayView {
    
    if (displayView) {
        
        if ([displayView isEqual:_displayView]) {
            return;
        }
        
        if (self.superview) {
            [self removeFromSuperview];
        }
        if (_mask.superview) {
            [_mask removeFromSuperview];
        }
        
        [displayView addSubview:self.mask];
        self.mask.translatesAutoresizingMaskIntoConstraints = NO;
        NSMutableArray *constraints = [NSMutableArray array];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_mask]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_mask]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
        [displayView addConstraints:constraints];
        [displayView addSubview:self];
        _displayView = displayView;
        [self setStyle:self.style];
    } else {
        [self removeFromSuperview];
        [_mask removeFromSuperview];
        _displayView = nil;
    }
}


- (void)setIsHideMask:(BOOL)isHideMask {
    
    _isHideMask = isHideMask;
    _mask.hidden = isHideMask;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    _size = frame.size;
}

#pragma mark - 遮罩

- (UIButton *)mask {
    
    if (!_mask) {
        _mask = [UIButton buttonWithType:UIButtonTypeCustom];
        _mask.backgroundColor = [UIColor blackColor];
        _mask.alpha = 0;
        [_mask addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mask;
}


@end
