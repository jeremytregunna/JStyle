//
//  JStyleProxy.h
//  JStyle
//
//  Created by Jeremy Tregunna on 2012-12-15.
//  Copyright (c) 2012 Jeremy Tregunna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JStyleService;

@interface JStyleProxy : NSProxy
+ (instancetype)proxyWithViewController:(UIViewController<JStyleService>*)viewController;
@end
