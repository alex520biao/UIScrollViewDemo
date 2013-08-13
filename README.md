UIScrollViewDemo
================

UIScrollView滚动状态信息封装:滚动方向/滚动速度等信息；


使用方法:
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint  vel=[scrollView velocityWhenScrolling];
    
    //拖动越过内容最顶部继续拖动强制设置为_tbFullScreen=NO
    if (scrollView.contentOffset.y<0) {
        [self setTbFullScreen:NO time:0.2];
        return;
    }
    
    //contentSize小于frame.size,内容不满一屏，无需调用setTbFullScreen
    if (scrollView.contentSize.height<scrollView.bounds.size.height) {
        return;
    }else{
        if(scrollView.contentOffset.y>0&&scrollView.contentOffset.y>= scrollView.contentSize.height-scrollView.bounds.size.height){
            return;
        }
    }

    if (fabs(vel.y)> 200) {
        BOOL full=NO;
        if (vel.y>0) {
            full=YES;
        }else{
            full=NO;
        }
        [self setTbFullScreen:full time:0.2];
    }
}

