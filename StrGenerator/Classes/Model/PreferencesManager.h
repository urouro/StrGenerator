#import <Foundation/Foundation.h>

@interface PreferencesManager : NSObject

+ (PreferencesManager *)sharedManager;

//初回
//初回でない場合、NOを設定
- (void)setFirst:(BOOL)first;
- (BOOL)first;

//テキストにセットする文字列
- (void)setDefaultText:(NSString *)text;
- (NSString *)defaultText;

//文字数
- (void)setStringCount:(NSInteger)count;
- (NSInteger)stringCount;

//全角かな
- (void)setHiraZen:(BOOL)bl;
- (BOOL)hiraZen;

//全角カナ
- (void)setKataZen:(BOOL)bl;
- (BOOL)kataZen;

//半角カナ
- (void)setKataHan:(BOOL)bl;
- (BOOL)kataHan;

//英字
- (void)setAlphabet:(BOOL)bl;
- (BOOL)alphabet;

//数字
- (void)setNumeric:(BOOL)bl;
- (BOOL)numeric;

//ランダム
- (void)setRandom:(BOOL)bl;
- (BOOL)random;

@end
