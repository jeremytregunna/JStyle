//
//  UIViewController+JStyle.m
//  JStyle
//
//  Created by Jeremy Tregunna on 2012-12-15.
//  Copyright (c) 2012 Jeremy Tregunna. All rights reserved.
//

#import "UIViewController+JStyle.h"
#import "JStyle.h"

@implementation UIViewController (JStyle)
- (id)style
{
    if([self conformsToProtocol:@protocol(JStyleService)] == YES)
        return [JStyleProxy proxyWithViewController:(UIViewController<JStyleService>*)self];
    return nil;
}

@end
