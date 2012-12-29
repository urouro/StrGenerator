#import "LicenseController.h"
#import "GAI.h"

@interface LicenseController ()

@end

@implementation LicenseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height)];
    [self.view addSubview:webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Licenses" ofType:@"txt"];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    [webView release];
    
    [[GAI sharedInstance].defaultTracker trackView:@"License"];
}   

@end
