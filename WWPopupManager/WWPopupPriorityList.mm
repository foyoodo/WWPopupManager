//
//  WWPopupPriorityList.mm
//  WanWu
//
//  Created by foyoodo on 2021/9/16.
//

#import "WWPopupPriorityList.h"
#include <list>

using namespace std;

@interface WWPopupPriorityList () {
    list<WWPopupElement *> _list;
}

@end

@implementation WWPopupPriorityList

- (WWPopupElement *)front {
    return _list.front();
}

- (void)popFront {
    _list.pop_front();
}

- (void)add:(WWPopupElement *)element {
    auto it = _list.begin();
    while (it != _list.end()) {
        WWPopupElement *elem = *it;
        if (elem.priority < element.priority && !elem.actived) {
            break;
        }
        ++it;
    }
    list<WWPopupElement *>::reverse_iterator r_it(it);
    if (r_it != _list.rend()) {
        WWPopupElement *elem = *r_it;
        if (!elem.actived && element.interrupted) {
            return;
        }
    }
    _list.insert(it, element);
}

@end


@implementation WWPopupElement

+ (instancetype)elementWithTarget:(id<WWPopupManageable>)target
                         priority:(WWPopupPriority)priority
                      interrupted:(BOOL)interrupted
                        showBlock:(WWPopupShowBlock)showBlock
                     dismissBlock:(WWPopupDismissBlock)dismissBlock {
    return [[self alloc] initWithTarget:target priority:priority interrupted:interrupted showBlock:showBlock dismissBlock:dismissBlock];
}

- (instancetype)initWithTarget:(id<WWPopupManageable>)target
                      priority:(WWPopupPriority)priority
                   interrupted:(BOOL)interrupted
                     showBlock:(WWPopupShowBlock)showBlock
                  dismissBlock:(WWPopupDismissBlock)dismissBlock {
    if (self = [super init]) {
        _actived = NO;
        _target = target;
        _priority = priority;
        _interrupted = interrupted;
        _showBlock = showBlock;
        _dismissBlock = dismissBlock;
    }
    return self;
}

@end
