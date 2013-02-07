//
//  UIImage+JBundleSupport.h
//  JStyle
//
//  Created by Jeremy Tregunna on 2012-12-15.
//  Copyright (c) 2012 Sponsiv Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JBundleSupport)
+ (UIImage*)imageNamed:(NSString*)name bundle:(NSBundle*)bundle;
@end
