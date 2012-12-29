#import <Foundation/Foundation.h>

#define HIRAGANA_SET_STRING @"あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽぁぃぅぇぉっゃゅょ"
#define KATAKANA_SET_STRING @"アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポッァィゥェォャュョヵヶヴ"
#define KATAKANA_HAN_SET_STRING @"ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝｯｬｭｮｧｨｩｪｫ"
#define ALPHABET_SET_STRING @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC_SET_STRING @"0123456789"

@interface SGRandom : NSObject

@property(nonatomic,assign) BOOL hiragana;
@property(nonatomic,assign) BOOL katakana;
@property(nonatomic,assign) BOOL katakanaHan;
@property(nonatomic,assign) BOOL alphabet;
@property(nonatomic,assign) BOOL numeric;
@property(nonatomic,assign) BOOL random;    //単一文字種を選択したとき、文字の並びをランダムにする
                                            //複数文字種の場合は指定に関係なくランダムにする

+ (SGRandom *)random;

+ (NSString *)hiraganaWithLength:(NSInteger)length;
+ (NSString *)hiraganaWithLength:(NSInteger)length random:(BOOL)random;
+ (NSString *)katakanaWithLength:(NSInteger)length;
+ (NSString *)katakanaWithLength:(NSInteger)length random:(BOOL)random;
+ (NSString *)katakanaHanWithLength:(NSInteger)length;
+ (NSString *)katakanaHanWithLength:(NSInteger)length random:(BOOL)random;
+ (NSString *)alphabetWithLength:(NSInteger)length;
+ (NSString *)alphabetWithLength:(NSInteger)length random:(BOOL)random;
+ (NSString *)numericWithLength:(NSInteger)length;
+ (NSString *)numericWithLength:(NSInteger)length random:(BOOL)random;

- (NSString *)stringWithLength:(NSInteger)length;

@end
