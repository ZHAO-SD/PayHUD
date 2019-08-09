







#import "SDPaymentResultHUD.h"

static CGFloat lineWidth = 4.0f;
static CGFloat circleDuriation = 0.5f;
static CGFloat checkDuration = 0.2f;

#define BlueColor [UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1]

@implementation SDPaymentResultHUD {
    CALayer *_animationLayer;
}

//显示
+(SDPaymentResultHUD *)showSuccessIn:(UIView*)view{
    [self hideIn:view];
    SDPaymentResultHUD *hud = [[SDPaymentResultHUD alloc] initWithFrame:view.bounds];
    [hud startWithResult:YES];
    [view addSubview:hud];
    return hud;
}
+(SDPaymentResultHUD *)showFailIn:(UIView*)view{
    [self hideIn:view];
    SDPaymentResultHUD *hud = [[SDPaymentResultHUD alloc] initWithFrame:view.bounds];
    [hud startWithResult:NO];
    [view addSubview:hud];
    return hud;
}


//隐藏
+ (SDPaymentResultHUD *)hideIn:(UIView *)view {
    SDPaymentResultHUD *hud = nil;
    for (SDPaymentResultHUD *subView in view.subviews) {
        if ([subView isKindOfClass:[SDPaymentResultHUD class]]) {
            [subView hide];
            [subView removeFromSuperview];
            hud = subView;
        }
    }
    return hud;
}

- (void)startWithResult:(BOOL)isSuccess {
    [self circleAnimation];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.8 * circleDuriation * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        if (isSuccess) {
            [self checkAnimation];
        }else{
            [self errorAnimation];
        }
        
        
    });
}

- (void)hide {
    for (CALayer *layer in _animationLayer.sublayers) {
        [layer removeAllAnimations];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    _animationLayer = [CALayer layer];
    _animationLayer.bounds = CGRectMake(0, 0, 60, 60);
    _animationLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [self.layer addSublayer:_animationLayer];
}

//画圆
- (void)circleAnimation {
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = _animationLayer.bounds;
    [_animationLayer addSublayer:circleLayer];
    circleLayer.fillColor =  [[UIColor clearColor] CGColor];
    circleLayer.strokeColor  = BlueColor.CGColor;
    circleLayer.lineWidth = lineWidth;
    circleLayer.lineCap = kCALineCapRound;
    
    
    CGFloat lineWidth = 5.0f;
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    circleLayer.path = path.CGPath;
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnimation.duration = circleDuriation;
    circleAnimation.fromValue = @(0.0f);
    circleAnimation.toValue = @(1.0f);
    circleAnimation.delegate = self;
    [circleAnimation setValue:@"circleAnimation" forKey:@"animationName"];
    [circleLayer addAnimation:circleAnimation forKey:nil];
}

//对号
- (void)checkAnimation {
    
    CGFloat a = _animationLayer.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(a*2.7/10,a*5.4/10)];
    [path addLineToPoint:CGPointMake(a*4.5/10,a*7/10)];
    [path addLineToPoint:CGPointMake(a*7.8/10,a*3.8/10)];
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = BlueColor.CGColor;
    checkLayer.lineWidth = lineWidth;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [_animationLayer addSublayer:checkLayer];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = checkDuration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}

//叉号
-(void)errorAnimation{
    CGFloat a = _animationLayer.bounds.size.width;
    
    //画左侧的线
    [self drawLineWithStartPoint:CGPointMake(a*2.8/10,a*2.8/10) endPoint:CGPointMake(a*7.4/10,a*7.4/10)];
    
    //左侧的线画完之后,再画右侧的线
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(checkDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //画右侧的线
        [self drawLineWithStartPoint:CGPointMake(a*7.4/10,a*2.8/10) endPoint:CGPointMake(a*2.8/10,a*7.4/10)];
    });
    
    
    
}

//抽取画叉号的方法,传入起点和终点
-(void)drawLineWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = BlueColor.CGColor;
    layer.lineWidth = lineWidth;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    [_animationLayer addSublayer:layer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.duration = checkDuration;
    basicAnimation.fromValue = @(0.0f);
    basicAnimation.toValue = @(1.0f);
    basicAnimation.delegate = self;
    [basicAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [layer addAnimation:basicAnimation forKey:nil];
 
}


@end
