//
//  UIScrollView+Scroll.m
//  CloudAlbum
//
//  Created by alex on 13-8-9.
//  Copyright (c) 2013年 com.baidu. All rights reserved.
//

#import "UIScrollView+Scroll.h"

#define kPrevCallTimeKey @"prevCallTime"
#define kOldContentOffsetKey @"oldContentOffset"
@implementation UIScrollView (Scroll)

- (double)prevCallTime {
    NSNumber *number = objc_getAssociatedObject(self, kPrevCallTimeKey);
    if (number==nil) {
        return 0;
    }else{
        return [number doubleValue];
    }
    return 0;
}

-(void)setPrevCallTime:(double)prevCallTime{
    objc_setAssociatedObject(self, kPrevCallTimeKey, [NSNumber numberWithDouble:prevCallTime], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGPoint)oldContentOffset {
    NSValue *value = objc_getAssociatedObject(self, kOldContentOffsetKey);
    if (value==nil) {
        return self.contentOffset;
    }else{
        return [value CGPointValue];
    }
    return CGPointZero;
}

-(void)setOldContentOffset:(CGPoint)contentOffset{
    objc_setAssociatedObject(self, kOldContentOffsetKey, [NSValue valueWithCGPoint:contentOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//类似scrollViewWillEndDragging:withVelocity:targetContentOffset:方法，它使用CGPoint表示CGVelocity
-(CGVelocity)velocityWhenScrolling{
    NSTimeInterval curCallTime = [[NSDate date] timeIntervalSince1970];
//    double curCallTime = CACurrentMediaTime();
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
