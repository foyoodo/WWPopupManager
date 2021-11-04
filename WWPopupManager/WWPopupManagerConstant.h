//
//  WWPopupManagerConstant.h
//  WanWu
//
//  Created by foyoodo on 2021/11/3.
//

#ifndef WWPopupManagerConstant_h
#define WWPopupManagerConstant_h

typedef NS_ENUM(NSUInteger, WWPopupPriority) {
    WWPopupPriorityLow     = 1,
    WWPopupPriorityDefault = 50,
    WWPopupPriorityHigh    = 100,
};

typedef void(^WWPopupShowBlock)(void);
typedef void(^WWPopupDismissBlock)(void);

#endif /* WWPopupManagerConstant_h */
