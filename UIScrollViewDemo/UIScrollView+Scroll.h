//
//  UIScrollView+Scroll.h
//  CloudAlbum
//
//  Created by alex on 13-8-9.
//  Copyright (c) 2013年 com.baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

//CGVelocity表示UIScrollView滚动速度:velX表示x轴滚动速率及方向，velY表示y轴滚动速度(数值表示速率，正负表示速度在x/y对应的方向).
//velX与velY均为向量，合成CGVelocity向量.
//CGVelocity与CGPoint结构完全相同.
struct CGVelocity {
    CGFloat velX;
    CGFloat velY;
};
typedef struct CGVelocity CGVelocity;

CG_INLINE CGVelocity
CGVelocityMake(CGFloat velX, CGFloat velY)
{
    CGVelocity vel; vel.velX = velX; vel.velY = velY; return vel;
}


@interface UIScrollView (Scroll)

@property(nonatomic,assign)double prevCallTime;
@property(nonatomic,assign)CGPoint oldContentOffset;


/*!
 *  @brief  获取UIScrollView滚动速度
 *  @note   此方法必须在UIScrollViewDelegate的scrollViewDidScroll:方法中调用
 *  @note   scrollViewWillEndDragging:withVelocity:targetContentOffset:代理方法只能获取到用户停止拖动瞬间的滚动速度(它使用CGPoint表示CGVelocity),
 velocityWhenScrolling可以获取到任何时候的滚动速度
 *
 *  @return UIScrollView滚动速度
 */
-(CGVelocity)velocityWhenScrolling;

@end
