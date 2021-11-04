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

- (void)showAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;
- (void)dismissAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
