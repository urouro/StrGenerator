#import "PreferencesManager.h"


@implementation PreferencesManager

static NSString * const kFirst = @"First";
static NSString * const kDefaultText = @"DefaultText";
static NSString * const kStringCount = @"StringCount";
static NSString * const kHiraZen = @"HiraZen";
static NSString * const kKataZen = @"KataZen";
static NSString * const kKataHan = @"KataHan";
static NSString * const kAlphabet = @"Alphabet";
static NSString * const kNumeric = @"Numeric";
static NSString * const kRandom = @"Random";

static PreferencesManager *_sharedInstance = nil;

+ (PreferencesManager *)sharedManager
{
    if(!_sharedInstance){
        _sharedInstance = [[PreferencesManager alloc] init];
    }
    
    return _sharedInstance;
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark -

- (void)setFirst:(BOOL)first
{
    NSString *flg = (first)?@"YES":@"NO";
    
    [[NSUserDefaults standardUserDefaults] setObject:flg forKey:kFirst];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)first
{
    NSString *firstFlg = [[NSUserDefaults standardUserDefaults] stringForKey:kFirst];
    BOOL ret = YES;
    
    if([firstFlg isEqualToString:@""] || firstFlg == nil){
        ret = YES;
        
    }else if([firstFlg isEqualToString:@"NO"]){
        ret = NO;
        
    }else if([firstFlg isEqualToString:@"YES"]){
        ret = YES;
        
    }
    
    return ret;
}


- (void)setDefaultText:(NSString *)text
{
    [[NSUserDefaults standardUserDefaults] setObject:text forKey:kDefaultText];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)defaultText
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kDefaultText];
}

- (void)setStringCount:(NSInteger)count
{
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:kStringCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)stringCount
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kStringCount];
}


#pragma mark -

//全角かな
- (void)setHiraZen:(BOOL)bl
{
    [[NSUserDefaults standardUserDefaults] setBool:bl forKey:kHiraZen];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)hiraZen
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kHiraZen];
}

//全角カナ
- (void)setKataZen:(BOOL)bl
{
    [[NSUserDefaults standardUserDefaults] setBool:bl forKey:kKataZen];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)kataZen
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKataZen];
}

//半角カナ
- (void)setKataHan:(BOOL)bl
{
    [[NSUserDefaults standardUserDefaults] setBool:bl forKey:kKataHan];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)kataHan
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKataHan];
}

//英字
- (void)setAlphabet:(BOOL)bl
{
    [[NSUserDefaults standardUserDefaults] setBool:bl forKey:kAlphabet];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)alphabet
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kAlphabet];
}

//数字
- (void)setNumeric:(BOOL)bl
{
    [[NSUserDefaults standardUserDefaults] setBool:bl forKey:kNumeric];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)numeric
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kNumeric];
}

//ランダム
- (void)setRandom:(BOOL)bl
{
    [[NSUserDefaults standardUserDefaults] setBool:bl forKey:kRandom];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)random
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kRandom];
}


@end
