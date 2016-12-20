//
//  MainViewController.m
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "MainViewController.h"
#import "HomeTimelineController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_backgroud"];
    self.tabBar.tintColor = [UIColor grayColor];
    NSArray *tabbarItems = @[@[@"首页",@"tabbar_home"],
                             @[@"消息",@"tabbar_message_center"],
                             @[@"发现",@"tabbar_discover"],
                             @[@"我",@"tabbar_profile"]];
    NSMutableArray *marr = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        UIViewController *viewController;
        if (i == 0) {
           viewController = [[UINavigationController alloc] initWithRootViewController:[HomeTimelineController new]];
        }else {
            viewController = [UINavigationController new];
        }
        viewController.tabBarItem.title = tabbarItems[i][0];
        NSString *imgName = tabbarItems[i][1];
        viewController.tabBarItem.image = [UIImage imageNamed:imgName];
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:[imgName stringByAppendingString:@"_selected"]];
        [marr addObject:viewController];
    }
    
    self.viewControllers = [marr copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
