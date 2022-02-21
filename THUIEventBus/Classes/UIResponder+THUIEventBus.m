//
//  UIResponder+THUIEventBus.m
//  THUIEventBus
//
//  Created by JackLee on 2020/10/16.
//

#import "UIResponder+THUIEventBus.h"
#import <objc/runtime.h>

static const void *kThNextResponderKey = "thNextResponderKey";

@implementation UIResponder (THUIEventBus)

- (void)setThNextResponder:(UIResponder * _Nullable)thNextResponder {
    if (thNextResponder) objc_setAssociatedObject(self, kThNextResponderKey, thNextResponder, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIResponder *)thNextResponder {
    id responser = objc_getAssociatedObject(self, kThNextResponderKey);
    
    UIResponder *res = responser ? responser : nil;
    
    if (res) return res;
    
    return self.nextResponder;
}
@end
