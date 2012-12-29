#import "KIFTestScenario+Additions.h"
#import "KIFTestStep+Additions.h"
#import "PreferencesManager.h"

#define INPUT_STRING @"あいうえおかきくけこさしすせそ"

@implementation KIFTestScenario (Additions)

#pragma mark 文字を入力できる
/**
 *  テキストをタップする
 *  テキストを入力する
 *  「閉じる」ボタンをタップする
 */
//+ (id)scenarioToInputText
//{
//    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"文字を入力できる"];
//    [scenario addStep:[KIFTestStep stepToReset]];
//    [scenario addStep:[KIFTestStep stepToEnterText:INPUT_STRING intoViewWithAccessibilityLabel:AC_TOP_TEXT]];
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:AC_TOP_CLOSE]];
//    
//    return scenario;
//}

#pragma mark 入力した文字がコピーできる
/**
 *  [テキストに文字を入力する]
 *  「コピー」ボタンをタップする
 */
+ (id)scenarioToCopyText
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"文字を入力し、コピーできる"];
    [scenario addStep:[KIFTestStep stepToEnterText:INPUT_STRING intoViewWithAccessibilityLabel:AC_TOP_TEXT]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:AC_TOP_CLOSE]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:AC_TOP_COPY]];
    [scenario addStep:[KIFTestStep checkStepToPasteboardWithCopiedString:INPUT_STRING]];
    
    return scenario;
}

#pragma mark 入力した文字を消去できる
/**
 *  [テキストに文字を入力する]
 *  「消去」ボタンをタップする
 */
+ (id)scenarioToDeleteText
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"文字を消去できる"];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:AC_TOP_TEXT]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:AC_TOP_DELETE]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:AC_TOP_CLOSE]];
    
    return scenario;
}

#pragma mark 設定〜文字数を設定する
/**
 *  「設定」ボタンをタップする
 *  文字数を入力する
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetStringCount
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"設定〜文字数を設定する"];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:AC_TOP_SETTING]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"100" intoViewWithAccessibilityLabel:AC_SET_STRINGCOUNT]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:AC_SET_CLOSE]];
    
    //ひらがなのみ
    PreferencesManager *pref = [PreferencesManager sharedManager];
    if(![pref hiraZen]){
        [scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:AC_SET_TABLE atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]]];
    }
    if([pref kataZen]){
        [scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:AC_SET_TABLE atIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]]];
    }
    if([pref kataHan]){
        [scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:AC_SET_TABLE atIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]]];
    }
    if([pref alphabet]){
        [scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:AC_SET_TABLE atIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]]];
    }
    if([pref numeric]){
        [scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:AC_SET_TABLE atIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]]];
    }
    if([pref random]){
        [scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:AC_SET_TABLE atIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]]];
    }
    
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:AC_SET_OK]];
    
    return scenario;
}

#pragma mark 全角ひらがなを設定する(非ランダム)
/**
 *  「設定」ボタンをタップする
 *  全角ひらがなにチェック
 *  ランダムにチェックしない
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetHiraganaNotRandom
{
    
}

#pragma mark 全角ひらがなを設定する(ランダム)
/**
 *  「設定」ボタンをタップする
 *  全角ひらがなにチェック
 *  ランダムにチェック
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetHiraganaRandom
{
    
}

#pragma mark 全角カタカナを設定する(非ランダム)
/**
 *  「設定」ボタンをタップする
 *  全角カタカナにチェック
 *  ランダムにチェックしない
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetKatakanaNotRandom
{
    
}

#pragma mark 全角カタカナを設定する(ランダム)
/**
 *  「設定」ボタンをタップする
 *  全角カタカナにチェック
 *  ランダムにチェックする
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetKatakanaRandom
{
    
}

#pragma mark 半角カタカナを設定する(非ランダム)
/**
 *  「設定」ボタンをタップする
 *  半角カタカナにチェックする
 *  ランダムにチェックしない
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetKatakanaHanNotRandom
{
    
}

#pragma mark 半角カタカナを設定する(ランダム)
/**
 *  「設定」ボタンをタップする
 *  半角カタカナにチェックする
 *  ランダムにチェックする
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetKatakanaHanRandom
{
    
}

#pragma mark アルファベットを設定する(非ランダム)
/**
 *  「設定」ボタンをタップする
 *  アルファベットにチェックする
 *  ランダムにチェックしない
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetAlphabetNotRandom
{
    
}

#pragma mark アルファベットを設定する(ランダム)
/**
 *  「設定」ボタンをタップする
 *  アルファベットにチェックする
 *  ランダムにチェックする
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetAlphabetRandom
{
    
}

#pragma mark 数字を設定する(非ランダム)
/**
 *  「設定」ボタンをタップする
 *  数字にチェックする
 *  ランダムにチェックしない
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetNumericNotRandom
{
    
}

#pragma mark 数字を設定する(ランダム)
/**
 *  「設定」ボタンをタップする
 *  数字にチェックする
 *  ランダムにチェックする
 *  他にチェックしない
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetNumericRandom
{
    
}

#pragma mark 全て設定する
/**
 *  「設定」ボタンをタップする
 *  全てチェックする
 *  「作成」ボタンをタップする
 */
+ (id)scenarioToSetAll
{
    
}


//設定をキャンセルする

@end
