//
//  HomeTimelineController.m
//  iOSExample
//
//  Created by vmpc on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "HomeTimelineController.h"
#import "WeiboViewModel.h"

@interface HomeTimelineController ()

@property (nonatomic, retain) WeiboViewModel *viewModel;

@end

@implementation HomeTimelineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",NSHomeDirectory());
    
    self.title = @"消息";
    self.view.backgroundColor = [UIColor whiteColor];

    _viewModel = [WeiboViewModel new];
    
    if([_viewModel ssoAuthorizeRequest]) {
        [_viewModel requestHomeTimeline:^{
            
        }];
    }
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
