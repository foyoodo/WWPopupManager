//
//  WWPopupManager.m
//  WanWu
//
//  Created by foyoodo on 2021/9/14.
//

#import "WWPopupManager.h"
#import "WWPopupManager+Monitor.h"

dispatch_semaphore_t _globalShowLockSEM;

static void _WWPopupManagerInitGlobalSEM() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _globalShowLockSEM = dispatch_semaphore_create(1);
    });
}

@interface WWPopupManager ()

@property (nonatomic, strong) WWPopupPriorityList *popupList;

@end

@implementation WWPopupManager

+ (instancetype)sharedManager {
    static WWPopupManager *defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[self alloc] init];
    });
    return defaultManager;
}

+ (void)showWithConfig:(void (NS_NOESCAPE ^)(WWPopupPriority *priority, BOOL *interrupted))config
             showBlock:(WWPopupShowBlock)showBlock
          dismissBlock:(WWPopupDismissBlock)dismissBlock {
    [[self sharedManager] showWithConfig:config showBlock:showBlock dismissBlock:dismissBlock];
}

+ (void)showWithTarget:(id<WWPopupManageable>)target
                config:(void (NS_NOESCAPE ^)(WWPopupPriority *priority, BOOL *interrupted))config
             showBlock:(WWPopupShowBlock)showBlock
          dismissBlock:(WWPopupDismissBlock _Nullable)dismissBlock {
    [[self sharedManager] showWithTarget:target config:config showBlock:showBlock dismissBlock:dismissBlock];
}

+ (void)dismissIfDrop:(BOOL)drop {
    [[self sharedManager] dismissIfDrop:drop];
}

+ (void)cleanQueue {
    [[self sharedManager] cleanQueue];
}

- (instancetype)init {
    if (self = [super init]) {
        _WWPopupManagerInitGlobalSEM();
        _popupList = [[WWPopupPriorityList alloc] init];
    }
    return self;
}

- (void)showWithConfig:(void (NS_NOESCAPE ^)(WWPopupPriority *priority, BOOL *interrupted))config
             showBlock:(WWPopupShowBlock)showBlock
          dismissBlock:(WWPopupDismissBlock)dismissBlock {
    [self showWithTarget:nil config:config showBlock:showBlock dismissBlock:dismissBlock];
}

- (void)showWithTarget:(id<WWPopupManageable>)target
                config:(void (NS_NOESCAPE ^)(WWPopupPriority *priority, BOOL *interrupted))config
             showBlock:(WWPopupShowBlock)showBlock
          dismissBlock:(WWPopupDismissBlock)dismissBlock {
    dispatch_semaphore_wait(_globalShowLockSEM, DISPATCH_TIME_FOREVER);
    [self monitorDismissalOfTarget:target];
    WWPopupPriority priority = WWPopupPriorityLow;
    BOOL interrupted = NO;
    !config ?: config(&priority, &interrupted);
    [self->_popupList add:[WWPopupElement elementWithTarget:target priority:priority interrupted:interrupted showBlock:showBlock dismissBlock:dismissBlock]];
    WWPopupElement *front = self.popupList.front;
    if (front && !front.actived) {
        dispatch_async(dispatch_get_main_queue(), ^{
            !front.showBlock ?: front.showBlock();
        });
        front.actived = YES;
    }
    dispatch_semaphore_signal(_globalShowLockSEM);
}

- (void)dismissIfDrop:(BOOL)drop {
    WWPopupElement *activedPopup = self->_popupList.front;

    if (!activedPopup) {
        return;
    }

    if (!drop && activedPopup.dismissBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            activedPopup.dismissBlock();
        });
    }

    [self->_popupList popFront];

    WWPopupElement *front = self.popupList.front;
    if (front && !front.actived) {
        dispatch_async(dispatch_get_main_queue(), ^{
            !front.showBlock ?: front.showBlock();
        });
        front.actived = YES;
    }
}

- (void)cleanQueue {
    [self->_popupList clear];
}

@end
