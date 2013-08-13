//
//  ViewController.h
//  UIScrollViewDemo
//
//  Created by alex on 13-8-10.
//  Copyright (c) 2013年 alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, retain) UIView *navBar;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) BOOL tbFullScreen;

@property (nonatomic, assign) double prevCallTime;




@end
