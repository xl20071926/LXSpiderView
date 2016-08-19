//
//  LXSpiderView.h
//  pathDome
//
//  Created by Leexin on 16/8/12.
//  Copyright © 2016年 garden. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, LXSpiderPointPosition) { // 顶点位置
    LXSpiderPointPositionTopMid = 0, // 上中
    LXSpiderPointPositionTopRight, // 上右
    LXSpiderPointPositionBottomRight, // 下右
    LXSpiderPointPositionBottomLeft, // 下左
    LXSpiderPointPositionTopLeft, // 上左
};

@interface LXSpiderView : UIView

@property (nonatomic, strong) NSArray *valueArray;
@property (nonatomic, strong) NSArray *titleArray;

- (instancetype)initWithFrame:(CGRect)frame radius:(CGFloat)radius;

@end
