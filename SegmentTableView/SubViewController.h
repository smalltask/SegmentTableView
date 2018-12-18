//
//  SubViewController.h
//  SegmentTableView
//
//  Created by 9tong on 2018/12/18.
//  Copyright © 2018 9tong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubViewController : UIViewController

/**
 将scrollview的运动状态传递出去，用于父亲界面进行绘制控制
 */
@property (nonatomic,weak) id<UIScrollViewDelegate> scrollViewDelegate;

@end

NS_ASSUME_NONNULL_END
