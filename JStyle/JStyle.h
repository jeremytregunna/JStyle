//
//  JStyle.h
//  JStyle
//
//  Created by Jeremy Tregunna on 2012-12-14.
//  Copyright (c) 2012 Jeremy Tregunna. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef JSTYLE_BUNDLE_NAME
    #define JSTYLE_BUNDLE_NAME @"Default"
#endif

@protocol JStyleService <NSObject>
@required
- (NSString*)serviceName;
@end

// A style covers the whole style of the application.
// It loads a bundle based on the JSTYLE_BUNDLE_NAME constant definition in the
// Precompiled header. To change the bundle name, change that constant.
@interface JStyle : NSObject

/** @name Creating styles */

/**
 * Returns a single instance of JStyle.
 *
 * This method is not the only way to create an instance, it just happens to be convenient.
 */
+ (instancetype)style;

/**
 * Initializes a style.
 *
 * This method sets up a JStyle instance given an NSBundle which contains a "Style.plist" file within its contents.
 *
 * @param bundle NSBundle to the style bundle.
 */
- (id)initWithStyleBundle:(NSBundle*)bundle;

/** @name Dealing with assets */

/**
 * Loads the defined color for the scope.
 *
 * @param scope A string identifying the color to load.
 */
- (UIColor*)colorForScope:(NSString*)scope;

/**
 * Loads a color that is backed by a pattern image for the scope.
 *
 * @param scope A string identifying the pattern to load.
 */
- (UIColor*)patternForScope:(NSString*)scope;

/**
 * Loads an image for the scope.
 *
 * @param scope A string identifying the image to load.
 */
- (UIImage*)imageForScope:(NSString*)scope;

/**
 * Loads a font for the scope.
 *
 * @param scope A string identifying the font to load.
 */
- (UIFont*)fontForScope:(NSString*)scope;

@end
