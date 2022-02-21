//
//  THUIEventBus.m
//  THUIEventBus
//
//  Created by JackLee on 2020/1/20.
//

#import "THUIEventBus.h"

@implementation THUIEventBus

#pragma mark - public
+ (void)passingEventsUpwardsWithEventName:(nonnull NSString *)eventName
                                responder:(nonnull UIResponder *)responder
                                     data:(nullable id)data
                                 callback:(void(^)(id _Nullable otherData))callback {
    if (eventName.length < 1 || !responder || ![responder isKindOfClass:[UIResponder class]]) return;
 
    UIResponder <THUIEventBusProtocol> *curResponder = (UIResponder <THUIEventBusProtocol> *)responder.thNextResponder;
    
    while (curResponder && ![curResponder isKindOfClass:[UIWindow class]] && ![curResponder isKindOfClass:[UIApplication class]]) {
        
        NSLog(@"🌺 cur responder is %@", NSStringFromClass([curResponder class]));
        
        if ([curResponder conformsToProtocol:@protocol(THUIEventBusProtocol)]) {
            if ([curResponder respondsToSelector:@selector(receivingUpwardPassedEventsWithEventName:data:callback:)]) {
                
                THUIEventResult res = [curResponder receivingUpwardPassedEventsWithEventName:eventName
                                                                                        data:data
                                                                                    callback:callback];
                
                if (res == THUIEventResultHandleAndStop) break;
            }
        }
        curResponder = (UIResponder <THUIEventBusProtocol> *)curResponder.thNextResponder;
    }
}

+ (void)passingEventsDownWithEventName:(nonnull NSString *)eventName
                             responder:(nonnull UIResponder *)responder
                                  data:(nullable id)data
                              callback:(void(^)(id _Nullable otherData))callback {
    if (eventName.length < 1 || !responder || ![responder isKindOfClass:[UIResponder class]]) return;
    
    NSLog(@"🍊 cur responder is %@", NSStringFromClass([responder class]));
    
    THUIEventResult res = THUIEventResultIgnoreAndContinue;
            
    if ([responder isKindOfClass:[UIViewController class]]) {
        UIViewController <THUIEventBusProtocol> *responderVC = (UIViewController <THUIEventBusProtocol> *)responder;
        
        if ([responderVC conformsToProtocol:@protocol(THUIEventBusProtocol)]
            && [responderVC respondsToSelector:@selector(receivingDownwardPassedEventsWithEventName:data:callback:)]) {
            
            res = [responderVC receivingDownwardPassedEventsWithEventName:eventName data:data callback:callback];
            
            if (res == THUIEventResultHandleAndStop) return;
        }
        
        for (UIViewController *childVC in responderVC.childViewControllers) {
           [self passingEventsDownWithEventName:eventName responder:childVC data:data callback:callback];
        }
        
        [THUIEventBus handleViewWithEventName:eventName responder:responderVC.view data:data callback:callback];
    }
    
    if ([responder isKindOfClass:[UIView class]]) {
        [THUIEventBus handleViewWithEventName:eventName responder:responder data:data callback:callback];
    }
}

#pragma mark - private
+ (void)handleViewWithEventName:(nonnull NSString *)eventName
                      responder:(nonnull UIResponder *)responder
                           data:(nullable id)data
                       callback:(void(^)(id _Nullable otherData))callback {
    THUIEventResult res = THUIEventResultIgnoreAndContinue;
    
    UIView <THUIEventBusProtocol> *view = (UIView <THUIEventBusProtocol> *)responder;
    
    if ([view conformsToProtocol:@protocol(THUIEventBusProtocol)]
        && [view respondsToSelector:@selector(receivingDownwardPassedEventsWithEventName:data:callback:)]) {
        
        res = [view receivingDownwardPassedEventsWithEventName:eventName data:data callback:callback];
        
        if (res == THUIEventResultHandleAndStop) return;
    }
    
    for (UIView *subview in view.subviews) {
        [self passingEventsDownWithEventName:eventName responder:subview data:data callback:callback];
    }
    
    return;
}
@end

