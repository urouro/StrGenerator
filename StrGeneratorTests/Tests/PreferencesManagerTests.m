#import "PreferencesManagerTests.h"
#import "PreferencesManager.h"

@implementation PreferencesManagerTests

- (void)setUp
{
    _manager = [PreferencesManager sharedManager];
}

- (void)tearDown
{
    
}

- (void)testThatSharedManager
{   
    STAssertTrue([_manager isKindOfClass:[PreferencesManager class]], @"");
}

- (void)testThatHiraZenForTrue
{
    [_manager setHiraZen:YES];
    
    STAssertTrue([_manager hiraZen], @"");
}

- (void)testThatHiraZenForFalse
{
    [_manager setHiraZen:NO];
    
    STAssertFalse([_manager hiraZen], @"");
}

- (void)testThatKataZenForTrue
{
    [_manager setKataZen:YES];
    
    STAssertTrue([_manager kataZen], @"");
}

- (void)testThatKataZenForFalse
{
    [_manager setKataZen:NO];
    
    STAssertFalse([_manager kataZen], @"");
}

- (void)testThatKataHanForTrue
{
    [_manager setKataHan:YES];
    
    STAssertTrue([_manager kataHan], @"");
}

- (void)testThatKataHanForFalse
{
    [_manager setKataHan:NO];
    
    STAssertFalse([_manager kataHan], @"");
}

- (void)testThatAlphabetForTrue
{
    [_manager setAlphabet:YES];
    
    STAssertTrue([_manager alphabet], @"");
}

- (void)testThatAlphabetForFalse
{
    [_manager setAlphabet:NO];
    
    STAssertFalse([_manager alphabet], @"");
}

- (void)testThatNumericForTrue
{
    [_manager setNumeric:YES];
    
    STAssertTrue([_manager numeric], @"");
}

- (void)testThatNumericForFalse
{
    [_manager setNumeric:NO];
    
    STAssertFalse([_manager numeric], @"");
}

- (void)testThatRandomForTrue
{
    [_manager setRandom:YES];
    
    STAssertTrue([_manager random], @"");
}

- (void)testThatRandomForFalse
{
    [_manager setRandom:NO];
    
    STAssertFalse([_manager random], @"");
}

@end
