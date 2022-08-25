//
//  WWPopupPriorityList.h
//  WanWu
//
//  Created by foyoodo on 2021/9/16.
//

#import <Foundation/Foundation.h>
#import "WWPopupManagerConstant.h"
#import "WWPopupManageable.h"

NS_ASSUME_NONNULL_BEGIN

@class WWPopupElement;

@interface WWPopupPriorityList : NSObject

- (WWPopupElement *)front;
- (void)popFront;
- (void)add:(WWPopupElement *)element;
- (void)clear;

@end

@interface WWPopupElement : NSObject

+ (instancetype)elementWithTarget:(id<WWPopupManageable> _Nullable)target
                         priority:(WWPopupPriority)priority
                      interrupted:(BOOL)interrupted
                        showBlock:(WWPopupShowBlock)showBlock
                     dismissBlock:(WWPopupDismissBlock)dismissBlock;

- (instancetype)initWithTarget:(id<WWPopupManageable> _Nullable)target
                      priority:(WWPopupPriority)priority
                   interrupted:(BOOL)interrupted
                     showBlock:(WWPopupShowBlock)showBlock
                  dismissBlock:(WWPopupDismissBlock)dismissBlock;

@property (nonatomic, strong) id<WWPopupManageable> target;

@property (nonatomic, assign) BOOL                  actived;                    //!< 激活状态
@property (nonatomic, assign) BOOL                  interrupted;                //!< 中断标识

@property (nonatomic, assign) WWPopupPriority       priority;                   //!< 优先级

@property (nonatomic,   copy) WWPopupShowBlock      showBlock;
@property (nonatomic,   copy) WWPopupDismissBlock   dismissBlock;

@end

NS_ASSUME_NONNULL_END
