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
#import "MWPhotoBrowser.h"

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
    
    self.view.backgroundColor = HEXCOLOR(0xf2f2f2);
    _viewModel = [WeiboViewModel new];
    [self.view addSubview:self.tableView];
    
    [self fetchData:FetchDataTypeFirst];
}

- (void)showLoading {
    self.tableView.hidden = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
}

- (void)hideLoading {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tableView.hidden = NO;
    [self.tableView reloadData];
    
    /*NSMutableArray *marr = [NSMutableArray array];
    [_viewModel.statuses enumerateObjectsUsingBlock:^(StatuseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.original_pic) {
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:obj.original_pic]];
            [marr addObject:photo];
        }
    }];
    
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:marr];
    [self.navigationController pushViewController:photoBrowser animated:YES];*/
}

- (void)fetchData:(FetchDataType)fetchType {
    weak(self);
    
    if (fetchType == FetchDataTypeFirst) {
        [self showLoading];
    }
    
    if([_viewModel ssoAuthorizeRequest]) {
        [_viewModel requestFriendsTimeline:^{
            [ws fetchDataFinished:fetchType];
        }];
    }
}

- (void)fetchDataFinished:(FetchDataType)fetchType {
    [self performSelectorOnMainThread:@selector(hideLoading) withObject:nil waitUntilDone:NO];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _viewModel.statuses.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weiboCell"];
    if (cell == nil) {
        cell = [[WeiboContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"weiboCell"];
    }
    cell.statuse = _viewModel.statuses[indexPath.section];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kInsets)];
    headerView.backgroundColor = self.view.backgroundColor;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WeiboContentCell getCellHeithWithObject:_viewModel.statuses[indexPath.section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kInsets;
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
