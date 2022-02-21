//
//  UIResponder+THUIEventBus.m
//  THUIEventBus
//
//  Created by JackLee on 2020/10/16.
//

#import "UIResponder+THUIEventBus.h"
#import <objc/runtime.h>

static const void *kNextResponderKey = "kNextResponderKey";

@implementation UIResponder (THUIEventBus)

- (void)setNextResponder:(UIResponder * _Nullable)nextResponder {
    if (nextResponder) objc_setAssociatedObject(self, kNextResponderKey, nextResponder, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIResponder *)nextResponder {
    id responser = objc_getAssociatedObject(self, kNextResponderKey);
    
    UIResponder *res = responser ? responser : nil;
    
    if (res) return res;
    
    return self.nextResponder;
}
@end
