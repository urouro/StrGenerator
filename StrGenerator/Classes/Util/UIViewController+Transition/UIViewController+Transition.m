#import "UIViewController+Transition.h"

@implementation UIViewController (Transition)

//--------------------------------------------------------------//
#pragma mark - From Class Name
//--------------------------------------------------------------//
- (void)transitionWithClassName:(NSString *)className
{
    [self transitionWithClassName:className animated:NO];
}

- (void)transitionWithClassName:(NSString *)className animated:(BOOL)animated
{
    LOG(@"className=%@", className);
    
    Class class = NSClassFromString(className);
    if(class){
        id controller = [[[class alloc] init] autorelease];
        [self.navigationController pushViewController:controller animated:animated];
    }
}

//--------------------------------------------------------------//
#pragma mark - From Instance
//--------------------------------------------------------------//
#pragma mark Transition
- (void)transitionToController:(id)controller
{
    [self transitionToController:controller animated:NO];
}

- (void)transitionToController:(id)controller animated:(BOOL)animated
{
    if([controller isKindOfClass:[UIViewController class]]){
        
        [self.navigationController pushViewController:controller animated:animated];
    }
}

- (void)transitionFromRightToController:(UIViewController *)controller
{
    controller.view.frame = self.view.bounds;
    
    CGFloat baseX = self.view.center.x;
    CGFloat baseY = self.view.center.y;
    
    controller.view.center = CGPointMake(baseX*(-1), baseY);
    [self.view addSubview:controller.view];
    
    [UIView transitionWithView:self.view
                      duration:0.4
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{
                        self.view.center = CGPointMake(baseX*3, baseY);
                        
                    }completion:^(BOOL f){
                        [self.navigationController pushViewController:controller animated:NO];
                        
                        [controller.view removeFromSuperview];
                    }];
}

#pragma mark Fade In/Out
- (void)fadeToController:(UIViewController *)controller
{
    [self fadeToController:controller fadeDuration:0.5];
}

- (void)fadeToController:(UIViewController *)controller fadeDuration:(float)duration
{
    controller.view.alpha = 0;
    
    [UIView animateWithDuration:duration/2
                     animations:^{
                         self.view.alpha = 0;
                         
                     }completion:^(BOOL f){
                         [self.navigationController pushViewController:controller animated:NO];
                         
                         [UIView animateWithDuration:duration/2
                                          animations:^{
                                              controller.view.alpha = 1;
                                              
                                          }completion:^(BOOL f){
                                              
                                          }];
                     }];
}


@end
