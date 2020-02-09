#import "ToolTipMenu.h"
#import "RCTToolTipText.h"
#import <React/RCTUIManager.h>

@implementation ToolTipMenu

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

-(void)showInView:(UIView *)view withFrame:(CGRect)frame items: (NSArray *)items arrowDirection: (NSString *)arrowDirection {
    NSArray *buttons = items;
    NSMutableArray *menuItems = [NSMutableArray array];
    for (NSString *buttonText in buttons) {
        NSString *sel = [NSString stringWithFormat:@"magic_%@", buttonText];
        [menuItems addObject:[[UIMenuItem alloc]
                              initWithTitle:buttonText
                              action:NSSelectorFromString(sel)]];
    }
    [view becomeFirstResponder];
    UIMenuController *menuCont = [UIMenuController sharedMenuController];
    [menuCont setTargetRect:frame inView:view.superview];

    [[NSNotificationCenter defaultCenter] addObserver:view selector:@selector(didHideMenu:) name:UIMenuControllerDidHideMenuNotification object:nil];


    if([arrowDirection isEqualToString: @"up"]){
      menuCont.arrowDirection = UIMenuControllerArrowUp;
    } else if ([arrowDirection isEqualToString: @"right"]){
      menuCont.arrowDirection = UIMenuControllerArrowRight;
    } else if ([arrowDirection isEqualToString: @"left"]) {
      menuCont.arrowDirection = UIMenuControllerArrowLeft;
    } else if ([arrowDirection isEqualToString: @"down"]) {
      menuCont.arrowDirection = UIMenuControllerArrowDown;
    } else {
      menuCont.arrowDirection = UIMenuControllerArrowDefault;
    }
    menuCont.menuItems = menuItems;
    [menuCont setMenuVisible:YES animated:YES];
}

RCT_EXPORT_METHOD(
                  show:(nonnull NSNumber *)reactTag
                  items: (NSArray *)items
                  arrowDirection: (NSString *)arrowDirection
                  )
{
    UIView *view = [self.bridge.uiManager viewForReactTag:reactTag];
    [self showInView:view withFrame:view.frame items:items arrowDirection:arrowDirection];
}

RCT_EXPORT_METHOD(
                  showWithPoint:(nonnull NSNumber *)reactTag
                  items: (NSArray *)items
                  arrowDirection: (NSString *)arrowDirection
                  x: (nonnull NSNumber *)x
                  y: (nonnull NSNumber *)y
                  )
{
    UIView *view = [self.bridge.uiManager viewForReactTag:reactTag];
    CGRect frame = CGRectMake(x.floatValue, y.floatValue, view.frame.size.width, view.frame.size.height);
    [self showInView:view withFrame:frame items:items arrowDirection:arrowDirection];
}

RCT_EXPORT_METHOD(
                  showWithFrame:(nonnull NSNumber *)reactTag
                  items: (NSArray *)items
                  arrowDirection: (NSString *)arrowDirection
                  x: (nonnull NSNumber *)x
                  y: (nonnull NSNumber *)y
                  width: (nonnull NSNumber *)width
                  height: (nonnull NSNumber *)height
                  )
{
    UIView *view = [self.bridge.uiManager viewForReactTag:reactTag];
    CGRect frame = CGRectMake(x.floatValue, y.floatValue, width.floatValue, height.floatValue);
    [self showInView:view withFrame:frame items:items arrowDirection:arrowDirection];
}

RCT_EXPORT_METHOD(hide){
    UIMenuController *menuCont = [UIMenuController sharedMenuController];
    [menuCont setMenuVisible:NO animated:NO];
}

@end
