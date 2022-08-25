//
//  WWPopupManager.h
//  WanWu
//
//  Created by foyoodo on 2021/9/14.
//

#import <Foundation/Foundation.h>
#import "WWPopupPriorityList.h"

NS_ASSUME_NONNULL_BEGIN

@interface WWPopupManager : NSObject

+ (instancetype)sharedManager;

+ (void)showWithConfig:(void (NS_NOESCAPE ^_Nullable)(WWPopupPriority *priority, BOOL *interrupted))config
             showBlock:(WWPopupShowBlock)showBlock
          dismissBlock:(WWPopupDismissBlock _Nullable)dismissBlock;

+ (void)showWithTarget:(id<WWPopupManageable>)target
                config:(void (NS_NOESCAPE ^_Nullable)(WWPopupPriority *priority, BOOL *interrupted))config
             showBlock:(WWPopupShowBlock)showBlock
          dismissBlock:(WWPopupDismissBlock _Nullable)dismissBlock;

+ (void)dismissIfDrop:(BOOL)drop;

+ (void)cleanQueue;

@end

NS_ASSUME_NONNULL_END
