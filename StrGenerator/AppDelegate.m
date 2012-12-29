#import "AppDelegate.h"
#import "TopController.h"
#import "GAI.h"

#if RUN_KIF_TESTS
#import "ScenarioTestController.h"
#import "PreferencesManager.h"
#endif

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    TopController *controller = [[TopController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [nav setNavigationBarHidden:NO];
    nav.navigationBar.tintColor = [UIColor blackColor];
    self.window.rootViewController = nav;
    [controller release];
    [nav release];
    
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
#if RUN_KIF_TESTS
    //既に入力内容がある場合、KIF TESTが失敗するため、リセットする
    [[PreferencesManager sharedManager] setDefaultText:nil];
    
    [[ScenarioTestController sharedInstance] startTestingWithCompletionBlock:^{
        // Exit after the tests complete so that CI knows we're done
        exit([[ScenarioTestController sharedInstance] failureCount]);
    }];
#endif
    
    
    /** Google Analytics **/
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [GAI sharedInstance].debug = GA_DEBUG;
    [[GAI sharedInstance] trackerWithTrackingId:GA_TRACKING_ID];
    
    return YES;
}


@end
