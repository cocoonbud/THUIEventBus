//
//  SomeView1.m
//  EventBusTest
//
//  Created by Terence Yang on 2022/2/17.
//

#import "SomeView1.h"
#import "THUIEventBus.h"

@interface SomeView1()<THUIEventBusProtocol>

@property(nonatomic, strong) UIButton *actionBtn1;

@end

@implementation SomeView1

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.actionBtn1];
    }
    return self;
}

#pragma mark - actions
- (void)actionBtn1Clicked {
    NSLog(@"someView1 actionBtn1Clicked");
    
    [THUIEventBus passingEventsUpwardsWithEventName:@"someview1_actionBtn1Clicked"
                                          responder:self.actionBtn1
                                               data:@"123"
                                           callback:^(id  _Nullable otherData) {
        NSLog(@"someView1 action1 callback received");
    }];
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
    return THUIEventResultHandleAndContinue;
}

#pragma mark - layz load
- (UIButton *)actionBtn1 {
    if (!_actionBtn1) {
        _actionBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _actionBtn1.backgroundColor = [UIColor orangeColor];
        [_actionBtn1 setTitle:@"action1" forState:UIControlStateNormal];
        _actionBtn1.titleLabel.font = [UIFont systemFontOfSize:18];
        [_actionBtn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_actionBtn1 addTarget:self action:@selector(actionBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn1;
}

@end
