#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>

@interface ToolTipMenu : NSObject <RCTBridgeModule>

-(void)showInView:(UIView *)view withFrame:(CGRect)frame items: (NSArray *)items arrowDirection: (NSString *)arrowDirection;

@end
