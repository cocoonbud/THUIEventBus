//
//  THUIEventBus.m
//  THUIEventBus
//
//  Created by JackLee on 2020/1/20.
//

#import "THUIEventBus.h"

@implementation THUIEventBus

+ (void)passingEventsUpwardsWithEventName:(nonnull NSString *)eventName
                                responder:(nonnull UIResponder *)responder
                                     data:(nullable id)data
                                 callback:(void(^)(id _Nullable otherData))callback {
    if (eventName.length < 1 || !responder || ![responder isKindOfClass:[UIResponder class]]) return;
 
    UIResponder <THUIEventBusProtocol> *curResponder = (UIResponder <THUIEventBusProtocol> *)responder.nextResponder;
    
    while (curResponder
           && ![curResponder isKindOfClass:[UIWindow class]]
           && ![curResponder isKindOfClass:[UIApplication class]]) {
        
        NSLog(@"🌺 curResponder responder is %@", NSStringFromClass([curResponder class]));
        
        if ([curResponder conformsToProtocol:@protocol(THUIEventBusProtocol)]) {
            if ([curResponder respondsToSelector:@selector(receivingUpwardPassedEventsWithEventName:data:callback:)]) {
                
                THUIEventResult res = [curResponder receivingUpwardPassedEventsWithEventName:eventName data:data callback:callback];
                
                if (res == THUIEventResultHandleAndContinue || res == THUIEventResultIgnoreAndContinue) {
                   curResponder = (UIResponder <THUIEventBusProtocol> *)curResponder.nextResponder;
                } else {
                    break;
                }
            } else {
               curResponder = (UIResponder <THUIEventBusProtocol> *)curResponder.nextResponder;
            }
        } else {
            curResponder = (UIResponder <THUIEventBusProtocol> *)curResponder.nextResponder;
        }
    }
}

+ (void)passingEventsDownWithEventName:(nonnull NSString *)eventName
                             responder:(nonnull UIResponder *)responder
                                  data:(nullable id)data
                              callback:(void(^)(id _Nullable otherData))callback {
    if (eventName.length < 1 || !responder || ![responder isKindOfClass:[UIResponder class]]) return;
    
    NSLog(@"🍊 cur responder is %@", NSStringFromClass([responder class]));
            
    if ([responder isKindOfClass:[UIViewController class]]) {
        UIViewController <THUIEventBusProtocol> *responderVC = (UIViewController <THUIEventBusProtocol> *)responder;
        
        if ([responderVC conformsToProtocol:@protocol(THUIEventBusProtocol)]
            && [responderVC respondsToSelector:@selector(receivingDownwardPassedEventsWithEventName:data:callback:)]) {
            
            THUIEventResult res = [responderVC receivingDownwardPassedEventsWithEventName:eventName data:data callback:callback];
            
            if (res == THUIEventResultHandleAndStop) return;
        }
        
        if (responderVC.childViewControllers.count > 0) {
            for (UIViewController *childVC in responderVC.childViewControllers) {
               [self passingEventsDownWithEventName:eventName responder:childVC data:data callback:callback];
            }
        }
        
        UIView <THUIEventBusProtocol> *view = (UIView <THUIEventBusProtocol> *)responderVC.view;
        
        if ([view conformsToProtocol:@protocol(THUIEventBusProtocol)]
            && [view respondsToSelector:@selector(receivingDownwardPassedEventsWithEventName:data:callback:)]) {
            
            THUIEventResult res = [view receivingDownwardPassedEventsWithEventName:eventName data:data callback:callback];
            
            if (res == THUIEventResultHandleAndStop) return;
        }
        
        if (responderVC.view.subviews.count > 0) {
            for (UIView *subview in responderVC.view.subviews) {
                [self passingEventsDownWithEventName:eventName responder:subview data:data callback:callback];
            }
        }
        
        return;
    }
    
    if ([responder isKindOfClass:[UIView class]]) {
        UIView <THUIEventBusProtocol> *view = (UIView <THUIEventBusProtocol> *)responder;
        
        if ([view conformsToProtocol:@protocol(THUIEventBusProtocol)]
            && [view respondsToSelector:@selector(receivingDownwardPassedEventsWithEventName:data:callback:)]) {
            
            THUIEventResult res = [view receivingDownwardPassedEventsWithEventName:eventName data:data callback:callback];
            
            if (res == THUIEventResultHandleAndStop) return;
        }
        
        if (view.subviews.count > 0) {
            for (UIView *subview in view.subviews) {
                [self passingEventsDownWithEventName:eventName responder:subview data:data callback:callback];
            }
        }
        return;
    }
}
@end
