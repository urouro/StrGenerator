#import "SettingController.h"
#import "TopController.h"
#import "LicenseController.h"
#import "PreferencesManager.h"
#import "UIViewController+Transition.h"
#import "SGRandom.h"
#import "SGUtil.h"
#import "TouchLabel.h"
#import "GAI.h"

#define ACCOUNT_INFO @"@uro_uro_"
#define ACCOUNT_URL @"https://twitter.com/uro_uro_"

@interface SettingController ()
<UITableViewDataSource, UITableViewDelegate,
 UITextFieldDelegate>

@property(nonatomic,retain) UITableView *table;
@property(nonatomic,retain) UITextField *stringCountField;
@property(nonatomic,retain) NSString *temporaryStringCountText;

@end

typedef enum {
    SettingControllerBarButtonModeNormal,
    SettingControllerBarButtonModeEditText,
} SettingControllerBarButtonMode;

typedef enum {
    TableSectionStringCount = 0,
    TableSectionCharacter,
    TableSectionRandom,
    TableSectionAbout,
} TableSection;

typedef enum {
    TableCharacterRowHiraZen,
    TableCharacterRowKataZen,
    TableCharacterRowKataHan,
    TableCharacterRowAlphabet,
    TableCharacterRowNumeric,
} TableCharacterRow;

typedef enum {
    TableAboutRowVersion = 0,
    TableAboutLicense,
} TableAboutRow;

@implementation SettingController
@synthesize delegate = _delegate;
@synthesize table = _table;
@synthesize stringCountField = _stringCountField;
@synthesize temporaryStringCountText = _temporaryStringCountText;

- (void)dealloc
{
    self.table = nil;
    self.stringCountField = nil;
    self.temporaryStringCountText = nil;
    
    [super dealloc];
}


#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /** Navigation Bar **/
    self.title = NSLocalizedString(@"SET_Title", nil);
    [self _changeNavigationBarButton:SettingControllerBarButtonModeNormal];
    
    /** Table View **/
    self.table = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                self.view.frame.size.width,
                                                                self.view.frame.size.height-44)
                                               style:UITableViewStyleGrouped] autorelease];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.accessibilityLabel = AC_SET_TABLE;
    [self.view addSubview:self.table];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[GAI sharedInstance].defaultTracker trackView:@"SETTING"];
}

- (NSNumber *)_numberWithBoolNumber:(NSNumber *)boolNumber
{
    return [boolNumber boolValue]?[NSNumber numberWithBool:YES]:[NSNumber numberWithBool:NO];
}


- (void)_changeNavigationBarButton:(SettingControllerBarButtonMode)mode
{
    [self _changeNavigationBarButton:mode animated:NO];
}

- (void)_changeNavigationBarButton:(SettingControllerBarButtonMode)mode animated:(BOOL)animated
{
    if(mode == SettingControllerBarButtonModeNormal){
        UIBarButtonItem *leftItem;
        leftItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SET_Left_Cancel", nil)
                                                    style:UIBarButtonItemStyleBordered
                                                   target:self
                                                   action:@selector(tapCancelButton:)];
        leftItem.accessibilityLabel = AC_SET_CANCEL;
        [self.navigationItem setLeftBarButtonItem:leftItem animated:animated];
        [leftItem release];
        
        UIBarButtonItem *rightItem;
        rightItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SET_Right_OK", nil)
                                                     style:UIBarButtonItemStyleBordered
                                                    target:self
                                                    action:@selector(tapOKButton:)];
        rightItem.accessibilityLabel = AC_SET_OK;
        [self.navigationItem setRightBarButtonItem:rightItem animated:animated];
        
        if([rightItem respondsToSelector:@selector(setTintColor:)]){
            [rightItem setTintColor:[UIColor blueColor]];
        }
        
        [rightItem release];
        
    }else if(mode == SettingControllerBarButtonModeEditText){
        [self.navigationItem setLeftBarButtonItem:nil animated:animated];
        
        UIBarButtonItem *rightItem;
        rightItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SET_Right_Close", nil)
                                                     style:UIBarButtonItemStyleBordered
                                                    target:self
                                                    action:@selector(tapCloseButton:)];
        rightItem.accessibilityLabel = AC_SET_CLOSE;
        self.navigationItem.rightBarButtonItem = rightItem;
        
        if([rightItem respondsToSelector:@selector(setTintColor:)]){
            [rightItem setTintColor:[UIColor blueColor]];
        }
        
        [rightItem release];
        
    }
}


#pragma mark - Action

- (void)tapCancelButton:(UIBarButtonItem *)button
{
    [self _transitionToTop];
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"SETTING/Cancel"
                                                     withAction:@"tap"
                                                      withLabel:nil
                                                      withValue:nil];
}

- (void)tapOKButton:(UIBarButtonItem *)button
{
    //デフォルト文字の作成
    PreferencesManager *pref = [PreferencesManager sharedManager];
    SGRandom *rd = [SGRandom random];
    rd.hiragana = [pref hiraZen];
    rd.katakana = [pref kataZen];
    rd.katakanaHan = [pref kataHan];
    rd.alphabet = [pref alphabet];
    rd.numeric = [pref numeric];
    rd.random = [pref random];
    [pref setDefaultText:[rd stringWithLength:[pref stringCount]]];
    
    [self _transitionToTop];
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"SETTING/Ok"
                                                     withAction:@"tap"
                                                      withLabel:nil
                                                      withValue:nil];
}

- (void)tapCloseButton:(UIBarButtonItem *)button
{
    [self.stringCountField resignFirstResponder];
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"SETTING/Close"
                                                     withAction:@"tap"
                                                      withLabel:nil
                                                      withValue:nil];
}

- (void)_transitionToTop
{
    if([_delegate respondsToSelector:@selector(settingControllerDidFinish:)]){
        [_delegate settingControllerDidFinish:self];
    }
}

- (void)_transitionToSetting
{
    LicenseController *controller = [[[LicenseController alloc] init] autorelease];
    [self transitionToController:controller animated:YES];
}

#pragma mark - UITableView Delegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == TableSectionCharacter){
        return 5;
        
    }else if(section == TableSectionRandom){
        return 1;
        
    }else if(section == TableSectionAbout){
        return 2;
    
    }else{
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == TableSectionCharacter){
        return NSLocalizedString(@"SET_Characters", nil);
        
    }else if(section == TableSectionAbout){
        return NSLocalizedString(@"SET_About", nil);
    
    }else{
        return nil;
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == TableSectionAbout){
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                       self.view.frame.size.width,
                                                                       60)] autorelease];
        view.backgroundColor = [UIColor clearColor];
        
        TouchLabel *lbl = [[[TouchLabel alloc] initWithFrame:CGRectMake(0, 5,
                                                                        self.view.frame.size.width,
                                                                        20)] autorelease];
        lbl.text = ACCOUNT_INFO;
        lbl.textColor = [UIColor blueColor];
        lbl.textAlignment = UITextAlignmentCenter;
        lbl.backgroundColor = [UIColor clearColor];
        lbl.font = [UIFont systemFontOfSize:12];
        lbl.shadowColor = [UIColor whiteColor];
        lbl.shadowOffset = CGSizeMake(0, 1);
        lbl.delegate = self;
        [lbl sizeToFit];
        lbl.center = CGPointMake(self.view.center.x, lbl.center.y);
        
        [view addSubview:lbl];
        
        return view;
        
    }else if(section == TableSectionRandom){
        UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                                  self.view.frame.size.width,
                                                                  30)] autorelease];
        lbl.text = @"◇";
        lbl.textColor = [UIColor blackColor];
        lbl.textAlignment = UITextAlignmentCenter;
        lbl.backgroundColor = [UIColor clearColor];
        lbl.font = [UIFont systemFontOfSize:12];
        lbl.shadowColor = [UIColor whiteColor];
        lbl.shadowOffset = CGSizeMake(0, 1);
        return lbl;
        
    }else{
        return nil;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == TableSectionAbout){
        return 60.0f;
        
    }else if(section == TableSectionRandom){
        return 60.0f;
        
    }else{
        return 0.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CellIdentifier_%d_%d", indexPath.section, indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        UITableViewCellStyle style;
        style = UITableViewCellStyleValue1;
        
        cell = [[[UITableViewCell alloc] initWithStyle:style
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if(indexPath.section == TableSectionStringCount){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = NSLocalizedString(@"SET_StringCount", nil);
        cell.textLabel.textColor = [UIColor grayColor];
        
        if(!self.stringCountField){
            CGRect txtFrame = CGRectMake(cell.contentView.frame.size.width/4,
                                         12,
                                         cell.contentView.frame.size.width/4*3-22,
                                         cell.contentView.frame.size.height);
            self.stringCountField = [[[UITextField alloc] initWithFrame:txtFrame] autorelease];
            self.stringCountField.delegate = self;
            self.stringCountField.textAlignment = UITextAlignmentLeft;
            self.stringCountField.textColor = [UIColor blackColor];
            self.stringCountField.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:16];
            self.stringCountField.backgroundColor = [UIColor clearColor];
            self.stringCountField.borderStyle = UITextBorderStyleNone;
            self.stringCountField.keyboardType = UIKeyboardTypeNumberPad;
            self.stringCountField.accessibilityLabel = AC_SET_STRINGCOUNT;
            [cell.contentView addSubview:self.stringCountField];
        }
        
        self.stringCountField.text = [NSString stringWithFormat:@"%d", [[PreferencesManager sharedManager] stringCount]];
        
    }else if(indexPath.section == TableSectionCharacter){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        PreferencesManager *pref = [PreferencesManager sharedManager];
        BOOL check = NO;
        
        //どの種類も選択されていない場合、文字はなしになるため、エラー表示する
        UIColor *textColor = [UIColor blackColor];
        if(![pref hiraZen] &&
           ![pref kataZen] &&
           ![pref kataHan] &&
           ![pref alphabet] &&
           ![pref numeric]){
            textColor = [UIColor redColor];
        }
        
        if(indexPath.row == TableCharacterRowHiraZen){
            check = [pref hiraZen];
            cell.textLabel.text = NSLocalizedString(@"HiraZen", nil);
            cell.textLabel.textColor = textColor;
            
        }else if(indexPath.row == TableCharacterRowKataZen){
            check = [pref kataZen];
            cell.textLabel.text = NSLocalizedString(@"KataZen", nil);
            cell.textLabel.textColor = textColor;
            
        }else if(indexPath.row == TableCharacterRowKataHan){
            check = [pref kataHan];
            cell.textLabel.text = NSLocalizedString(@"KataHan", nil);
            cell.textLabel.textColor = textColor;
            
        }else if(indexPath.row == TableCharacterRowAlphabet){
            check = [pref alphabet];
            cell.textLabel.text = NSLocalizedString(@"Alphabet", nil);
            cell.textLabel.textColor = textColor;
            
        }else if(indexPath.row == TableCharacterRowNumeric){
            check = [pref numeric];
            cell.textLabel.text = NSLocalizedString(@"Numeric", nil);
            cell.textLabel.textColor = textColor;
            
        }
        
        
        UITableViewCellAccessoryType accessoryType;
        if(check){
            accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            accessoryType = UITableViewCellAccessoryNone;
        }
        
        cell.accessoryType = accessoryType;
       
    }else if(indexPath.section == TableSectionRandom){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BOOL check = NO;
        check = [[PreferencesManager sharedManager] random];
        cell.textLabel.text = NSLocalizedString(@"Random", nil);
        
        UITableViewCellAccessoryType accessoryType;
        if(check){
            accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            accessoryType = UITableViewCellAccessoryNone;
        }
        
        cell.accessoryType = accessoryType;
        
    }else if(indexPath.section == TableSectionAbout){
        
        if(indexPath.row == TableAboutRowVersion){
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textLabel.text = NSLocalizedString(@"SET_Version", nil);
            cell.detailTextLabel.text = [SGUtil bundleVersion];
            
        }else if(indexPath.row == TableAboutLicense){
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = NSLocalizedString(@"SET_License", nil);
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == TableSectionCharacter){
        PreferencesManager *pref = [PreferencesManager sharedManager];
        
        if(indexPath.row == TableCharacterRowHiraZen){
            [pref setHiraZen:(![pref hiraZen])];
            
        }else if(indexPath.row == TableCharacterRowKataZen){
            [pref setKataZen:(![pref kataZen])];
            
        }else if(indexPath.row == TableCharacterRowKataHan){
            [pref setKataHan:(![pref kataHan])];
            
        }else if(indexPath.row == TableCharacterRowAlphabet){
            [pref setAlphabet:(![pref alphabet])];
            
        }else if(indexPath.row == TableCharacterRowNumeric){
            [pref setNumeric:(![pref numeric])];
            
        }
        
        [_table reloadData];
        
    }else if(indexPath.section == TableSectionRandom){
        PreferencesManager *pref = [PreferencesManager sharedManager];
        [pref setRandom:(![pref random])];
        
        [_table reloadData];
        
    }else if(indexPath.section == TableSectionAbout){
        if(indexPath.row == TableAboutLicense){
            [self _transitionToSetting];
        }
    }
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:[NSString stringWithFormat:@"SETTING/Table/%d,%d", indexPath.section, indexPath.row]
                                                     withAction:@"select"
                                                      withLabel:@""
                                                      withValue:nil];
}


#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self _changeNavigationBarButton:SettingControllerBarButtonModeEditText animated:YES];
    
    if(textField == self.stringCountField){
        //フォーカスがあたった時点で現在の内容を消去する
        self.temporaryStringCountText = self.stringCountField.text;
        self.stringCountField.text = nil;
        
        self.stringCountField.frame = CGRectMake(self.stringCountField.frame.origin.x,
                                                 self.stringCountField.frame.origin.y-4,
                                                 self.stringCountField.frame.size.width,
                                                 self.stringCountField.frame.size.height);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self _changeNavigationBarButton:SettingControllerBarButtonModeNormal animated:YES];
    
    if(textField == self.stringCountField){
        //もし何も入力されていなかった場合、前回入力内容をリストアする
        if(self.stringCountField.text == nil ||
           [self.stringCountField.text isEqualToString:@""]){
            self.stringCountField.text = self.temporaryStringCountText;
        }
        self.temporaryStringCountText = nil;
        
        self.stringCountField.frame = CGRectMake(self.stringCountField.frame.origin.x,
                                                 self.stringCountField.frame.origin.y+4,
                                                 self.stringCountField.frame.size.width,
                                                 self.stringCountField.frame.size.height);
        
        [[PreferencesManager sharedManager] setStringCount:[self.stringCountField.text integerValue]];
        
        
        [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"SETTING/StringCountField"
                                                         withAction:@"endEditing"
                                                          withLabel:@""
                                                          withValue:[NSNumber numberWithInteger:[self.stringCountField.text integerValue]]];
    }
}


#pragma mark - TouchLabel Delegate

- (void)touchLabelTouchesDidBegan:(TouchLabel *)label point:(CGPoint)point
{
    label.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
}

- (void)touchLabelTouchesDidEnded:(TouchLabel *)label point:(CGPoint)point
{
    label.backgroundColor = [UIColor clearColor];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ACCOUNT_URL]];
    
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"SETTING/Info"
                                                     withAction:@"tap"
                                                      withLabel:@""
                                                      withValue:nil];
}

- (void)touchLabelTouchesDidCanceled:(TouchLabel *)label point:(CGPoint)point
{
    label.backgroundColor = [UIColor clearColor];
}


@end
