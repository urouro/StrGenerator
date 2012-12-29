#import "ScenarioTestController.h"
#import "KIFTestScenario+Additions.h"
#import "PreferencesManager.h"

@implementation ScenarioTestController

- (void)initializeScenarios
{
    [self addScenario:[KIFTestScenario scenarioToCopyText]];
    
    [self addScenario:[KIFTestScenario scenarioToDeleteText]];
    
    [self addScenario:[KIFTestScenario scenarioToSetStringCount]];
}

@end
