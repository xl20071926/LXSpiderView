//
//  LXValuePopView.m
//  LXSpiderView
//
//  Created by Leexin on 16/8/16.
//  Copyright © 2016年 Garden.Lee. All rights reserved.
//

#import "LXValuePopView.h"

static const CGFloat kRainDropHeight = 20.f;

@interface LXValuePopView ()

@property (nonatomic, assign) CGPoint topPoint;
@property (nonatomic, assign) CGPoint bottomPoint;

@end

@implementation LXValuePopView

- (instancetype)initWithStarePoint:(CGPoint)starePoint {
    
    self = [super initWithFrame:CGRectMake(starePoint.x - kRainDropHeight / 2, starePoint.y - kRainDropHeight, kRainDropHeight, kRainDropHeight)];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenPopView)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark - Public Method

- (void)showInView:(UIView *)view titleString:(NSString *)string {
    
    [self addPopViewLayer];
    [view addSubview:self];
    [self addTitleLabelWithTitleString:string];
}

- (void)hiddenPopView {
    
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(valuePopViewDidHidden:)]) {
        [self.delegate valuePopViewDidHidden:self];
    }
}

#pragma mark - Private Method

- (CGPathRef)getRainDropPath {

    self.topPoint = CGPointMake(kRainDropHeight / 2, 5);
    self.bottomPoint = CGPointMake(kRainDropHeight / 2, kRainDropHeight);
    CGPoint leftPoint1 = CGPointMake(self.topPoint.x - kRainDropHeight / 2, self.topPoint.y);
    CGPoint leftPoint2 = CGPointMake(self.topPoint.x - kRainDropHeight / 2, self.topPoint.y + kRainDropHeight / 2);
    CGPoint righttPoint1 = CGPointMake(self.topPoint.x + kRainDropHeight / 2,leftPoint1.y);
    CGPoint righttPoint2 = CGPointMake(self.topPoint.x + kRainDropHeight / 2, leftPoint2.y);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.topPoint];
    [path addCurveToPoint:self.bottomPoint controlPoint1:leftPoint1 controlPoint2:leftPoint2];
    [path moveToPoint:self.bottomPoint];
    [path addCurveToPoint:self.topPoint controlPoint1:righttPoint2 controlPoint2:righttPoint1];
    [path closePath];
    
    return path.CGPath;
}

- (void)addPopViewLayer {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = [self getRainDropPath];
    [shapeLayer setFillColor:[UIColor redColor].CGColor];
    shapeLayer.fillMode = kCAFillModeBoth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapButt;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)addTitleLabelWithTitleString:(NSString *)title {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2.f, kRainDropHeight, kRainDropHeight)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:8.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:titleLabel];
}



@end
