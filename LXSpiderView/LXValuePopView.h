//
//  LXValuePopView.h
//  LXSpiderView
//
//  Created by Leexin on 16/8/16.
//  Copyright © 2016年 Garden.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXValuePopView;
@protocol LXValuePopViewDelegate <NSObject>
@optional
- (void)valuePopViewDidHidden:(LXValuePopView *)popView;

@end

@interface LXValuePopView : UIView

@property (nonatomic, weak) id<LXValuePopViewDelegate> delegate;

- (instancetype)initWithStarePoint:(CGPoint)starePoint;
- (void)showInView:(UIView *)view titleString:(NSString *)string;
- (void)hiddenPopView;

@end
