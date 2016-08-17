//
//  UIScrollView+Scroll.m
//  CloudAlbum
//
//  Created by alex on 13-8-9.
//  Copyright (c) 2013年 com.baidu. All rights reserved.
//

#import "UIScrollView+Scroll.h"

@implementation UIScrollView (Scroll)

@dynamic prevCallTime;
- (double)prevCallTime {
    NSNumber *number = objc_getAssociatedObject(self, @selector(prevCallTime));
    if (number==nil) {
        return 0;
    }else{
        return [number doubleValue];
    }
    return 0;
}

-(void)setPrevCallTime:(double)prevCallTime{
    objc_setAssociatedObject(self, @selector(prevCallTime), [NSNumber numberWithDouble:prevCallTime], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic oldContentOffset;
- (CGPoint)oldContentOffset {
    NSValue *value = objc_getAssociatedObject(self, @selector(oldContentOffset));
    if (value==nil) {
        return self.contentOffset;
    }else{
        return [value CGPointValue];
    }
    return CGPointZero;
}

-(void)setOldContentOffset:(CGPoint)contentOffset{
    objc_setAssociatedObject(self, @selector(oldContentOffset), [NSValue valueWithCGPoint:contentOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*!
 *  @brief  获取UIScrollView滚动速度
 *  @note   此方法必须在UIScrollViewDelegate的scrollViewDidScroll:方法中调用
 *  @note   scrollViewWillEndDragging:withVelocity:targetContentOffset:代理方法只能获取到用户停止拖动瞬间的滚动速度(它使用CGPoint表示CGVelocity),
 velocityWhenScrolling可以获取到任何时候的滚动速度
 *
 *  @return UIScrollView滚动速度
 */
-(CGVelocity)velocityWhenScrolling{
    //curCallTime为时间戳timeIntervalSince1970与CACurrentMediaTime均可
//    NSTimeInterval curCallTime = [[NSDate date] timeIntervalSince1970];
    double curCallTime = CACurrentMediaTime();
    double timeDelta = curCallTime - self.prevCallTime;
    CGPoint curCallOffset = self.contentOffset;
    double offsetDeltaY = curCallOffset.y - self.oldContentOffset.y;
    double offsetDeltaX = curCallOffset.x - self.oldContentOffset.x;
    
    double velocityY = offsetDeltaY / timeDelta;
    double velocityX = offsetDeltaX / timeDelta;
//    NSLog(@"velocityY:%f",velocityY);
//    NSLog(@"velocityX:%f",velocityX);

    self.prevCallTime = curCallTime;
    self.oldContentOffset = curCallOffset;    
    CGVelocity velocity=CGVelocityMake(velocityX, velocityY);
    return velocity;
}

@end
