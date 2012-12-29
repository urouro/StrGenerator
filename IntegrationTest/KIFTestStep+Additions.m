#import "KIFTestStep+Additions.h"

@implementation KIFTestStep (Additions)


#pragma mark リセット
+ (id)stepToReset
{
    return [KIFTestStep stepWithDescription:@"初期化"
                             executionBlock:^(KIFTestStep *step, NSError **error) {
                                 
                                 BOOL successful = YES;
                                 
                                 KIFTestCondition(successful, error, @"初期化エラー");
                                 
                                 return KIFTestStepResultSuccess;
                             }];
}

#pragma mark クリップボードからコピーした内容をペーストする
+ (id)checkStepToPasteboardWithCopiedString:(NSString *)copiedString
{
    return [KIFTestStep stepWithDescription:@"クリップボードからコピーした内容をペーストする"
                             executionBlock:^(KIFTestStep *step, NSError **error) {
                                 
                                 BOOL successful = YES;
                                 
                                 // Do the actual reset for your app. Set successfulReset = NO if it fails.
                                 NSString *pasteStr = [[UIPasteboard generalPasteboard] valueForPasteboardType:@"public.utf8-plain-text"];
                                 
                                 if(![pasteStr isEqualToString:copiedString]){
                                     successful = NO;
                                 }
                                 
                                 KIFTestCondition(successful, error, @"コピー&ペーストエラー");
                                 
                                 return KIFTestStepResultSuccess;
                             }];
}

@end
