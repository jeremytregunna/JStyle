//
//  JStyleProxy.m
//  JStyle
//
//  Created by Jeremy Tregunna on 2012-12-15.
//  Copyright (c) 2012 Jeremy Tregunna. All rights reserved.
//

#import "JStyleProxy.h"
#import "JStyle.h"

@implementation JStyleProxy
{
    UIViewController<JStyleService>* _viewController;
}

+ (instancetype)proxyWithViewController:(UIViewController<JStyleService>*)viewController
{
    JStyleProxy* proxy = [self alloc];
    proxy->_viewController = viewController;
    return proxy;
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
	return [[JStyle style] methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation*)anInvocation
{
    NSString* arg;
    [anInvocation getArgument:&arg atIndex:2];
    NSString* str = [NSString stringWithFormat:@"%@.%@", _viewController.serviceName, arg];
	[anInvocation setTarget:[JStyle style]];
    [anInvocation setArgument:&str atIndex:2];
	[anInvocation invoke];
}

@end
