//
//  FPSlidPageCell.m
//  tranb
//
//  Created by zhang yin on 2018/11/29.
//  Copyright © 2018 cmf. All rights reserved.
//

#import "FPSlidPageCell.h"
#import "SubViewController.h"


@interface FPSlidPageCell() {
    BOOL rootTableCanScroll;
    BOOL subTableCanScroll;
    UIScrollView *currentSubScrollView;
}

@property (nonatomic, strong) NSMutableArray<UIViewController *> *pageVCArray;

@end

@implementation FPSlidPageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView addSubview:self.sliderView];
    rootTableCanScroll = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 分页控件可以随便换，直接用 UIScrollView也可以
 */
- (NinaPagerView *)sliderView {
    if (!_sliderView) {
        NSInteger pageIndex = 0;
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        
        NSMutableArray *categoryTitleArray = [NSMutableArray new];
        NSMutableArray *categoryVCArray = [NSMutableArray new];

        
        [categoryTitleArray addObject:@"tab1"];
        SubViewController *vc0 = [SubViewController new];
        vc0.scrollViewDelegate = self;
        [categoryVCArray addObject:vc0];
        
        [categoryTitleArray addObject:@"tab2"];
        SubViewController *vc1 = [[SubViewController alloc] init];
        vc1.scrollViewDelegate = self;
        [categoryVCArray addObject:vc1];
        
        [categoryTitleArray addObject:@"tab3"];
        SubViewController *vc2 = [[SubViewController alloc] init];
        vc2.scrollViewDelegate = self;
        [categoryVCArray addObject:vc2];
        
        [categoryTitleArray addObject:@"tab3"];
        SubViewController *vc3 = [[SubViewController alloc] init];
        vc3.scrollViewDelegate = self;
        [categoryVCArray addObject:vc3];
        
        
        
        
        _pageVCArray = categoryVCArray;
        
        _sliderView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, 0, width, height) WithTitles:categoryTitleArray WithVCs:categoryVCArray];
        _sliderView.ninaPagerStyles = NinaPagerStyleBottomLine;
        _sliderView.delegate = self;
        _sliderView.hideTabbar = YES;//不要用控件的顶部tab，而是用在sectionHeader中自己设置的顶部tab
        [_sliderView setNinaDefaultPage:pageIndex];
    }
    return _sliderView;
}

#pragma mark - NinaPagerViewDelegate
- (BOOL)deallocVCsIfUnnecessary {
    return YES;
}

- (void)ninaCurrentPageIndex:(NSString *)currentPage {
    [self.slidPageCellDelegate ninaCurrentPageIndex:currentPage];
}

//#pragma mark - 父级的tableview的滚动
- (void)rootScrollViewWillBeginDragging:(UIScrollView *)scrollView {
    subTableCanScroll = NO;
}

- (void)rootScrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    subTableCanScroll = YES;
}

- (void)rootScrollViewDidScroll:(UIScrollView *)scrollView {
    //当前偏移量
    CGFloat currentOffsetY  = scrollView.contentOffset.y;
    //临界点偏移量，计算临界偏移量，超过这个值，slidpage的将向上偏移出视界；
//    CGFloat height = HEIGHT_VIEW - HEIGHT_TABBAR;
    CGRect slidPageRect = [self.rootTableView rectForSection:self.sectionIndexOfSlidCell];//另外一种计算临界值的方法
    CGFloat criticalPointOffsetY = scrollView.contentSize.height - slidPageRect.size.height;
    //解决scrollView嵌套手势冲突问题
    if (currentOffsetY >= criticalPointOffsetY) {
        
        //子table 自动再往上走一点，模拟减速阻尼的效果；
        CGPoint offset = currentSubScrollView.contentOffset;
        CGFloat damping = 1.5;//减速阻尼，值越大，减速效果越明显
        offset.y += (currentOffsetY - criticalPointOffsetY)/damping;
        currentSubScrollView.contentOffset = offset;
        
        //让主tableView的segment卡在顶部，并且保持偏移量的临界值，让子table去动；
        scrollView.contentOffset = CGPointMake(0, criticalPointOffsetY);
        subTableCanScroll = YES;
        rootTableCanScroll = NO;
    } else {
        if (!rootTableCanScroll) {
            scrollView.contentOffset = CGPointMake(0, criticalPointOffsetY);
        }
    }
}

/**
 检查sectionHeader view中的segmentbar是否已经卡在可见界面中的顶部位置；
 @return 如果是：返回YES,否则返回NO;
 */
- (BOOL)checkIfSegmentPinOnTop {
    CGFloat segmentHeight = 40;//注意！！！！这个值和外层主tableView中的sectionHeader的高度耦合;
    CGPoint cp = [self convertPoint:CGPointMake(0, 0) toView:self.rootVC.view];//计算当前cell在可见视界中的坐标；cell和sectionheader是不重叠的
    if(cp.y - segmentHeight > FLT_EPSILON) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     if(!subTableCanScroll || ![self checkIfSegmentPinOnTop]){
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY <= 0) {
        rootTableCanScroll = YES;
    }
    currentSubScrollView = scrollView;
}



@end
