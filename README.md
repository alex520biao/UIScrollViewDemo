UIScrollViewDemo
================

UIScrollView滚动状态信息封装:滚动方向/滚动速度等信息；


使用方法:

-(void)setTbFullScreen:(BOOL)tbFullScreen time:(NSTimeInterval)time{
    if (_tbFullScreen!=tbFullScreen) {
        _tbFullScreen=tbFullScreen;
        
        if (_tbFullScreen) {
            NSLog(@"_tbFullScreenYES");
            __block ViewController *controller=(ViewController*)self;
            [UIView animateWithDuration:time animations:^{
                CGRect frame=self.navBar.frame;
                frame.origin.y=-self.navBar.frame.size.height;
                self.navBar.frame=frame;
                
                CGRect frame1=controller.tableView.frame;
                frame1.origin.y=0;
                frame1.size.height=controller.view.bounds.size.height;
                controller.tableView.frame=frame1;
            }];
        }
        
        if (!_tbFullScreen) {
            NSLog(@"_tbFullScreenNO");
            __block ViewController *controller=(ViewController*)self;
            [UIView animateWithDuration:time animations:^{
                CGRect frame=self.navBar.frame;
                frame.origin.y=0;
                self.navBar.frame=frame;
                
                CGRect frame1=controller.tableView.frame;
                frame1.origin.y=self.navBar.frame.size.height;
                frame1.size.height=controller.view.bounds.size.height-self.navBar.frame.size.height;
                controller.tableView.frame=frame1;
            }];
        }
    }

}
