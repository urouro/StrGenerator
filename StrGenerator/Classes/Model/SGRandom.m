#import "SGRandom.h"

typedef enum {
    SGCharacterTypeHiragana,
    SGCharacterTypeKatakana,
    SGCharacterTypeKatakanaHan,
    SGCharacterTypeAlphabet,
    SGCharacterTypeNumeric,
} SGCharacterType;

@implementation SGRandom
@synthesize hiragana = _hiragana;
@synthesize katakana = _katakana;
@synthesize katakanaHan = _katakanaHan;
@synthesize alphabet = _alphabet;
@synthesize numeric = _numeric;
@synthesize random = _random;


#pragma mark - Initialize

- (id)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self.hiragana = NO;
    self.katakana = NO;
    self.katakanaHan = NO;
    self.alphabet = NO;
    self.numeric = NO;
    self.random = NO;
    
    return self;
}

+ (SGRandom *)random
{
    SGRandom *obj = [[[SGRandom alloc] init] autorelease];
    return obj;
}


#pragma mark -

- (NSString *)stringWithLength:(NSInteger)length
{
    //選択対象の文字種
    NSMutableArray *enableType = [NSMutableArray arrayWithCapacity:0];
    if(self.hiragana){
        [enableType addObject:[NSNumber numberWithInteger:SGCharacterTypeHiragana]];
    }
    if(self.katakana){
        [enableType addObject:[NSNumber numberWithInteger:SGCharacterTypeKatakana]];
    }
    if(self.katakanaHan){
        [enableType addObject:[NSNumber numberWithInteger:SGCharacterTypeKatakanaHan]];
    }
    if(self.alphabet){
        [enableType addObject:[NSNumber numberWithInteger:SGCharacterTypeAlphabet]];
    }
    if(self.numeric){
        [enableType addObject:[NSNumber numberWithInteger:SGCharacterTypeNumeric]];
    }
    
    //どの文字種もNOだった場合
    if([enableType count] == 0){
        return nil;
    }
    
    NSString *str = @"";
    
    //指定文字種が一種類の場合
    if([enableType count] == 1){
        
        SGCharacterType type = [[enableType objectAtIndex:0] integerValue];
        
        if(type == SGCharacterTypeHiragana){
            str = [SGRandom hiraganaWithLength:length random:self.random];
            
        }else if(type == SGCharacterTypeKatakana){
            str = [SGRandom katakanaWithLength:length random:self.random];
            
        }else if(type == SGCharacterTypeKatakanaHan){
            str = [SGRandom katakanaHanWithLength:length random:self.random];
            
        }else if(type == SGCharacterTypeAlphabet){
            str = [SGRandom alphabetWithLength:length random:self.random];
            
        }else if(type == SGCharacterTypeNumeric){
            str = [SGRandom numericWithLength:length random:self.random];
            
        }
        
    }else{
    
        while([str length] < length){
            //選択可能な文字種からランダムに選択する
            SGCharacterType type = [[enableType objectAtIndex:arc4random()%[enableType count]] integerValue];
            LOG(@"type=%d", type);
            
            NSInteger l;
            
            //1〜lengthの範囲で文字列を取得する
            //l = arc4random()%length+1;
            
            //固定
            l = 1;
            
            NSString *append;
            
            if(type == SGCharacterTypeHiragana){
                append = [SGRandom hiraganaWithLength:l random:YES];
                
            }else if(type == SGCharacterTypeKatakana){
                append = [SGRandom katakanaWithLength:l random:YES];
                
            }else if(type == SGCharacterTypeKatakanaHan){
                append = [SGRandom katakanaHanWithLength:l random:YES];
                
            }else if(type == SGCharacterTypeAlphabet){
                append = [SGRandom alphabetWithLength:l random:YES];
                
            }else if(type == SGCharacterTypeNumeric){
                append = [SGRandom numericWithLength:l random:YES];
                
            }
            
            str = [str stringByAppendingString:append];
        }
        
    }
    
    return str;
}



#pragma mark -

//ひらがな

+ (NSString *)hiraganaWithLength:(NSInteger)length
{
    return [SGRandom hiraganaWithLength:length random:NO];
}

+ (NSString *)hiraganaWithLength:(NSInteger)length random:(BOOL)random
{
    return [SGRandom _generateTextFromString:HIRAGANA_SET_STRING length:length random:random];
}

//カタカナ

+ (NSString *)katakanaWithLength:(NSInteger)length
{
    return [SGRandom katakanaWithLength:length random:NO];
}

+ (NSString *)katakanaWithLength:(NSInteger)length random:(BOOL)random
{
    return [SGRandom _generateTextFromString:KATAKANA_SET_STRING length:length random:random];
}

//ｶﾀｶﾅ

+ (NSString *)katakanaHanWithLength:(NSInteger)length
{
    return [SGRandom katakanaHanWithLength:length random:NO];
}

+ (NSString *)katakanaHanWithLength:(NSInteger)length random:(BOOL)random
{
    return [SGRandom _generateTextFromString:KATAKANA_HAN_SET_STRING length:length random:random];
}

//ABC

+ (NSString *)alphabetWithLength:(NSInteger)length
{
    return [SGRandom alphabetWithLength:length random:NO];
}

+ (NSString *)alphabetWithLength:(NSInteger)length random:(BOOL)random
{
    return [SGRandom _generateTextFromString:ALPHABET_SET_STRING length:length random:random];
}

//123

+ (NSString *)numericWithLength:(NSInteger)length
{
    return [SGRandom numericWithLength:length random:NO];
}

+ (NSString *)numericWithLength:(NSInteger)length random:(BOOL)random
{
    return [SGRandom _generateTextFromString:NUMERIC_SET_STRING length:length random:random];
}


#pragma mark Common

+ (NSString *)_generateTextFromString:(NSString *)setStr length:(NSInteger)length random:(BOOL)random
{
    NSMutableString *str = [NSMutableString string];
    
    for(int i=0; i<length; i++){
        NSInteger r;
        
        if(random){
            r = arc4random()%[setStr length];
        }else{
            r = i;
            
            while(r >= [setStr length]){
                r = r - [setStr length];
            }
        }
        
        NSString *c = [setStr substringWithRange:NSMakeRange(r, 1)];
        
        [str appendString:c];
    }
    
    return str;
}

@end
