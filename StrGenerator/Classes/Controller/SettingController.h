#import <UIKit/UIKit.h>

@interface SettingController : UIViewController

@property(nonatomic,assign) id delegate;

@end

@interface NSObject (SettingControllerDelegate)

- (void)settingControllerDidFinish:(SettingController *)controller;

@end