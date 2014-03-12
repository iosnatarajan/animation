#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import <COFramework/COFramework.h>

#define radians(X) ((X * M_PI) / 180)

typedef enum
{
    animate_shake = 0,
    
    animate_zoominout,
    
    animate_roate,
    
    animate_fold,
    
    animate_ripple,
    
    animate_grid,
    
    animate_break,
    
    animate_reflect,
    
    animate_genieeffect,
    
    animate_arrowmove,
    
    animate_earthquake,
    
    animate_bounce,
    
    animate_wave,
    
    animate_path
    
}AnimationType;

@interface AnimationController : UIViewController
{
    UIView * animateView;
    
    FoldDirection foldDir;
    
    NSTimer * timer;
    
    float prog;
    
    BOOL folded;
    
    BOOL viewIsIn;
}

@property (nonatomic) AnimationType animationType;

@end
