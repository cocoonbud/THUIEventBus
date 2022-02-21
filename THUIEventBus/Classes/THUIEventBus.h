//
//  THUIEventBus.h
//  THUIEventBus
//
//  Created by JackLee on 2020/1/20.
//

#import <Foundation/Foundation.h>
#import "UIResponder+THUIEventBus.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, THUIEventResult) {
    THUIEventResultIgnoreAndContinue = 0,
    THUIEventResultHandleAndContinue,
    THUIEventResultHandleAndStop
};

@protocol THUIEventBusProtocol <NSObject>

@optional

/// receiving upward-passed events with event name
/// @param eventName event name
/// @param data data
/// @param callback after handle callback
- (THUIEventResult)receivingUpwardPassedEventsWithEventName:(nonnull NSString *)eventName data:(nullable id)data callback:(void(^_Nullable)(id _Nullable otherData))callback;


/// receiving downward-passed events with event name
/// @param eventName event name
/// @param data data
/// @param callback after handle callback
- (THUIEventResult)receivingDownwardPassedEventsWithEventName:(nonnull NSString *)eventName data:(nullable id)data callback:(void(^_Nullable)(id _Nullable otherData))callback;

@end


@interface THUIEventBus : NSObject

/// initial view –> super view –> ….. –> view controller –> window

/// Delivering events with the chain of event responders
/// @param eventName event name
/// @param responder responder
/// @param data data
/// @param callback after handle callback
+ (void)passingEventsUpwardsWithEventName:(nonnull NSString *)eventName responder:(nonnull UIResponder *)responder data:(nullable id)data callback:(void(^)(id _Nullable otherData))callback;


/// passing events down With event name
/// @param eventName event name
/// @param responder responder
/// @param data data
/// @param callback after handle callback
+ (void)passingEventsDownWithEventName:(nonnull NSString *)eventName responder:(nonnull UIResponder *)responder data:(nullable id)data callback:(void(^)(id _Nullable otherData))callback;

@end

NS_ASSUME_NONNULL_END
