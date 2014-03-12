#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#define radians(X) ((X * M_PI) / 180)

typedef enum
{
    fold_right = 0,
    
    fold_left,
    
    fold_top,
    
    fold_bottom
    
}FoldDirection;

@interface Animation : NSObject

// Shake a View

+(BOOL)animateShakeView:(UIView *)animateView numberOfShakes:(int)shakes duration:(float)duration distance:(float)distance;

+(BOOL)animateRotateView:(UIView *)animateView numberOfRotation:(int)rotates duration:(float)duration transform:(CATransform3D)transform;

@end
