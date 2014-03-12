#import "AnimationController.h"

#import "UIView+Origami.h"

#import "UIView+Genie.h"

#import "CEGuideArrow.h"

#import "SKBounceAnimation.h"

#import "SCWaveAnimationView.h"

#import "DrawTextView.h"

#import "Globals.h"

#define X_SIDE                  20.0

#define Y_SIDE                  20.0

#define FALL_HEIGHT             200.0

#define X_SPACING               30.0

KeyframeParametricBlock openFunction1 = ^double(double time)
{
    return sin(time*M_PI_2);
};

KeyframeParametricBlock closeFunction1 = ^double(double time)
{
    return -cos(time*M_PI_2)+1;
};

@interface AnimationController ()

@end

@implementation AnimationController

@synthesize animationType = _animationType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (_animationType == animate_arrowmove)
        [[CEGuideArrow sharedGuideArrow] removeAnimated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(animatePressed)];
    
    if (_animationType == animate_wave)
        return;
        
    animateView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2) - 100.0, (self.view.frame.size.height/2) - 100.0, 200.0, 200.0)];
    
    animateView.backgroundColor = [UIColor brownColor];
        
    animateView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    animateView.layer.borderWidth = 2.0;
    
    animateView.hidden = (_animationType == animate_fold);
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [animateView addGestureRecognizer:pan];
    
    pan = nil;
    
    [self.view addSubview:animateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)animatePressed
{
    switch (_animationType)
    {
        case animate_shake:
        {            
            [Animation animateShakeView:animateView numberOfShakes:3 duration:0.2 distance:-10.0];

            break;
        }
        case animate_zoominout:
        {
            CABasicAnimation * zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            
            zoomOut.toValue = [NSNumber numberWithDouble:0.0];
                        
            zoomOut.delegate = self;
            
            CABasicAnimation * zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            
            zoomIn.toValue = [NSNumber numberWithDouble:1.0];
            
            zoomIn.delegate = self;
            
            CAAnimationGroup * anim = [CAAnimationGroup animation];
            
            [anim setAnimations:[NSArray arrayWithObjects:zoomOut, zoomIn, nil]];
            
            [anim setDuration:1.0];
            
            anim.repeatCount = 10000;
            
            [anim setRemovedOnCompletion:NO];
            
            [anim setFillMode:kCAFillModeForwards];
            
            [[animateView layer] addAnimation:anim forKey:nil];
            
//            CGMutablePathRef thePath = CGPathCreateMutable();
//            
//            CGPathMoveToPoint(thePath,NULL,0.0,0.0);
//
//            CGPathAddCurveToPoint(thePath,NULL,100.0,100.0,
//                                  100.0,200.0,
//                                  200.0,300.0);
//            
//            CGPathAddCurveToPoint(thePath,NULL,300.0,200.0,
//                                  200.0,100.0,
//                                  100.0,100.0);
//            
//            CAKeyframeAnimation * theAnimation;
//            
//            // create the animation object, specifying the position property as the key path
//            // the key path is relative to the target animation object (in this case a CALayer)
//            theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//            theAnimation.path=thePath;
//            
//            // set the duration to 5.0 seconds
//            theAnimation.duration=1.0;
//            
//            
//            // release the path
//            CFRelease(thePath);
            
//            CABasicAnimation *theAnimation;
//            
//            // create the animation object, specifying the position property as the key path
//            // the key path is relative to the target animation object (in this case a CALayer)
//            theAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
//            
//            // set the fromValue and toValue to the appropriate points
//            theAnimation.fromValue=[NSValue valueWithCGPoint:CGPointMake (0.0,0.0)];
//            
//            theAnimation.toValue=[NSValue valueWithCGPoint:CGPointMake(200.0,400.0)];
//            
//            // set the duration to 3.0 seconds
//            theAnimation.duration=3.0;
//            
//            // set a custom timing function
//            theAnimation.timingFunction=[CAMediaTimingFunction functionWithControlPoints:0.25f :0.1f :0.25f :1.0f];

//            CATransition * transition = [CATransition animation];
//                        
//            transition.type = @"rippleEffect";
//            
//            transition.duration = 1.0f;
//            
//            transition.timingFunction = UIViewAnimationCurveEaseInOut;
//                        
//            [[animateView layer] addAnimation:transition forKey:@"shrink"];

//            CAAnimationGroup * anim = [CAAnimationGroup animation];
//            
//            [anim setAnimations:[NSArray arrayWithObjects:[self transparencyAnimation], [self translateAnimation], nil]];
//            
//            [anim setDuration:3.0];
//            
//            [anim setRemovedOnCompletion:NO];
//            
//            [anim setFillMode:kCAFillModeForwards];
//            
//            [[animateView layer] addAnimation:anim forKey:nil];
            
            break;
        }
        case animate_roate:
        {
//            CABasicAnimation *theAnimation;
//            
//            theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//            
//            theAnimation.duration=0.1;
//            
//            theAnimation.repeatCount = 1;
//            
//            theAnimation.autoreverses=YES;
//            
//            theAnimation.fromValue=[NSNumber numberWithFloat:0];
//            
//            theAnimation.toValue=[NSNumber numberWithFloat:M_PI/3];
//            
//            [[animateView layer] addAnimation:theAnimation forKey:@"rotateLayer"];
            
            [Animation animateRotateView:animateView numberOfRotation:10 duration:1.0 transform:CATransform3DMakeRotation (radians(180), 0.2, 0.2, 0.2)];

//            break;
//            
//            CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//            
//            CATransform3D transform = CATransform3DMakeRotation (radians(180), 0.2, 0.2, 0.2);
//            
//            animation.toValue = [NSValue valueWithCATransform3D:transform];
//            
//            animation.duration = 1.0;
//                        
//            animation.cumulative = YES;
//            
//            animation.repeatCount = 10000;
//            
//            animation.removedOnCompletion = YES;
//            
//            [[animateView layer] addAnimation:animation forKey:@"rotateLayer"];
            
            break;
        }
        case animate_fold:
        {
            if (!folded)
                [self foldView:animateView numberOfFolds:2 duration:0.5 direction:fold_top];
            else
                [self unFoldView:animateView numberOfFolds:2 duration:0.5 direction:fold_top];
            
            folded = !folded;
            
            break;
        }
        case animate_ripple:
        {
            CATransition * transition = [CATransition animation];
            
            transition.type = @"rippleEffect";
            
            transition.duration = 1.0f;
            
            transition.timingFunction = UIViewAnimationCurveEaseInOut;
            
            [[animateView layer] addAnimation:transition forKey:@"rippleEffect"];
            
            break;
        }
        case animate_grid:
        {
            [self grigView:animateView numberOfPieces:5 duration:1.0];
            
            break;
        }
        case animate_break:
        {
            [self breakView:animateView numberOfPieces:10 duration:5.0];
            
            break;
        }
        case animate_reflect:
        {
            CALayer *reflectionLayer = [CALayer layer];
            
            reflectionLayer.backgroundColor = animateView.layer.backgroundColor;
            
            reflectionLayer.bounds = animateView.layer.bounds;
            
            reflectionLayer.position = CGPointMake(animateView.layer.position.x, animateView.layer.position.y + 220.0);
            
            reflectionLayer.borderColor = animateView.layer.borderColor;
            
            reflectionLayer.borderWidth = animateView.layer.borderWidth;
            
            reflectionLayer.opacity = 0.5;
            
            [reflectionLayer setValue:[NSNumber numberWithFloat:radians(180)] forKeyPath:@"transform.rotation.x"];
            
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            
            gradientLayer.bounds = reflectionLayer.bounds;
            
            gradientLayer.position = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.65);
            
            gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor],(id)[[UIColor whiteColor] CGColor], nil];
            
            gradientLayer.startPoint = CGPointMake(0.5, 0.5);
            
            gradientLayer.endPoint = CGPointMake(0.5, 1.0);
            
            reflectionLayer.mask = gradientLayer;
            
            [self.view.layer addSublayer:reflectionLayer];
            
            break;
        }
        case animate_genieeffect:
        {            
            [self genieToRect:CGRectMake(290.0, -20.0, 20.0, 20.0) edge:BCRectEdgeBottom duration:0.7];
            
            break;
        }
        case animate_arrowmove:
        {
            [[CEGuideArrow sharedGuideArrow] showInWindow:(UIWindow *)self.navigationController.view atPosition:CEGuideArrowPositionTypeTopCenter inView:animateView atAngle:90.0 length:80.0];
            
            break;
        }
        case animate_earthquake:
        {
            [self earthquake:animateView];
            
            break;
        }
        case animate_bounce:
        {
            if (!CGRectContainsPoint(animateView.frame, CGPointMake(160, 60)))
            {
                animateView.frame = CGRectMake(10, 10, 200.0, 200.0);
                
                animateView.center = CGPointMake(160, 110.0);
                
                return;
            }
            
            NSString *keyPath = @"position.y";
            
            id finalValue = [NSNumber numberWithFloat:300];
            
            SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
            
            bounceAnimation.fromValue = [NSNumber numberWithFloat:animateView.center.x];
            
            bounceAnimation.toValue = finalValue;
            
            bounceAnimation.duration = 0.5f;
            
            bounceAnimation.numberOfBounces = 2;
            
            bounceAnimation.stiffness = SKBounceAnimationStiffnessLight;
            
            bounceAnimation.shouldOvershoot = YES;
            
            [animateView.layer addAnimation:bounceAnimation forKey:@"someKey"];
            
            [animateView.layer setValue:finalValue forKeyPath:keyPath];
            
            break;
        }
        case animate_wave:
        {
            [[Globals sharedGlobals] setAnimationDuration:2.0];
            
            [[Globals sharedGlobals] setNumberOfWaves:1];
            
            [[Globals sharedGlobals] setSpawnInterval:0.2];
            
            [[Globals sharedGlobals] setSpawnSize:10];
            
            [[Globals sharedGlobals] setScaleFactor:10.0];
            
            [[Globals sharedGlobals] setShadowRadius:5.0];
            
            break;
        }
        case animate_path:
        {
            DrawTextView * drawView = [[DrawTextView alloc] initWithFrame:self.view.frame];
            
            [self.view addSubview:drawView];
            
            drawView = nil;
            
            break;
        }
        default:
            break;
    }
}

- (void)spinit:(NSTimer *)time
{    
    prog += 0.0003;
    
    if(prog >= 1.0)
    {
        prog = 1.0;
        
        [time invalidate];        
    }
    
//    [spinnerView setProgress:prog animated:YES];
}

- (void)earthquake:(UIView*)itemView
{
    CGFloat t = 2.0;
    
    CGAffineTransform leftQuake  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, -t);
    
    CGAffineTransform rightQuake = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, t);
    
    itemView.transform = leftQuake; 
    
    [UIView beginAnimations:@"earthquake" context:(__bridge void *)(itemView)];
    
    [UIView setAnimationRepeatAutoreverses:YES];
    
    [UIView setAnimationRepeatCount:5];
    
    [UIView setAnimationDuration:0.07];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(earthquakeEnded:finished:context:)];
    
    itemView.transform = rightQuake;
    
    [UIView commitAnimations];
}

- (void)earthquakeEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([finished boolValue])
    {
        UIView * item = (__bridge UIView *)context;
        
        item.transform = CGAffineTransformIdentity;
    }
}

-(void)pan:(UIPanGestureRecognizer *)sender
{
    if (viewIsIn)
    {
        return;
    }
    
    CGPoint translation = [sender translationInView:self.view];
    
    CGRect bbFrame = self.view.frame;
    
    CGRect frame = animateView.frame;
    
    frame.origin.x += translation.x;
    
    frame.origin.y += translation.y;
    
    frame.origin.x = MAX(CGRectGetMinX(bbFrame), MIN(frame.origin.x, CGRectGetMaxX(bbFrame) - frame.size.width));
    
    frame.origin.y = MAX(CGRectGetMinY(bbFrame), MIN(frame.origin.y, CGRectGetMaxY(bbFrame) - frame.size.height));
    
    animateView.frame = frame;
    
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
}

-(void)genieToRect:(CGRect)rect edge:(BCRectEdge)edge duration:(NSTimeInterval)duration
{    
    CGRect endRect = CGRectInset(rect, 5.0, 5.0);
    
    animateView.hidden = NO;
    
    if (viewIsIn)
    {
        [animateView genieOutTransitionWithDuration:duration startRect:endRect startEdge:edge completion:^
        {            
            
        }];
    }
    else
    {
        [animateView genieInTransitionWithDuration:duration destinationRect:endRect destinationEdge:edge completion:
         ^{
             animateView.hidden = YES;
         }];
    }
    
    viewIsIn = ! viewIsIn;
}

- (CABasicAnimation *)transparencyAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    [animation setFromValue:[NSNumber numberWithFloat:1.0f]];
    
    [animation setToValue:[NSNumber numberWithFloat:0.2f]];
    
    return animation;
}

- (CABasicAnimation *)translateAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(100.0, 100.0)]];
    
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100.0, 250.0)];
    
    return animation;
}

-(void)breakView:(UIView *)view numberOfPieces:(int)pieces duration:(float)duration
{    
    [view.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    view.layer.backgroundColor = [UIColor brownColor].CGColor;
    
    UIGraphicsBeginImageContext(view.frame.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * viewSnapShot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGSize imageSize = viewSnapShot.size;
    
    view.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    view.layer.borderColor = [UIColor clearColor].CGColor;
    
    int offSet = pieces/2;
    
    BOOL evenOff = (pieces%2)?NO:YES;

    NSLog(@"evenOff :%d", evenOff);
    
    for(int x = 0; x < pieces; x++)
    {
        for(int y = 0; y < pieces; y++)
        {
            CGRect frame = CGRectMake((imageSize.width / pieces) * x,
                                      (imageSize.height / pieces) * y,
                                      (imageSize.width / pieces),
                                      (imageSize.height / pieces));
            
            CALayer * layer = [CALayer layer];
            
            layer.frame = frame;
            
            CGImageRef subimage = CGImageCreateWithImageInRect(viewSnapShot.CGImage, frame);
            
            layer.contents = (__bridge id)subimage;
            
            [view.layer addSublayer:layer];
            
            CFRelease(subimage);
            
            CABasicAnimation * side = [CABasicAnimation animationWithKeyPath:@"position.x"];
            
            float xValue = frame.origin.x + (frame.size.width /2);

            side.fromValue = [NSNumber numberWithFloat:xValue];
                                    
            if (evenOff)
            {
                if (offSet == x+1)
                {
                    xValue -= X_SIDE/2 + (X_SPACING - (x * 5));
                }
                else if(offSet + 1 == x+1)
                {
                    xValue += X_SIDE/2 - (X_SPACING - (x * 5));
                }
                else if (x+1 < offSet)
                {
                    xValue -= X_SIDE + (X_SPACING - (x * 5));
                }
                else
                {
                    xValue += X_SIDE - (X_SPACING - (x * 5));
                }
            }
            else
            {
                if (offSet == x+1)
                {
                    xValue -= X_SIDE/2 + (X_SPACING - (x * 5));
                    
                    NSLog(@"peer 1");
                }
                else if(offSet + 1 == x+1)
                {
                    NSLog(@"center");
                }
                else if(offSet + 2 == x+1)
                {
                    NSLog(@"peer 2");

                    xValue += X_SIDE/2 - (X_SPACING - (x * 5));
                }
                else if (x+1 < offSet)
                {
                    NSLog(@"left");

                    xValue -= X_SIDE + (X_SPACING - (x * 5));
                }
                else
                {
                    NSLog(@"right");

                    xValue += X_SIDE - (X_SPACING - (x * 5));
                }
            }
            
            side.toValue = [NSNumber numberWithFloat:xValue];
            
            side.delegate = self;
            
            [layer addAnimation:side forKey:nil];
            
            float yValue = frame.origin.y + (frame.size.height /2);
                        
            CABasicAnimation * up = [CABasicAnimation animationWithKeyPath:@"position.y"];
            
            up.fromValue = [NSNumber numberWithFloat:yValue];

            yValue -= Y_SIDE + (X_SPACING - (y * 5));
            
            up.toValue = [NSNumber numberWithFloat:yValue];
            
            up.delegate = self;
            
            [layer addAnimation:up forKey:nil];
//
//            CABasicAnimation * fall = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//            
//            fall.toValue = [NSNumber numberWithFloat:y1];
//            
//            fall.delegate = self;
//            
//            CAAnimationGroup * anim = [CAAnimationGroup animation];
//            
//            [anim setAnimations:[NSArray arrayWithObjects:left, up, fall, nil]];
//            
//            [anim setDuration:duration];
//            
//            anim.repeatCount = 10000;
//            
//            [anim setRemovedOnCompletion:NO];
//            
//            [anim setFillMode:kCAFillModeForwards];
//            
//            [layer addAnimation:anim forKey:nil];
        }
    }
    
}

-(void)grigView:(UIView *)view numberOfPieces:(int)pieces duration:(float)duration
{
    UIGraphicsBeginImageContext(view.frame.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * viewSnapShot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGSize imageSize = viewSnapShot.size;
    
    view.layer.backgroundColor = [UIColor clearColor].CGColor;
        
    for(int x = 0; x < pieces; x++)
    {
        for(int y = 0; y < pieces; y++)
        {
            CGRect frame = CGRectMake((imageSize.width / pieces) * x,
                                      (imageSize.height / pieces) * y,
                                      (imageSize.width / pieces),
                                      (imageSize.height / pieces));
            
            CALayer * layer = [CALayer layer];
            
            layer.frame = frame;
            
            CGImageRef subimage = CGImageCreateWithImageInRect(viewSnapShot.CGImage, frame);
            
            layer.contents = (__bridge id)subimage;
            
            [view.layer addSublayer:layer];

            CFRelease(subimage);
                                    
            CABasicAnimation * zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            
            zoomOut.toValue = [NSNumber numberWithDouble:0.0];
            
            zoomOut.delegate = self;
            
            CABasicAnimation * zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            
            zoomIn.toValue = [NSNumber numberWithDouble:1.0];
            
            zoomIn.delegate = self;
            
            CAAnimationGroup * anim = [CAAnimationGroup animation];
            
            [anim setAnimations:[NSArray arrayWithObjects:zoomOut, zoomIn, nil]];
            
            [anim setDuration:duration];
            
            anim.repeatCount = 10000;
            
            [anim setRemovedOnCompletion:NO];
            
            [anim setFillMode:kCAFillModeForwards];
            
            [layer addAnimation:anim forKey:nil];
        }
    }

}

-(void)unFoldView:(UIView *)view numberOfFolds:(int)folds duration:(float)duration direction:(FoldDirection)direction
{
    CGPoint anchorPoint;
    
    if (direction == fold_right)
        anchorPoint = CGPointMake(1, 0.5);
    else if(direction == fold_left)
        anchorPoint = CGPointMake(0, 0.5);
    else if(direction == fold_top)
        anchorPoint = CGPointMake(0.5, 0);
    else if(direction == fold_bottom)
        anchorPoint = CGPointMake(0.5, 1);
    
    UIGraphicsBeginImageContext(view.frame.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * viewSnapShot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //set 3D depth
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1.0/800.0;
    
    CALayer * origamiLayer = [CALayer layer];
    
    origamiLayer.frame = view.bounds;
    
    origamiLayer.backgroundColor = self.view.backgroundColor.CGColor;
    
    origamiLayer.sublayerTransform = transform;
    
    [view.layer addSublayer:origamiLayer];
    
    //setup rotation angle
    double endAngle;
    
    CGFloat frameWidth = view.bounds.size.width;
    
    CGFloat frameHeight = view.bounds.size.height;
    
    CGFloat foldWidth = (direction < 2)?frameWidth/(folds*2):frameHeight/(folds*2);
    
    CALayer *prevLayer = origamiLayer;
    
    for (int b=0; b < folds*2; b++)
    {
        CGRect imageFrame;
        
        if (direction == fold_right)
        {
            if(b == 0)
                endAngle = -M_PI_2;
            else
            {
                if (b%2)
                    endAngle = M_PI;
                else
                    endAngle = -M_PI;
            }
            
            imageFrame = CGRectMake(frameWidth-(b+1)*foldWidth, 0, foldWidth, frameHeight);
        }
        else if(direction == fold_left)
        {
            if(b == 0)
                endAngle = M_PI_2;
            else
            {
                if (b%2)
                    endAngle = -M_PI;
                else
                    endAngle = M_PI;
            }
            
            imageFrame = CGRectMake(b*foldWidth, 0, foldWidth, frameHeight);
        }
        else if(direction == fold_top)
        {
            if(b == 0)
                endAngle = -M_PI_2;
            else
            {
                if (b%2)
                    endAngle = M_PI;
                else
                    endAngle = -M_PI;
            }
            
            imageFrame = CGRectMake(0, b*foldWidth, frameWidth, foldWidth);
        }
        else if(direction == fold_bottom)
        {
            if(b == 0)
                endAngle = M_PI_2;
            else
            {
                if (b%2)
                    endAngle = -M_PI;
                else
                    endAngle = M_PI;
            }
            
            imageFrame = CGRectMake(0, frameHeight-(b+1)*foldWidth, frameWidth, foldWidth);
        }
        
        CATransformLayer * transLayer = [self transformLayerFromImage:viewSnapShot Frame:imageFrame Duration:duration AnchorPiont:anchorPoint StartAngle:0 EndAngle:endAngle];
        
        [prevLayer addSublayer:transLayer];
        
        prevLayer = transLayer;
    }
}

-(void)foldView:(UIView *)view numberOfFolds:(int)folds duration:(float)duration direction:(FoldDirection)direction
{
    view.hidden = NO;
    
    CGPoint anchorPoint;
    
    if (direction == fold_right)
        anchorPoint = CGPointMake(1, 0.5);
    else if(direction == fold_left)
        anchorPoint = CGPointMake(0, 0.5);
    else if(direction == fold_top)
        anchorPoint = CGPointMake(0.5, 0);
    else if(direction == fold_bottom)
        anchorPoint = CGPointMake(0.5, 1);
    
    UIGraphicsBeginImageContext(view.frame.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * viewSnapShot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
        
    //set 3D depth
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1.0/800.0;
    
    CALayer * origamiLayer = [CALayer layer];
    
    origamiLayer.frame = view.bounds;
    
    origamiLayer.backgroundColor = self.view.backgroundColor.CGColor;
    
    origamiLayer.sublayerTransform = transform;
    
    [view.layer addSublayer:origamiLayer];
    
    //setup rotation angle
    double startAngle;
    
    CGFloat frameWidth = view.bounds.size.width;
    
    CGFloat frameHeight = view.bounds.size.height;
    
    CGFloat foldWidth = (direction < 2)?frameWidth/(folds*2):frameHeight/(folds*2);
    
    CALayer *prevLayer = origamiLayer;
    
    for (int b=0; b < folds*2; b++)
    {
        CGRect imageFrame;
        
        if (direction == fold_right)
        {
            if(b == 0)
                startAngle = -M_PI_2;
            else
            {
                if (b%2)
                    startAngle = M_PI;
                else
                    startAngle = -M_PI;
            }
            
            imageFrame = CGRectMake(frameWidth-(b+1)*foldWidth, 0, foldWidth, frameHeight);
        }
        else if(direction == fold_left)
        {
            if(b == 0)
                startAngle = M_PI_2;
            else
            {
                if (b%2)
                    startAngle = -M_PI;
                else
                    startAngle = M_PI;
            }
            
            imageFrame = CGRectMake(b*foldWidth, 0, foldWidth, frameHeight);
        }
        else if(direction == fold_top)
        {
            if(b == 0)
                startAngle = -M_PI_2;
            else
            {
                if (b%2)
                    startAngle = M_PI;
                else
                    startAngle = -M_PI;
            }
            
            imageFrame = CGRectMake(0, b*foldWidth, frameWidth, foldWidth);
        }
        else if(direction == fold_bottom)
        {
            if(b == 0)
                startAngle = M_PI_2;
            else
            {
                if (b%2)
                    startAngle = -M_PI;
                else
                    startAngle = M_PI;
            }
            
            imageFrame = CGRectMake(0, frameHeight-(b+1)*foldWidth, frameWidth, foldWidth);
        }
        
        CATransformLayer * transLayer = [self transformLayerFromImage:viewSnapShot Frame:imageFrame Duration:duration AnchorPiont:anchorPoint StartAngle:startAngle EndAngle:0];
                
        [prevLayer addSublayer:transLayer];
        
        prevLayer = transLayer;
    }
}

- (CATransformLayer *)transformLayerFromImage:(UIImage *)image Frame:(CGRect)frame Duration:(CGFloat)duration AnchorPiont:(CGPoint)anchorPoint StartAngle:(double)start EndAngle:(double)end;
{
    CATransformLayer * jointLayer = [CATransformLayer layer];
        
    jointLayer.anchorPoint = anchorPoint;
    
    CALayer *imageLayer = [CALayer layer];
        
    CAGradientLayer *shadowLayer = [CAGradientLayer layer];
    
    double shadowAniOpacity;
    
    if (anchorPoint.y == 0.5)
    {
        CGFloat layerWidth;
        
        if (anchorPoint.x == 0 ) //from left to right
        {
            layerWidth = image.size.width - frame.origin.x;
            
            jointLayer.frame = CGRectMake(0, 0, layerWidth, frame.size.height);
            
            if (frame.origin.x)
            {
                jointLayer.position = CGPointMake(frame.size.width, frame.size.height/2);
            }
            else
            {
                jointLayer.position = CGPointMake(0, frame.size.height/2);
            }
        }
        else
        { //from right to left
            layerWidth = frame.origin.x + frame.size.width;
            
            jointLayer.frame = CGRectMake(0, 0, layerWidth, frame.size.height);
            
            jointLayer.position = CGPointMake(layerWidth, frame.size.height/2);
        }
        
        //map image onto transform layer
        imageLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        imageLayer.anchorPoint = anchorPoint;
        
        imageLayer.position = CGPointMake(layerWidth*anchorPoint.x, frame.size.height/2);
        
        [jointLayer addSublayer:imageLayer];
        
        CGImageRef imageCrop = CGImageCreateWithImageInRect(image.CGImage, frame);
        
        imageLayer.contents = (__bridge id)imageCrop;
        
        imageLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        //add shadow
        NSInteger index = frame.origin.x/frame.size.width;
        
        shadowLayer.frame = imageLayer.bounds;
        
        shadowLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
        
        shadowLayer.opacity = 0.0;
        
        shadowLayer.colors = [NSArray arrayWithObjects:(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
        
        if (index%2)
        {
            shadowLayer.startPoint = CGPointMake(0, 0.5);
            
            shadowLayer.endPoint = CGPointMake(1, 0.5);
            
            shadowAniOpacity = (anchorPoint.x)?0.24:0.32;
        }
        else
        {
            shadowLayer.startPoint = CGPointMake(1, 0.5);
            
            shadowLayer.endPoint = CGPointMake(0, 0.5);
            
            shadowAniOpacity = (anchorPoint.x)?0.32:0.24;
        }
    }
    else
    {
        CGFloat layerHeight;
        
        if (anchorPoint.y == 0 ) //from top
        {
            layerHeight = image.size.height - frame.origin.y;
            
            jointLayer.frame = CGRectMake(0, 0, frame.size.width, layerHeight);
            
            if (frame.origin.y)
            {
                jointLayer.position = CGPointMake(frame.size.width/2, frame.size.height);
            }
            else
            {
                jointLayer.position = CGPointMake(frame.size.width/2, 0);
            }
        }
        else
        { //from bottom
            layerHeight = frame.origin.y + frame.size.height;
            
            jointLayer.frame = CGRectMake(0, 0, frame.size.width, layerHeight);
            
            jointLayer.position = CGPointMake(frame.size.width/2, layerHeight);
        }
        
        //map image onto transform layer
        imageLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        imageLayer.anchorPoint = anchorPoint;
        
        imageLayer.position = CGPointMake(frame.size.width/2, layerHeight*anchorPoint.y);
        
        [jointLayer addSublayer:imageLayer];
        
        CGImageRef imageCrop = CGImageCreateWithImageInRect(image.CGImage, frame);
        
        imageLayer.contents = (__bridge id)imageCrop;
        
        imageLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        //add shadow
        NSInteger index = frame.origin.y/frame.size.height;
        
        shadowLayer.frame = imageLayer.bounds;
        
        shadowLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
        
        shadowLayer.opacity = 0.0;
        
        shadowLayer.colors = [NSArray arrayWithObjects:(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
        
        if (index%2)
        {
            shadowLayer.startPoint = CGPointMake(0.5, 0);
            
            shadowLayer.endPoint = CGPointMake(0.5, 1);
            
            shadowAniOpacity = (anchorPoint.x)?0.24:0.32;
        }
        else
        {
            shadowLayer.startPoint = CGPointMake(0.5, 1);
            
            shadowLayer.endPoint = CGPointMake(0.5, 0);
            
            shadowAniOpacity = (anchorPoint.x)?0.32:0.24;
        }
    }
    
    [imageLayer addSublayer:shadowLayer];
    
    //animate open/close animation
    CABasicAnimation* animation = (anchorPoint.y == 0.5)?[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"]:[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    
    [animation setDuration:duration];
    
    [animation setFromValue:[NSNumber numberWithDouble:start]];
    
    [animation setToValue:[NSNumber numberWithDouble:end]];
    
    [animation setRemovedOnCompletion:NO];
    
    [jointLayer addAnimation:animation forKey:@"jointAnimation"];
    
    //animate shadow opacity
    
    animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    [animation setDuration:duration];
    
    [animation setFromValue:[NSNumber numberWithDouble:(start)?shadowAniOpacity:0]];
    
    [animation setToValue:[NSNumber numberWithDouble:(start)?0:shadowAniOpacity]];
    
    [animation setRemovedOnCompletion:NO];
    
    [shadowLayer addAnimation:animation forKey:nil];
    
    return jointLayer;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_animationType != animate_wave)
        return;
    
	CGPoint touchPoint = [[touches anyObject] locationInView:[[UIApplication sharedApplication] keyWindow]];
        
	[SCWaveAnimationView waveAnimationAtPosition:touchPoint];
}



@end
