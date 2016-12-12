//
//  LoadingView.m
//  Animation
//
//  Created by Li Nan on 16/12/5.
//  Copyright © 2016年 nancy. All rights reserved.
//

#import "LoadingView.h"
#define  pi 3.14159265359
#define  DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface LoadingView()<CAAnimationDelegate>
{
    CAShapeLayer *bigCircleLayer;
    CAShapeLayer *smallCircleLayer;
}

@end
@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIBezierPath* bigCircle = [self generateCircleLayerX:45 withY:45 withRadius:90 withStartAngle:DEGREES_TO_RADIANS(-45) endAngle:DEGREES_TO_RADIANS(135) isWise:false];
         bigCircleLayer = [self generateLayer:bigCircle withRadius:45 lineWidth:10];
        
        
         UIBezierPath *smallCircle = [self generateCircleLayerX:38 withY:38 withRadius:76 withStartAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180) isWise:true];
        smallCircleLayer = [self generateLayer:smallCircle withRadius:38 lineWidth:5];
        
        [self.layer addSublayer:bigCircleLayer];
        [self.layer addSublayer:smallCircleLayer];
        [self animationBegin];
        
        //[self performSelector:@selector(dismissAnimation) withObject:self afterDelay:2.0];
    }
    return self;
}

-(void)dismissAnimation{
  //  CABasicAnimation *animation = [self createRotateAnimation:YES];
    
 //   CABasicAnimation *animation2 = [self createRotateAnimation:false];
   // [bigCircleLayer addAnimation:animation2 forKey:@"rotation"];
  //  [smallCircleLayer addAnimation:animation forKey:@"rotation"];
}
- (UIBezierPath *)generateCircleLayerX:(int)x withY:(int)y withRadius:(int)r withStartAngle:(float)startAngle endAngle:(float)endAngle isWise:(BOOL)isWise{
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x,y)
                                                        radius:r
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:isWise];
    
    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [path stroke];
    
    return path;
}
-(CAShapeLayer *)generateLayer:(UIBezierPath *)path withRadius:(int)r lineWidth:(float)width{
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    shape.lineWidth = width;
    shape.fillColor = [UIColor whiteColor].CGColor;
    shape.strokeColor = [UIColor lightGrayColor].CGColor;
    shape.frame = CGRectMake(self.center.x-r, self.center.y-r, r*2, r*2);
    shape.strokeStart = 0;
    shape.strokeEnd =1;
    return shape;
}

-(void)animationBegin{
    CAKeyframeAnimation *animation = [self createRotateAnimation:false];
    
    CAKeyframeAnimation *animation2 = [self createRotateAnimation:false];
    [bigCircleLayer addAnimation:animation forKey:nil];

}
float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/11.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

float interpolate(float from, float to, float time)
{
    
    return (to - from) * time+ from;
}
- (NSNumber *)interpolateFromValue:(float)fromValue toValue:(float)toValue time:(float)time
{
    float result = interpolate(fromValue, toValue, time);
    
    NSNumber *num = [NSNumber numberWithFloat:result];
    return num;
}
-(CAKeyframeAnimation *)createRotateAnimation:(BOOL)isReverse{
   
    float fromValue = 0;
    float toValue = -M_PI_4;
   
    CFTimeInterval duration = 8.0;
    //generate keyframes
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        
        float time = 1/(float)numFrames * i;
        //apply easing
        if (time <4/11.0) {
            toValue = -M_PI_4*6/5.0;
        }
        else if(time <8/11.0){
            toValue = -M_PI_4*4/5.0;
        }
        else if (time<9/11.0)
        {
            toValue = -M_PI_4*5.8/5.0;
        }
        else{
            toValue=-M_PI_4;
        }
        
        time = bounceEaseOut(time);
        
        
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
    
    CAKeyframeAnimation* animation3;
    animation3 = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
  //  animation3.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0.8 :0.5 :1];
    animation3.duration = 8;
    animation3.repeatCount = 1;
    animation3.removedOnCompletion = NO;
    animation3.fillMode = kCAFillModeForwards;
    
    /*animation3.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:0],
                        [NSNumber numberWithFloat:-(60/45) * M_PI_4],
                         [NSNumber numberWithFloat:-(30/45) * M_PI_4],
                         [NSNumber numberWithFloat:-(50/45) * M_PI_4],
                         [NSNumber numberWithFloat:-(15/45) * M_PI_4],
                        [NSNumber numberWithFloat:-M_PI_4],
                         nil]
    animation3.timingFunctions = @[
                                   [CAMediaTimingFunction functionWithControlPoints:1 :0.5 :0.8 :1],
                                   [CAMediaTimingFunction functionWithControlPoints:1 :0.8 :0.5 :1],
                                  [CAMediaTimingFunction functionWithControlPoints:1 :0.5 :0.8 :1],
                                  [CAMediaTimingFunction functionWithControlPoints:1 :0.8 :0.5 :1],
                                  [CAMediaTimingFunction functionWithControlPoints:1 :0.5 :0.8 :1]
                                  ];
    
    animation3.keyTimes = @[@0.0, @0.3, @0.55, @0.75, @0.9, @1.0];*/
    animation3.values = frames;
  /*  CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animation,animation2, nil];
    group.duration =2;
    group.delegate = self;
    return animation3;*/
   // return  animation;
    return  animation3;
}

-(void)swingAnimation{
   
    CABasicAnimation *strokeEndAnimation = nil;
    strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = 1;
    strokeEndAnimation.fromValue = @(bigCircleLayer.strokeEnd);
    strokeEndAnimation.toValue = @(1.3f);
    strokeEndAnimation.autoreverses = NO;
    strokeEndAnimation.repeatCount = 0.f;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.delegate = self;
    //[bigCircleLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
    
    CABasicAnimation *strokeStartAnimation = nil;
    strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.duration = 1;
    strokeStartAnimation.fromValue = @(bigCircleLayer.strokeStart);
    strokeStartAnimation.toValue = @(0.3f);
    strokeStartAnimation.autoreverses = NO;
    strokeStartAnimation.repeatCount = 0.f;
    strokeStartAnimation.fillMode = kCAFillModeForwards;
    strokeStartAnimation.removedOnCompletion = NO;
    strokeStartAnimation.delegate = self;
    
   // CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    //animationGroup.animations = [NSArray arrayWithObjects:strokeEndAnimation,strokeStartAnimation,nil];
    [bigCircleLayer addAnimation:strokeStartAnimation forKey:@"strokeStartAnimation"];
    [bigCircleLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
    
    
}

@end
