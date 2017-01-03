//
//  HomeTimelineController.m
//  iOSExample
//
//  Created by vmpc on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "HomeTimelineController.h"
#import "WeiboViewModel.h"
#import "WeiboContentCell.h"
#import "LoadingView.h"

@interface HomeTimelineController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) WeiboViewModel *viewModel;
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation HomeTimelineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",NSHomeDirectory());
    
    
    self.title = @"消息";
    
    _viewModel = [WeiboViewModel new];
    [self.view addSubview:self.tableView];
    
    [self fetchData:FetchDataTypeFirst];
}

- (void)showLoading {
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:CGRectMake((self.view.width-50)/2, (self.view.height-49-50)/2, 50, 50)];
    loadingView.tag = 1000;
    [self.view addSubview:loadingView];
    self.tableView.hidden = YES;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        loadingView.progress += 0.1;
        if (loadingView.progress >= 1.0) {
            [timer invalidate];
            [self hideLoading];
        }
    }];
    [timer fire];
}

- (void)hideLoading {
    _tableView.backgroundColor = [UIColor whiteColor];
    LoadingView *loadView = [self.view viewWithTag:1000];
    loadView.hidden = YES;
    self.tableView.hidden = NO;
    [self.tableView reloadData];
}

- (void)fetchData:(FetchDataType)fetchType {
    weak(self);
    
    if (fetchType == FetchDataTypeFirst) {
        [self showLoading];
    }
    
    if([_viewModel ssoAuthorizeRequest]) {
        [_viewModel requestHomeTimeline:^{
            [ws fetchDataFinished:fetchType];
        }];
    }
}

- (void)fetchDataFinished:(FetchDataType)fetchType {
    //[self performSelectorOnMainThread:@selector(hideLoading) withObject:nil waitUntilDone:NO];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRed:51 green:51 blue:51 alpha:0.3];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weiboCell"];
    if (cell == nil) {
        cell = [[WeiboContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"weiboCell"];
    }
    cell.statuse = _viewModel.statuses[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
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
