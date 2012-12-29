#import "SGUtil.h"

@implementation SGUtil

+ (NSString *)bundleVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleVersion"];
}

@end
