//
//  FSBaseTableView.h
//  tranb
//
//  Created by zhang yin on 2018/12/11.
//  Copyright © 2018 cmf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 外层主tableView的基类；
 继承UIGestureRecognizerDelegate协议并实现gestureRecognizer接口，
 用于在滚动内层子tableView的同时，也同时触发主tableView的scrollViewDidScroll:事件
 */
@interface FSBaseTableView : UITableView<UIGestureRecognizerDelegate>

@end

NS_ASSUME_NONNULL_END
