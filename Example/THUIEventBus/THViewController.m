//
//  THViewController.m
//  THUIEventBus
//
//  Created by cocoonbud on 02/19/2022.
//  Copyright (c) 2022 cocoonbud. All rights reserved.
//

#import "THViewController.h"
#import "THUIEventBus.h"
#import "SomeView1.h"
#import "SomeView2.h"

@interface THViewController ()<THUIEventBusProtocol>

@property(nonatomic, strong) SomeView1 *someView1;

@property(nonatomic, strong) SomeView2 *someView2;

@end

@implementation THViewController

- (void)dealloc {
    NSLog(@"THViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.someView1];
    [self.view addSubview:self.someView2];
}

#pragma mark - THUIEventBusProtocol
- (THUIEventResult)receivingDownwardPassedEventsWithEventName:(nonnull NSString *)eventName
                                            data:(nullable id)data
                                        callback:(void(^)(id _Nullable otherData))callback {
    NSLog(@"THViewController %@", NSStringFromSelector(_cmd));
    return THUIEventResultIgnoreAndContinue;
}

- (THUIEventResult)receivingUpwardPassedEventsWithEventName:(nonnull NSString *)eventName data:(nullable id)data callback:(void(^)(id _Nullable otherData))callback {
    NSLog(@"THViewController %@", NSStringFromSelector(_cmd));
    [THUIEventBus passingEventsDownWithEventName:eventName responder:self data:@"123" callback:callback];
    return THUIEventResultHandleAndStop;
}

#pragma mark - lazy load
- (SomeView1 *)someView1 {
    if (!_someView1) {
        _someView1 = [[SomeView1 alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _someView1.backgroundColor = [UIColor greenColor];
    }
    return _someView1;
}

- (SomeView2 *)someView2 {
    if (!_someView2) {
        _someView2 = [[SomeView2 alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
        _someView2.backgroundColor = [UIColor blueColor];
    }
    return _someView2;
}
@end
