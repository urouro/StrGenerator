#import "TopController.h"
#import "SettingController.h"
#import "MBProgressHUD.h"
#import "UIViewController+Transition.h"
#import "PreferencesManager.h"
#import "SGRandom.h"
#import "GAI.h"
#import "AdWhirlView.h"

@interface TopController ()
<UITextViewDelegate, AdWhirlDelegate>

@property(nonatomic,retain) UITextView *textView;
@property(nonatomic,retain) AdWhirlView *adWhirlView;

@end

typedef enum {
    TopControllerBarButtonModeNormal,
    TopControllerBarButtonModeEditText,
} TopControllerBarButtonMode;

@implementation TopController
@synthesize textView = _textView;
@synthesize adWhirlView = _adWhirlView;

- (void)dealloc
{
    self.textView = nil;
    self.adWhirlView = nil;
    
    [super dealloc];
}


#pragma mark - Initialize

- (id)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    //初回にデフォルト設定（カタカナ・100文字）
    PreferencesManager *pref = [PreferencesManager sharedManager];
    if([pref first]){
        [pref setKataZen:YES];
        [pref setRandom:NO];
        [pref setStringCount:100];
        
        //デフォルト文字の作成
        SGRandom *rd = [SGRandom random];
        rd.hiragana = [pref hiraZen];
        rd.katakana = [pref kataZen];
        rd.katakanaHan = [pref kataHan];
        rd.alphabet = [pref alphabet];
        rd.numeric = [pref numeric];
        rd.random = [pref random];
        [pref setDefaultText:[rd stringWithLength:[pref stringCount]]];
        
        [pref setFirst:NO];
    }
    
    return self;
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /** Navigation Bar **/
    [self _changeNavigationBarButton:TopControllerBarButtonModeNormal];
    
    /** Text View **/
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 
                                                                 self.view.frame.size.width, 
                                                                 self.view.frame.size.height)];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.accessibilityLabel = AC_TOP_TEXT;
    [self.view addSubview:self.textView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShowNotification:) 
                                                 name:UIKeyboardWillShowNotification 
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillHideNotification:) 
                                                 name:UIKeyboardWillHideNotification 
                                               object:nil];
    
    self.textView.text = [[PreferencesManager sharedManager] defaultText];
    
    [self _updateNavigationBarTitle];
    
    
    //Set up Ad
    if(!self.adWhirlView){
        self.adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
        self.adWhirlView.delegate = self;
        self.adWhirlView.frame = CGRectMake(0, 0, self.adWhirlView.frame.size.width, self.adWhirlView.frame.size.height);
        [self.view addSubview:self.adWhirlView];
    }
    
    //GA
    [[GAI sharedInstance].defaultTracker trackView:@"TOP"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[PreferencesManager sharedManager] setDefaultText:self.textView.text];
    
}


#pragma mark - Action

- (void)tapSettingButton:(UIBarButtonItem *)button
{
    [self _transitionToSetting];
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"TOP/Setting"
                                                     withAction:@"tap"
                                                      withLabel:nil
                                                      withValue:nil];
}

- (void)tapCloseButton:(UIBarButtonItem *)button
{
    [_textView resignFirstResponder];
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"TOP/Close"
                                                     withAction:@"tap"
                                                      withLabel:nil
                                                      withValue:nil];
}

- (void)tapCopyButton:(UIBarButtonItem *)button
{
    [[UIPasteboard generalPasteboard] setValue:_textView.text
                             forPasteboardType:@"public.utf8-plain-text"];
    
    //コピー完了メッセージ
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = NSLocalizedString(@"TOP_Copy_Message", nil);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"TOP/Copy"
                                                     withAction:@"tap"
                                                      withLabel:nil
                                                      withValue:nil];
}

- (void)tapDeleteButton:(UIBarButtonItem *)button
{
    _textView.text = @"";
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"TOP/Delete"
                                                     withAction:@"tap"
                                                      withLabel:nil
                                                      withValue:nil];
}

- (void)_transitionToSetting
{
    SettingController *controller = [[[SettingController alloc] init] autorelease];
    controller.delegate = self;
    
    UINavigationController* navController;
    navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    navController.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
    
    [self presentModalViewController:navController animated:YES];
}


#pragma mark SettingController Delegate
- (void)settingControllerDidFinish:(SettingController *)controller
{
    [controller dismissModalViewControllerAnimated:YES];
}


#pragma mark - UI

- (void)_changeNavigationBarButton:(TopControllerBarButtonMode)mode
{
    [self _changeNavigationBarButton:mode animated:NO];
}

- (void)_changeNavigationBarButton:(TopControllerBarButtonMode)mode animated:(BOOL)animated
{
    if(mode == TopControllerBarButtonModeNormal){
        
        UIBarButtonItem *leftItem;
        leftItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"TOP_Left_Setting", @"Left Item")
                                                    style:UIBarButtonItemStyleBordered
                                                   target:self
                                                   action:@selector(tapSettingButton:)];
        leftItem.accessibilityLabel = AC_TOP_SETTING;
        
        if([leftItem respondsToSelector:@selector(setTintColor:)]){
            [leftItem setTintColor:self.navigationController.navigationBar.tintColor];
        }
        
        [self.navigationItem setLeftBarButtonItem:leftItem animated:animated];
        [leftItem release];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"TOP_Right_Copy", @"Right Item")
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(tapCopyButton:)];
        rightItem.accessibilityLabel = AC_TOP_COPY;
        [self.navigationItem setRightBarButtonItem:rightItem animated:animated];
        [rightItem release];
        
    }else if(mode == TopControllerBarButtonModeEditText){
        
        [self.navigationItem setLeftBarButtonItem:nil animated:animated];
        
        UIBarButtonItem *leftItem;
        leftItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"TOP_Left_Delete", @"Left Item")
                                                    style:UIBarButtonItemStyleBordered
                                                   target:self
                                                   action:@selector(tapDeleteButton:)];
        leftItem.accessibilityLabel = AC_TOP_DELETE;
        [self.navigationItem setLeftBarButtonItem:leftItem animated:animated];
        [leftItem release];
        
        UIBarButtonItem *rightItem;
        rightItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"TOP_Right_Close", @"Left Item")
                                                     style:UIBarButtonItemStyleBordered
                                                    target:self
                                                    action:@selector(tapCloseButton:)];
        rightItem.accessibilityLabel = AC_TOP_CLOSE;
        if([rightItem respondsToSelector:@selector(setTintColor:)]){
            [rightItem setTintColor:[UIColor blueColor]];
        }
        [self.navigationItem setRightBarButtonItem:rightItem animated:animated];
        [rightItem release];
        
    }
}

- (void)_adjustTextViewHeight:(CGRect)bounds
{
    CGRect frame = self.textView.frame;
    frame.size.height = self.view.frame.size.height - bounds.size.height - self.adWhirlView.frame.size.height;
    self.textView.frame = frame;
}

- (void)_updateNavigationBarTitle
{
    //現在の文字数を表示
    self.title = [NSString stringWithFormat:@"%d", [_textView.text length]];
}



#pragma mark - Notification

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    CGRect bounds;
    bounds = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self _adjustTextViewHeight:bounds];
    
    [self _changeNavigationBarButton:TopControllerBarButtonModeEditText animated:YES];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    [self _adjustTextViewHeight:CGRectZero];

    [self _changeNavigationBarButton:TopControllerBarButtonModeNormal animated:YES];
}

#pragma mark - UITextView Delegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self _updateNavigationBarTitle];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    
    [[PreferencesManager sharedManager] setDefaultText:self.textView.text];
    
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"TOP/TextView"
                                                     withAction:@"endEditing"
                                                      withLabel:@""
                                                      withValue:nil];
}


#pragma mark - Adwhirl

- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView
{
    LOG_METHOD;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.textView.frame = CGRectMake(0,
                                                          self.adWhirlView.frame.size.height,
                                                          self.textView.frame.size.width,
                                                          self.view.frame.size.height - self.adWhirlView.frame.size.height);
                     }];
}

- (NSString *)adWhirlApplicationKey
{
    return ADWHIRL_APP_KEY;
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}




@end
