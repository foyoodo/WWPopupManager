//
//  WWPopupManageable.h
//  WanWu
//
//  Created by foyoodo on 2021/11/3.
//

#import <Foundation/Foundation.h>
#import "WWPopupManagerConstant.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WWPopupManageable <NSObject>

- (void)showAnimated:(BOOL)flag completion:(WWPopupCompletionBlock _Nullable)completion;
- (void)dismissAnimated:(BOOL)flag completion:(WWPopupCompletionBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
