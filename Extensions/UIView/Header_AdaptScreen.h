//
//  Header_AdaptScreen.h
//  UI_屏幕适配
//
//  Created by rimi on 15/10/14.
//  Copyright (c) 2015年 向洪. All rights reserved.
//

#ifndef UI______Header_AdaptScreen_h
#define UI______Header_AdaptScreen_h

#import <UIKit/UIKit.h>

static const CGFloat originWidth_ = 375.f;
static const CGFloat originHeight_ = 667.f;


#define DH_INLINE  static inline
/**
 *  水平方向比例计算
 *
 *
 *  @return 等比例适配后的值
 */
DH_INLINE CGFloat HorizontalRetio()
{
    return [UIScreen mainScreen].bounds.size.width / originWidth_;
}
/**
 *  竖直方向比例计算
 *
 *
 *  @return 等比例适配后的值
 */
DH_INLINE CGFloat VerticalRetio()
{
    return [UIScreen mainScreen].bounds.size.height / originHeight_;
}

DH_INLINE CGPoint cenerFromFrame(CGRect frame)
{
    return CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height/2);
}
DH_INLINE CGRect frameWithSizeAddCener(CGSize size, CGPoint center)
{
    return CGRectMake(floor(center.x - size.width/2), floor(center.y - size.height/2), size.width, size.height);
}
/**
 *  等比例适配center
 *
 *  @param center 基本屏幕的center
 *
 *  @return 适配后的center
 */
DH_INLINE CGPoint flexibleCenter(CGPoint center)
{
    CGFloat x = center.x * HorizontalRetio();
    CGFloat y = center.y * VerticalRetio();
    return CGPointMake(x, y);
}
/**
 *  等比例适配size
 *
 *  @param size        size 基本屏幕的size
 *  @param adjustWidth 如果是yes，则返回size的宽度同时乘以高的比例，如果是no，则返回高乘以高的比例，宽乘以宽的比例
 *
 *  @return 适配后的size
 */
DH_INLINE CGSize flexibleSize(CGSize size, BOOL adjustWidth)
{
    if (adjustWidth) {
        return CGSizeMake(size.width * VerticalRetio(), size.height * VerticalRetio());
    }
    return CGSizeMake(size.width * HorizontalRetio(), size.height * VerticalRetio());
}

DH_INLINE CGSize flexibleSizeHeight(CGSize size, BOOL adjustHeight)
{
    if (adjustHeight) {
        return CGSizeMake(size.width * HorizontalRetio(), size.height * HorizontalRetio());
    }
    return CGSizeMake(size.width * HorizontalRetio(), size.height * VerticalRetio());
}
/**
 *  等比例适配frame
 *
 *  @param frame        frame 基本屏幕的frame
 *  @param adjsutWidth 如果是yes，则返回size的宽度同时乘以高的比例，如果是no，则返回高乘以高的比例，宽乘以宽的比例
 *
 *  @return 适配后的frame
 */
DH_INLINE CGRect flexibleFrame(CGRect frame, BOOL adjsutWidth)
{
    CGPoint center = cenerFromFrame(frame);
    center = flexibleCenter(center);
    CGSize size = flexibleSize(frame.size, adjsutWidth);
    
    return frameWithSizeAddCener(size, center);
}

DH_INLINE CGRect flexibleFrameHeight(CGRect frame, BOOL adjsutHeight)
{
    CGPoint center = cenerFromFrame(frame);
    center = flexibleCenter(center);
    CGSize size = flexibleSizeHeight(frame.size, adjsutHeight);
    
    return frameWithSizeAddCener(size, center);
}
#endif
