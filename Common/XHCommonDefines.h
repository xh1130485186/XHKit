//
//  XHCommonDefines.h
//  XHKitDemo
//
//  Created by 向洪 on 2019/11/1.
//  Copyright © 2019 向洪. All rights reserved.
//

#ifndef XHCommonDefines_h
#define XHCommonDefines_h

#define kIDENTIFIERCELL @"kXHIDENTIFIERCELL"

// 主线程安全
#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

#pragma mark - 内联函数

#define XH_INLINE  static inline

XH_INLINE NSString *XHStringFractionDigits(CGFloat fa, NSInteger maximumFractionDigits) {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterNoStyle;
    numberFormatter.maximumFractionDigits = maximumFractionDigits;
    numberFormatter.minimumIntegerDigits = 1;
    numberFormatter.maximumIntegerDigits = 10;
    numberFormatter.multiplier = @1;
    return [numberFormatter stringFromNumber:@(fa)];
}

XH_INLINE NSString *XHBundlePathForResource(NSString *bundleName, Class aClass, NSString *resourceName, NSString *ofType, BOOL times) {
    NSBundle *bundle = [NSBundle bundleForClass:aClass];
    NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    NSString *name = resourceName;
    if (times) {
        name = [UIScreen mainScreen].scale==3?[name stringByAppendingString:@"@3x"]:[name stringByAppendingString:@"@2x"];
    }
    NSString *imagePath = [bundle pathForResource:name ofType:ofType];
    return imagePath;
}

#endif /* XHCommonDefines_h */
