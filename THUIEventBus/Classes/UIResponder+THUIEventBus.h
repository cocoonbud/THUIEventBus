//
//  UIResponder+THUIEventBus.h
//  THUIEventBus
//
//  Created by JackLee on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (THUIEventBus)

@property (nonatomic, weak, readonly) UIResponder *nextResponder;

@end

NS_ASSUME_NONNULL_END
