//
//  SomeView2.m
//  EventBusTest
//
//  Created by Terence Yang on 2022/2/17.
//

#import "SomeView2.h"
#import "THUIEventBus.h"

@interface SomeView2()<THUIEventBusProtocol>

@property(nonatomic, strong) UIButton *actionBtn1;

@end

@implementation SomeView2

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.actionBtn1];
    }
    return self;
}

#pragma mark - actions
- (void)actionBtn1Clicked {
    
}

#pragma mark - THUIEventBusProtocol
- (THUIEventResult)receivingUpwardPassedEventsWithEventName:(nonnull NSString *)eventName
                                                       data:(nullable id)data
                                                   callback:(void(^)(id _Nullable otherData))callback {
    NSLog(@"%@ %@", [self class],NSStringFromSelector(_cmd));
    return THUIEventResultHandleAndContinue;
}

- (THUIEventResult)receivingDownwardPassedEventsWithEventName:(nonnull NSString *)eventName
                                                         data:(nullable id)data
                                                     callback:(void(^)(id _Nullable otherData))callback {
    NSLog(@"%@ %@", [self class],NSStringFromSelector(_cmd));
    
    if (callback) {
        callback(data);
    }
    
    return THUIEventResultHandleAndContinue;
}

#pragma mark - lazy load
- (UIButton *)actionBtn1 {
    if (!_actionBtn1) {
        _actionBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _actionBtn1.backgroundColor = [UIColor purpleColor];
        _actionBtn1.titleLabel.font = [UIFont systemFontOfSize:18];
        [_actionBtn1 setTitle:@"action2" forState:UIControlStateNormal];
        [_actionBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_actionBtn1 addTarget:self action:@selector(actionBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn1;
}

@end
