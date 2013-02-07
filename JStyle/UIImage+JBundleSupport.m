//
//  UIImage+JBundleSupport.m
//  JStyle
//
//  Created by Jeremy Tregunna on 2012-12-15.
//  Copyright (c) 2012 Sponsiv Digital. All rights reserved.
//

#import "UIImage+JBundleSupport.h"

@implementation UIImage (BundleSupport)

+ (UIImage*)imageNamed:(NSString*)name bundle:(NSBundle*)bundle
{
    NSString* directory = [bundle bundlePath];
    NSString* pathExtension = name.pathExtension ?: @"png";
    NSString* suffix = [@"." stringByAppendingString:pathExtension];
    NSString* suffix2x = [NSString stringWithFormat:@"@2x.%@", pathExtension];
    NSString* name2x = [name stringByReplacingOccurrencesOfString:suffix withString:suffix2x];
    NSString* path = [directory stringByAppendingPathComponent:name];
    NSString* path2x = [directory stringByAppendingPathComponent:name2x];
    NSFileManager* fileManager = [NSFileManager defaultManager];

    if([[UIScreen mainScreen] scale] == 2.0)
    {
        if([fileManager fileExistsAtPath:path2x])
            return [UIImage imageWithContentsOfFile:path2x];
    }

    return ([fileManager fileExistsAtPath:path]) ? [UIImage imageWithContentsOfFile:path] : nil;
}

@end
