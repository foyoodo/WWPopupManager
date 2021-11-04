//
//  WWPopupManager+Monitor.h
//  WanWu
//
//  Created by foyoodo on 2021/11/3.
//

#import "WWPopupManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface WWPopupManager (Monitor)

- (void)monitorDismissalOfTarget:(id<WWPopupManageable> _Nullable)target;

@end

NS_ASSUME_NONNULL_END
