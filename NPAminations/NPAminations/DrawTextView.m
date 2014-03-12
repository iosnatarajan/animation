#import "DrawTextView.h"

#import <QuartzCore/QuartzCore.h>

#import <CoreText/CoreText.h>

@implementation DrawTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        
        _animationLayer = [CALayer layer];
        
        _animationLayer.frame = CGRectMake(20.0f, 64.0f, CGRectGetWidth(self.layer.bounds) - 40.0f, CGRectGetHeight(self.layer.bounds) - 84.0f);
        
        [self.layer addSublayer:_animationLayer];
        
        [self setupTextLayer];
        
        [self startAnimation];
    }
    
    return self;
}

- (void) setupDrawingLayer
{
    if (_pathLayer != nil)
    {
        [_pathLayer removeFromSuperlayer];
        
        [_pathLayer removeFromSuperlayer];
        
        _pathLayer = nil;
        
        _pathLayer = nil;
    }
    
    CGRect pathRect = CGRectInset(_animationLayer.bounds, 100.0f, 100.0f);
    CGPoint bottomLeft 	= CGPointMake(CGRectGetMinX(pathRect), CGRectGetMinY(pathRect));
    CGPoint topLeft		= CGPointMake(CGRectGetMinX(pathRect), CGRectGetMinY(pathRect) + CGRectGetHeight(pathRect) * 2.0f/3.0f);
    CGPoint bottomRight = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMinY(pathRect));
    CGPoint topRight	= CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMinY(pathRect) + CGRectGetHeight(pathRect) * 2.0f/3.0f);
    CGPoint roofTip		= CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:bottomLeft];
    [path addLineToPoint:topLeft];
    [path addLineToPoint:roofTip];
    [path addLineToPoint:topRight];
    [path addLineToPoint:topLeft];
    [path addLineToPoint:bottomRight];
    [path addLineToPoint:topRight];
    [path addLineToPoint:bottomLeft];
    [path addLineToPoint:bottomRight];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = _animationLayer.bounds;
    pathLayer.bounds = pathRect;
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 10.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [_animationLayer addSublayer:pathLayer];
    
    _pathLayer = pathLayer;
    
    //    UIImage *penImage = [UIImage imageNamed:@"noun_project_347_2.png"];
    //    CALayer *penLayer = [CALayer layer];
    //    penLayer.contents = (id)penImage.CGImage;
    //    penLayer.anchorPoint = CGPointZero;
    //    penLayer.frame = CGRectMake(0.0f, 0.0f, penImage.size.width, penImage.size.height);
    //    [pathLayer addSublayer:penLayer];
    //
    //    _pathLayer = penLayer;
}



- (void) setupTextLayer
{
    if (_pathLayer != nil) {
        [_pathLayer removeFromSuperlayer];
        [_pathLayer removeFromSuperlayer];
        _pathLayer = nil;
        _pathLayer = nil;
    }
    
    // Create path from text
    // See: http://www.codeproject.com/KB/iPhone/Glyph.aspx
    // License: The Code Project Open License (CPOL) 1.02 http://www.codeproject.com/info/cpol10.aspx
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CTFontRef font = CTFontCreateWithName(CFSTR("BertaDrug"), 72.0f, NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"Wimbio"
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
	CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            // Get PATH of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = _animationLayer.bounds;
	pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    //pathLayer.backgroundColor = [[UIColor yellowColor] CGColor];
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    pathLayer.fillColor = [[UIColor blueColor] CGColor];
    pathLayer.lineWidth = 3.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [_animationLayer addSublayer:pathLayer];
    
    _pathLayer = pathLayer;
    
    //    UIImage *penImage = [UIImage imageNamed:@"noun_project_347_2.png"];
    //    CALayer *penLayer = [CALayer layer];
    //    penLayer.contents = (id)penImage.CGImage;
    //    penLayer.anchorPoint = CGPointZero;
    //    penLayer.frame = CGRectMake(0.0f, 0.0f, penImage.size.width, penImage.size.height);
    //    [pathLayer addSublayer:penLayer];
    //
    //    _pathLayer = penLayer;
}



- (void) startAnimation
{
    [_pathLayer removeAllAnimations];
    [_pathLayer removeAllAnimations];
    
    //    _pathLayer.hidden = NO;
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [_pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    CABasicAnimation *fillColorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillColorAnimation.duration = 1.5f;
    fillColorAnimation.fromValue = (id)[[UIColor clearColor] CGColor];
    fillColorAnimation.toValue = (id)[[UIColor yellowColor] CGColor];
    //    fillColorAnimation.repeatCount = 10;
    //    fillColorAnimation.autoreverses = YES;
    [_pathLayer addAnimation:fillColorAnimation forKey:@"fillColor"];
    
    //    CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    penAnimation.duration = 10.0;
    //    penAnimation.path = _pathLayer.path;
    //    penAnimation.calculationMode = kCAAnimationPaced;
    //    penAnimation.delegate = self;
    //    [_pathLayer addAnimation:penAnimation forKey:@"position"];
}


- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _pathLayer.hidden = YES;
}

@end
