#import "SGRandomTest.h"
#import "SGRandom.h"

@implementation SGRandomTest

//--------------------------------------------------------------//
#pragma mark -Initialize-
//--------------------------------------------------------------//
- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

//--------------------------------------------------------------//
#pragma mark -
//--------------------------------------------------------------//
- (void)testHiraganaNotRandom
{
    for(int i=0; i<80+5; i++){
        NSString *randStr = [SGRandom hiraganaWithLength:i+1];
        GHTestLog(@"[len:%d] %@", i+1, randStr);
        
    }
}

- (void)testKatakanaNotRandom
{
    for(int i=0; i<83+5; i++){
        NSString *randStr = [SGRandom katakanaWithLength:i+1];
        GHTestLog(@"[len:%d] %@", i+1, randStr);
    }
}

- (void)testKatakanaHanNotRandom
{
    for(int i=0; i<55+5; i++){
        NSString *randStr = [SGRandom katakanaHanWithLength:i+1];
        GHTestLog(@"[len:%d] %@", i+1, randStr);
    }
}

- (void)testAlphabetNotRandom
{
    for(int i=0; i<52+5; i++){
        NSString *randStr = [SGRandom alphabetWithLength:i+1];
        GHTestLog(@"[len:%d] %@", i+1, randStr);
    }
}

- (void)testNumericNotRandom
{
    for(int i=0; i<10+5; i++){
        NSString *randStr = [SGRandom numericWithLength:i+1];
        GHTestLog(@"[len:%d] %@", i+1, randStr);
    }
}

- (void)testHiraganaRandom
{
    for(int i=0; i<5; i++){
        int r = arc4random()%15+1;
        NSString *randStr = [SGRandom hiraganaWithLength:r random:YES];
        GHTestLog(@"[len:%d] %@", r, randStr);
    }
}

- (void)testKatakanaRandom
{
    for(int i=0; i<5; i++){
        int r = arc4random()%15+1;
        NSString *randStr = [SGRandom katakanaWithLength:r random:YES];
        GHTestLog(@"[len:%d] %@", r, randStr);
    }
}

- (void)testKatakanaHanRandom
{
    for(int i=0; i<5; i++){
        int r = arc4random()%15+1;
        NSString *randStr = [SGRandom katakanaHanWithLength:r random:YES];
        GHTestLog(@"[len:%d] %@", r, randStr);
    }
}

- (void)testAlphabetRandom
{
    for(int i=0; i<5; i++){
        int r = arc4random()%15+1;
        NSString *randStr = [SGRandom alphabetWithLength:r random:YES];
        GHTestLog(@"[len:%d] %@", r, randStr);
    }
}

- (void)testNumericRandom
{
    for(int i=0; i<5; i++){
        int r = arc4random()%15+1;
        NSString *randStr = [SGRandom numericWithLength:r random:YES];
        GHTestLog(@"[len:%d] %@", r, randStr);
    }
}

//--------------------------------------------------------------//
#pragma mark -
//--------------------------------------------------------------//
- (void)testGenerateAllCharacterTypeAndRandom
{
    SGRandom *rd = [SGRandom random];
    rd.hiragana = YES;
    rd.katakana = YES;
    rd.katakanaHan = YES;
    rd.alphabet = YES;
    rd.numeric = YES;
    
    for(int i=0; i<5; i++){
        int r = arc4random()%15+1;
        NSString *str = [rd stringWithLength:r];
        
        //TODO: 複数の文字種がランダムに含まれて生成されているか確認
        GHTestLog(@"[len:%d] %@", r, str);
        
        GHAssertEquals([str length], (NSUInteger)r, @"指定した文字数で取得できている");
    }
}

- (void)testGenerateLongString_AllCharacterTypeAndRandom
{
    SGRandom *rd = [SGRandom random];
    rd.hiragana = YES;
    rd.katakana = YES;
    rd.katakanaHan = YES;
    rd.alphabet = YES;
    rd.numeric = YES;
    
    NSString *str = [rd stringWithLength:1000];
    
    //TODO: 複数の文字種がランダムに含まれて生成されているか確認
    GHTestLog(@"%@", str);
    
    GHAssertEquals([str length], (NSUInteger)1000, @"指定した文字数で取得できている");
}

#pragma mark -

- (void)testGenerateHiraganaOnlyAndNotRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.hiragana = YES;
    rd.random = NO;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: ひらがなのみが、ランダムでなく出力されていることを確認
    GHTestLog(@"%@", str);
}

- (void)testGenerateHiraganaOnlyAndRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.hiragana = YES;
    rd.random = YES;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: ひらがなのみが、ランダムに出力されていることを確認
    GHTestLog(@"%@", str);
}

- (void)testGenerateKatakanaOnlyAndNotRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.katakana = YES;
    rd.random = NO;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: カタカナ・非ランダム
    GHTestLog(@"%@", str);
}

- (void)testGenerateKatakanaOnlyAndRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.katakana = YES;
    rd.random = YES;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: カタカナ・ランダム
    GHTestLog(@"%@", str);
}

- (void)testGenerateKatakanaHanOnlyAndNotRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.katakanaHan = YES;
    rd.random = NO;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: 半角カタカナ・非ランダム
    GHTestLog(@"%@", str);
}

- (void)testGenerateKatakanaHanOnlyAndRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.katakanaHan = YES;
    rd.random = YES;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: 半角カタカナ・ランダム
    GHTestLog(@"%@", str);
}

- (void)testGenerateAlphabetOnlyAndNotRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.alphabet = YES;
    rd.random = NO;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: ABC・非ランダム
    GHTestLog(@"%@", str);
}

- (void)testGenerateAlphabetOnlyAndRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.alphabet = YES;
    rd.random = YES;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: ABC・ランダム
    GHTestLog(@"%@", str);
}

- (void)testGenerateNumericOnlyAndNotRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.numeric = YES;
    rd.random = NO;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: 数字・非ランダム
    GHTestLog(@"%@", str);
}

- (void)testGenerateNumericOnlyAndRandom
{
    NSInteger len = 100;
    NSString *str;
    
    SGRandom *rd = [SGRandom random];
    rd.numeric = YES;
    rd.random = YES;
    
    str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: 数字・ランダム
    GHTestLog(@"%@", str);
}

#pragma mark -

- (void)testGenerateNotHiragana
{
    NSInteger len = 100;
    
    SGRandom *rd = [SGRandom random];
    rd.katakana = YES;
    rd.katakanaHan = YES;
    rd.alphabet = YES;
    rd.numeric = YES;
    
    NSString *str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: ひらがなが含まれていない
    GHTestLog(@"%@", str);
}

- (void)testGenerateNotKatakana
{
    NSInteger len = 100;
    
    SGRandom *rd = [SGRandom random];
    rd.hiragana = YES;
    rd.katakanaHan = YES;
    rd.alphabet = YES;
    rd.numeric = YES;
    
    NSString *str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: カタカナが含まれていない
    GHTestLog(@"%@", str);
}

- (void)testGenerateNotKatakanaHan
{
    NSInteger len = 100;
    
    SGRandom *rd = [SGRandom random];
    rd.hiragana = YES;
    rd.katakana = YES;
    rd.alphabet = YES;
    rd.numeric = YES;
    
    NSString *str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: 半角カタカナが含まれていない
    GHTestLog(@"%@", str);
}

- (void)testGenerateNotAlphabet
{
    NSInteger len = 100;
    
    SGRandom *rd = [SGRandom random];
    rd.hiragana = YES;
    rd.katakana = YES;
    rd.katakanaHan = YES;
    rd.numeric = YES;
    
    NSString *str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: アルファベットが含まれていない
    GHTestLog(@"%@", str);
}

- (void)testGenerateNotNumeric
{
    NSInteger len = 100;
    
    SGRandom *rd = [SGRandom random];
    rd.hiragana = YES;
    rd.katakana = YES;
    rd.katakanaHan = YES;
    rd.alphabet = YES;
    
    NSString *str = [rd stringWithLength:len];
    
    GHAssertEquals([str length], (NSUInteger)len, @"指定した文字数で取得できている");
    
    //TODO: アルファベットが含まれていない
    GHTestLog(@"%@", str);
}

- (void)testGenerateNone
{
    NSInteger len = 100;
    
    SGRandom *rd = [SGRandom random];
    
    NSString *str = [rd stringWithLength:len];
    
    GHAssertNil(str, @"文字列が生成されていない");
}

@end
