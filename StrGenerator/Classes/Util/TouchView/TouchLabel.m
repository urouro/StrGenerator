#import "TouchLabel.h"

@implementation TouchLabel
@synthesize delegate = _delegate;

//--------------------------------------------------------------//
#pragma mark - Initialize
//--------------------------------------------------------------//
- (id)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    [self _init];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self _init];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self _init];
    
    return self;
}

- (void)_init
{
    self.userInteractionEnabled = YES;
}

//--------------------------------------------------------------//
#pragma mark - Touch Event
//--------------------------------------------------------------//
- (CGPoint)_pointTouched:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    return location;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(touchLabelTouchesDidBegan:point:)]){
        [_delegate touchLabelTouchesDidBegan:self point:[self _pointTouched:touches]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(touchLabelTouchesDidEnded:point:)]){
        [_delegate touchLabelTouchesDidEnded:self point:[self _pointTouched:touches]];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(touchLabelTouchesDidCanceled:point:)]){
        [_delegate touchLabelTouchesDidCanceled:self point:[self _pointTouched:touches]];
    }
}


@end
