#import "SGRandomTests.h"
#import "SGRandom.h"

@implementation SGRandomTests

- (void)setUp
{
    _random = [[SGRandom alloc] init];
}

- (void)tearDown
{
    [_random release], _random = nil;
}

#pragma mark - Tests
#pragma mark Hiragana

- (void)testLengthOfRandomHiragana
{
    NSString *kana = [SGRandom hiraganaWithLength:10];
    STAssertEquals([kana length], (NSUInteger)10, @"指定した長さの文字列を返す必要がある");
}

- (void)testMatchOfRandomHiragana
{
    NSString *kana = [SGRandom hiraganaWithLength:10];
    NSRange match = [kana rangeOfString:@"[あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽぁぃぅぇぉっゃゅょ]" options:NSRegularExpressionSearch];
    
    STAssertTrue(match.location != NSNotFound, @"平仮名以外が含まれている");
}

//TODO: 平仮名がランダムに含まれている

#pragma mark Katakana

- (void)testLengthOfRandomKatakana
{
    NSString *kana = [SGRandom katakanaWithLength:10];
    STAssertEquals([kana length], (NSUInteger)10, @"指定した長さの文字列を返す必要がある");
}

- (void)testMatchOfRandomKatakana
{
    NSString *kana = [SGRandom katakanaWithLength:10];
    NSRange match = [kana rangeOfString:@"[アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポッァィゥェォャュョヵヶヴ]" options:NSRegularExpressionSearch];
    STAssertTrue(match.location != NSNotFound, @"カタカナ以外が含まれている");
}

//TODO: カタカナがランダムに含まれている

#pragma mark Katakana(Han)

- (void)testLengthOfRandomKataHan
{
    
}

- (void)testMatchOfRandomKataHan
{
    
}

#pragma mark Alphabet

- (void)testLengthOfRandomAlphabet
{
    
}

- (void)testMatchOfRandomAlphabet
{
    
}

#pragma mark Numeric

- (void)testLengthOfRandomNumeric
{
    
}

- (void)testMatchOfRandomNumeric
{
    
}


@end
