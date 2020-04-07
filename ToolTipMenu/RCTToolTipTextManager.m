#import "RCTToolTipTextManager.h"

#import "RCTToolTipText.h"
#import <React/RCTBridge.h>

@implementation RCTToolTipTextManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(onChoice, RCTDirectEventBlock)

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

- (UIView *)view
{
    return [[RCTToolTipText alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

@end
