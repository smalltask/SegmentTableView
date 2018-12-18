//
//  FPSlidPageCell.h
//  tranb
//
//  Created by zhang yin on 2018/11/29.
//  Copyright © 2018 cmf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NinaPagerView.h"


NS_ASSUME_NONNULL_BEGIN

@protocol FPSlidPageCellDelegate <NSObject>


- (void)ninaCurrentPageIndex:(NSString *)currentPage;

@end

#pragma mark -

@interface FPSlidPageCell : UITableViewCell <NinaPagerViewDelegate,UIScrollViewDelegate> {

}


@property (nonatomic, assign) NSInteger sectionIndexOfSlidCell;
@property (nonatomic, strong) NinaPagerView *sliderView;
@property (nonatomic, strong) UIViewController *rootVC;
@property (nonatomic, strong) UITableView *rootTableView;

@property (nonatomic, weak) id<FPSlidPageCellDelegate> slidPageCellDelegate;

#pragma mark - UIScrollView

- (void)rootScrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)rootScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)rootScrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;


@end

NS_ASSUME_NONNULL_END
