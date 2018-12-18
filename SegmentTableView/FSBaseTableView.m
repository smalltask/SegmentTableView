//
//  FSBaseTableView.m
//  tranb
//
//  Created by zhang yin on 2018/12/11.
//  Copyright © 2018 cmf. All rights reserved.
//

#import "FSBaseTableView.h"

@implementation FSBaseTableView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
