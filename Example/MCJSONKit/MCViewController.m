//
//  MCViewController.m
//  MCJSONKit
//
//  Created by mylcode on 11/04/2017.
//  Copyright (c) 2017 mylcode. All rights reserved.
//

#import "MCViewController.h"
#import "HomeTimelineController.h"

@interface MCViewController ()

@end

@implementation MCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_backgroud"];
    self.tabBar.tintColor = [UIColor grayColor];
    NSArray<NSArray *> *tabbarItems = @[@[@"首页",@"tabbar_home",[HomeTimelineController class]],
                                        @[@"消息",@"tabbar_message_center"],
                                        @[@"发现",@"tabbar_discover"],
                                        @[@"我",@"tabbar_profile"]];
    NSMutableArray *marr = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        UIViewController *viewController;
        if (tabbarItems[i].count > 2) {
            viewController = [[UINavigationController alloc] initWithRootViewController:[tabbarItems[i][2] new]];
        }else {
            viewController = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
        }
        viewController.tabBarItem.title = tabbarItems[i][0];
        NSString *imgName = tabbarItems[i][1];
        viewController.tabBarItem.image = [UIImage imageNamed:imgName];
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:[imgName stringByAppendingString:@"_selected"]];
        [marr addObject:viewController];
    }
    
    self.viewControllers = [marr copy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
