//
//  LXSpiderView.m
//  pathDome
//
//  Created by Leexin on 16/8/12.
//  Copyright © 2016年 garden. All rights reserved.
//

#import "LXSpiderView.h"

static const CGFloat kCos36 = 0.80901699437495;//acos(M_PI / 180 * 36);
static const CGFloat kSin36 = 0.58778525229247;//asin(M_PI / 180 * 36);
static const CGFloat kCos18 = 0.95105651629515;//acos(M_PI / 180 * 18);
static const CGFloat kSin18 = 0.30901699437495;//asin(M_PI / 180 * 18);
static const CGFloat kLineWidth = 1.f;
static const NSInteger kLayerCount = 4;

@interface LXSpiderView ()

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGPoint centerPoint;

@property (nonatomic, strong) NSMutableArray *pointArray;
@property (nonatomic, strong) NSMutableArray *valuePointArray;

@end

@implementation LXSpiderView

- (instancetype)initWithFrame:(CGRect)frame radius:(CGFloat)radius {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.radius = radius;
        self.centerPoint = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        self.backgroundColor = [UIColor whiteColor];
        
        self.pointArray = [NSMutableArray arrayWithCapacity:5];
        self.valuePointArray = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}

- (void)resetPointsWithRadius:(CGFloat)radius storePointArray:(NSMutableArray *)array {
    
    NSArray *scaleArray = @[@1, @1, @1, @1, @1];
    [self resetPointsWithRadius:radius scale:scaleArray storePointArray:array];
}

- (void)resetPointsWithRadius:(CGFloat)radius scale:(NSArray *)scaleArray storePointArray:(NSMutableArray *)array {
    
    [array removeAllObjects];
    [array addObject:[NSValue valueWithCGPoint:CGPointMake(self.centerPoint.x,
                                                           self.centerPoint.y - [scaleArray[0] floatValue] * radius)]];
    
    [array addObject:[NSValue valueWithCGPoint:CGPointMake(self.centerPoint.x + kCos18 * [scaleArray[1] floatValue] * radius,
                                                           self.centerPoint.y - kSin18 * [scaleArray[1] floatValue] * radius)]];
    
    [array addObject:[NSValue valueWithCGPoint:CGPointMake(self.centerPoint.x + kSin36 * [scaleArray[2] floatValue] * radius,
                                                           self.centerPoint.y + kCos36 * [scaleArray[2] floatValue] * radius)]];
    
    [array addObject:[NSValue valueWithCGPoint:CGPointMake(self.centerPoint.x - kSin36 * [scaleArray[3] floatValue] * radius,
                                                           self.centerPoint.y + kCos36 * [scaleArray[3] floatValue]* radius)]];
    
    [array addObject:[NSValue valueWithCGPoint:CGPointMake(self.centerPoint.x - kCos18 * [scaleArray[4] floatValue]* radius,
                                                           self.centerPoint.y - kSin18 * [scaleArray[4] floatValue]* radius)]];
}

#pragma mark - Draw Method

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawValueLineWithContext:context];
    [self drawPentagonWithContext:context];
}

- (void)drawPentagonWithContext:(CGContextRef)context { // 画五边形
    
    for (int i = 0 ;i < kLayerCount; i++) {
        CGFloat tempRadius = self.radius - (i * self.radius / kLayerCount);
        [self resetPointsWithRadius:tempRadius storePointArray:self.pointArray];
        CGContextMoveToPoint(context,
                             [self.pointArray[LXSpiderPointPositionTopMid] CGPointValue].x,
                             [self.pointArray[LXSpiderPointPositionTopMid] CGPointValue].y);
        [self drawLineToPoints:self.pointArray context:context isFromCenterPoint:NO];
        CGContextClosePath(context);
    }
    
    [self drawInsideCutLineWithContext:context];
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, kLineWidth);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)drawValueLineWithContext:(CGContextRef)context { // 画值区域
    
    CGContextSaveGState(context);
    if (self.valueArray == nil || self.valueArray.count == 0) {
        return;
    }
    [self resetPointsWithRadius:self.radius scale:self.valueArray storePointArray:self.valuePointArray];
    CGContextMoveToPoint(context,
                         [self.valuePointArray[LXSpiderPointPositionTopMid] CGPointValue].x,
                         [self.valuePointArray[LXSpiderPointPositionTopMid] CGPointValue].y);
    [self drawLineToPoints:self.valuePointArray context:context isFromCenterPoint:NO];
    CGContextClosePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextSetLineWidth(context, kLineWidth);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextRestoreGState(context);
}

- (void)drawInsideCutLineWithContext:(CGContextRef)context { // 画五根内部分割线
    
    [self resetPointsWithRadius:self.radius storePointArray:self.pointArray];
    [self drawLineToPoints:self.pointArray context:context isFromCenterPoint:YES];
}

- (void)drawLineToPoints:(NSArray *)pointArray context:(CGContextRef)context isFromCenterPoint:(BOOL)isFromCenterPoint { // 连线至多个点
    
    for (id pointObj in pointArray) {
        CGPoint point = [pointObj CGPointValue];
        if (isFromCenterPoint) {
            [self drawLineFromCenterToPoint:point context:context];
        } else {
            CGContextAddLineToPoint(context, point.x, point.y);
        }
    }
}

- (void)drawLineFromCenterToPoint:(CGPoint)point context:(CGContextRef)context { // 从中心点连线至指定点
    
    CGContextMoveToPoint(context, self.centerPoint.x, self.centerPoint.y);
    CGContextAddLineToPoint(context, point.x, point.y);
}

@end
