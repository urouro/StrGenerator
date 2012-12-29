#import "KIFTestStep.h"

@interface KIFTestStep (Additions)

+ (id)stepToReset;
+ (id)checkStepToPasteboardWithCopiedString:(NSString *)copiedString;

@end
