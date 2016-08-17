//
//  ViewController.m
//  UIScrollViewDemo
//
//  Created by alex on 13-8-10.
//  Copyright (c) 2013年 alex. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+Scroll.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize navBar=_navBar;
@synthesize tbFullScreen=_tbFullScreen;
@synthesize tableView=_tableView;
@synthesize prevCallTime=_prevCallTime;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tbFullScreen=NO;
    
    UIView *navBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    navBar.backgroundColor=[UIColor blueColor];
    self.navBar=navBar;
    [navBar release];
    [self.view addSubview:self.navBar];
    
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.frame.size.height, 320, self.view.frame.size.height-self.navBar.frame.size.height)];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.contentSize=CGSizeMake(320, 1000);
    [self.view addSubview:tableView];
    self.tableView=tableView;
    [tableView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTbFullScreen:(BOOL)tbFullScreen time:(NSTimeInterval)time{
    if (_tbFullScreen!=tbFullScreen) {
        _tbFullScreen=tbFullScreen;
        
        if (_tbFullScreen) {
//            NSLog(@"_tbFullScreenYES");
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
//            NSLog(@"_tbFullScreenNO");
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

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGVelocity  vel=[scrollView velocityWhenScrolling];
    NSLog(@"velocityY:%f,velocityX:%f",vel.velY,vel.velX);
    
    //滚动越过content最顶部继续拖动强制设置为_tbFullScreen=NO
    if (scrollView.contentOffset.y<0) {
        [self setTbFullScreen:NO time:0.2];
        return;
    }

    //contentSize小于frame.size,内容不满一屏，无需调用setTbFullScreen
    if (scrollView.contentSize.height<scrollView.bounds.size.height) {
        return;
    }else{
        //滚动越过content最顶部
        if (scrollView.contentOffset.y<=0) {
            return;
        }
        //滚动越过内容content最底部
        if(scrollView.contentOffset.y>0&&scrollView.contentOffset.y>= scrollView.contentSize.height-scrollView.bounds.size.height){
            return;
        }
    }

    if (fabs(vel.velY)> 200) {
        BOOL full=NO;
        if (vel.velY>0) {
            full=YES;
        }else{
            full=NO;
        }
        [self setTbFullScreen:full time:0.2];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    NSLog(@"velocity:%@",NSStringFromCGPoint(velocity));
//    NSLog(@"targetContentOffset:%@",NSStringFromCGPoint(*targetContentOffset));
//    NSLog(@"qqq");
}


#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text=[NSString stringWithFormat:@"cell%d",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



@end
