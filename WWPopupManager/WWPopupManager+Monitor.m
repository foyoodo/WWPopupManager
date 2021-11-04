//
//  WWPopupManager+Monitor.m
//  WanWu
//
//  Created by foyoodo on 2021/11/3.
//

#import "WWPopupManager+Monitor.h"
#import <objc/runtime.h>

@implementation WWPopupManager (Monitor)

- (void)monitorDismissalOfTarget:(id<WWPopupManageable>)target {

    if (!target) {
        return;
    }

    Class clz = [target class];

    SEL originalSelector = @selector(dismissAnimated:completion:);
    SEL swizzledSelector = @selector(monitor_dismissAnimated:completion:);

    Method originalMethod = class_getInstanceMethod(clz, originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);

    NSAssert(originalMethod, @"You have to implement -dismissAnimated:completion:");

    IMP originalImp = class_getMethodImplementation(clz, originalSelector);
    IMP swizzledImp = class_getMethodImplementation([self class], swizzledSelector);

    if (originalImp != swizzledImp) {
        BOOL didAddMethod = class_addMethod(clz, swizzledSelector, originalImp, method_getTypeEncoding(originalMethod));
        if (didAddMethod) {
            class_replaceMethod(clz, originalSelector, swizzledImp, method_getTypeEncoding(swizzledMethod));
        } else {
            method_exchangeImplementations(class_getInstanceMethod(clz, originalSelector), class_getInstanceMethod(clz, swizzledSelector));
        }
    }

}

- (void)monitor_dismissAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    [self monitor_dismissAnimated:animated completion:^{
        !completion ?: completion();
        [WWPopupManager dismissIfDrop:NO];
    }];
}

@end
