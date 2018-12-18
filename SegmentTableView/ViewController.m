//
//  ViewController.m
//  SegmentTableView
//
//  Created by 9tong on 2018/12/17.
//  Copyright © 2018 9tong. All rights reserved.
//

#import "ViewController.h"
#import "FSBaseTableView.h"
#import "HMSegmentedControl.h"
#import "FPSlidPageCell.h"

#define kSlidPageCell              @"kSlidPageCell"

#define WIDTH_SCREEN         [[UIScreen mainScreen] bounds].size.width      //屏幕宽度
#define HEIGHT_SCREEN        [[UIScreen mainScreen] bounds].size.height     //屏幕高度

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,FPSlidPageCellDelegate>

@property (nonatomic, strong) FSBaseTableView *myTableView;
@property (nonatomic,strong) HMSegmentedControl *segmentControl;
@property (nonatomic,strong) FPSlidPageCell *slidPageCellRef;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    self.myTableView.frame = self.view.bounds;
    [self.myTableView reloadData];
}

- (HMSegmentedControl *)segmentControl {
    if(!_segmentControl) {
        CGFloat height = 40;
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"tab1",@"tab2",@"tab3",@"tab4"]];
        _segmentControl.frame = CGRectMake(0, 0, WIDTH_SCREEN, height);
        _segmentControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                                NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]};
        _segmentControl.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                                        NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]};
        _segmentControl.borderType = HMSegmentedControlBorderTypeBottom;
        _segmentControl.borderColor = [UIColor whiteColor];
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.selectionIndicatorColor = [UIColor darkGrayColor];
        _segmentControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -20, 0, -40);
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.selectionIndicatorHeight = 2;
        _segmentControl.tintColor = [UIColor darkGrayColor];
        
    }
    return _segmentControl;
}

- (FSBaseTableView *)myTableView {
    if(!_myTableView) {
        _myTableView = [[FSBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //        UIColor *bgColor = kColorWithHex(0xf4f4f4);
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"FPSlidPageCell" bundle:nil] forCellReuseIdentifier:kSlidPageCell];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.bounces = YES;
        _myTableView.alwaysBounceVertical = YES;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.tableFooterView = [UIView new];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}

#pragma mark - UITableViewDataSource , UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1){
        return 1;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1){
        return 40;
    }else{
        return 0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 1){
        UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 40)];
        uv.backgroundColor = [UIColor whiteColor];
        [uv addSubview:self.segmentControl];
        __weak typeof (self) weakSelf = self;
        _segmentControl.indexChangeBlock = ^(NSInteger index) {
            [weakSelf.slidPageCellRef.sliderView selectPageIndex:index];
        };
        return uv;
    }else{
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     if(indexPath.section == 1){
         return HEIGHT_SCREEN - 40;
     }else{
         return 100;
     }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        FPSlidPageCell *cell = [tableView dequeueReusableCellWithIdentifier:kSlidPageCell];
        cell.rootVC = self;
        cell.sectionIndexOfSlidCell = indexPath.section;
        cell.rootTableView = tableView;
        cell.slidPageCellDelegate = self;
        self.slidPageCellRef = cell;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
        cell.textLabel.text = @"这是主视图的cell";
        return cell;
    }
}

#pragma mark - UIScrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if([self.slidPageCellRef respondsToSelector:@selector(rootScrollViewWillBeginDragging:)]) {
        [self.slidPageCellRef rootScrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if([self.slidPageCellRef respondsToSelector:@selector(rootScrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.slidPageCellRef rootScrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if([self.slidPageCellRef respondsToSelector:@selector(rootScrollViewDidScroll:)]) {
        [self.slidPageCellRef rootScrollViewDidScroll:scrollView];
    }
}

#pragma mark - FPSlidPageCellDelegate

- (void)ninaCurrentPageIndex:(NSString *)currentPage {
    [self.segmentControl setSelectedSegmentIndex:currentPage.integerValue];
}


@end
