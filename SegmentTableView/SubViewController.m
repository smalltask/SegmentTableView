//
//  SubViewController.m
//  SegmentTableView
//
//  Created by 9tong on 2018/12/18.
//  Copyright © 2018 9tong. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    self.myTableView.frame = self.view.bounds;
}


- (UITableView *)myTableView {
    if(!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.alwaysBounceVertical = YES;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
        _myTableView.tableFooterView = [UIView new];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell.contentView.backgroundColor = [UIColor yellowColor];
    cell.textLabel.text = @"这是 子视图 的cell";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollViewDelegate scrollViewDidScroll:scrollView];
    }
}

@end
