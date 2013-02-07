//
//  JStyle.m
//  JStyle
//
//  Created by Jeremy Tregunna on 2012-12-14.
//  Copyright (c) 2012 Jeremy Tregunna. All rights reserved.
//

#import "JStyle.h"
#import "UIImage+JBundleSupport.h"
#import <CoreText/CTFontManager.h>
#import <CoreText/CTFontManagerErrors.h>

@interface JStyle ()
@property (nonatomic, strong) NSBundle* styleBundle;
@property (nonatomic, copy) NSDictionary* styleDictionary;
@end

@implementation JStyle

+ (instancetype)style
{
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL* bundleURL = [[NSBundle mainBundle] URLForResource:JSTYLE_BUNDLE_NAME withExtension:@"style"];
        shared = [[self alloc] initWithStyleBundle:[[NSBundle alloc] initWithURL:bundleURL]];
    });
    return shared;
}

- (id)initWithStyleBundle:(NSBundle*)bundle
{
    if((self = [super init]))
    {
        NSError* error = nil;
        [bundle loadAndReturnError:&error];
        self.styleBundle = bundle;
        NSURL* styleURL = [bundle URLForResource:@"Style" withExtension:@"plist"];
        self.styleDictionary = [NSDictionary dictionaryWithContentsOfURL:styleURL];
        [self registerAllFonts];
    }
    return self;
}

#pragma mark - Colours

- (UIColor*)colorForScope:(NSString*)scope
{
    NSString* colorString = _styleDictionary[[@"color." stringByAppendingString:scope]];

    if(colorString == nil)
        return nil;
    
    if([colorString hasPrefix:@"#"])
        colorString = [colorString substringFromIndex:1];
    
    NSAssert([colorString length] == 8, @"Invalid color string. A valid color string has 8 characters covering 4 bytes encoded in hexdecimal. Format is RGBA.");
    
    NSRange range = (NSRange){ .location = 0, .length = 2 };
    NSString* redString = [colorString substringWithRange:range];
    range.location = 2;
    NSString* greenString = [colorString substringWithRange:range];
    range.location = 4;
    NSString* blueString = [colorString substringWithRange:range];
    range.location = 6;
    NSString* alphaString = [colorString substringWithRange:range];
    
    unsigned int red, green, blue, alpha;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    [[NSScanner scannerWithString:alphaString] scanHexInt:&alpha];
    
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha / 255.0f];
}

#pragma mark - Images

- (UIColor*)patternForScope:(NSString*)scope
{
    UIImage* patternImage = [self _imageForScope:scope type:@"pattern"];
    if(patternImage != nil)
        return [UIColor colorWithPatternImage:patternImage];
    // Fallback to colour if available.
    return [self colorForScope:scope];
}

- (UIImage*)imageForScope:(NSString*)scope
{
    return [self _imageForScope:scope type:@"image"];
}

- (UIImage*)_imageForScope:(NSString*)scope type:(NSString*)type
{
    NSString* imageName = [_styleDictionary objectForKey:[NSString stringWithFormat:@"%@.%@", type, scope]];
    return [UIImage imageNamed:imageName bundle:self.styleBundle];
}

#pragma mark - Fonts

- (UIFont*)fontForScope:(NSString*)scope
{
    NSDictionary* fontInfo = [_styleDictionary objectForKey:[@"font." stringByAppendingString:scope]];
    UIFont* font = [UIFont fontWithName:fontInfo[@"name"] size:[fontInfo[@"size"] floatValue]];
    if(font != nil)
        return font;

    // Fallback to default font.
    fontInfo = _styleDictionary[@"font.default"];
    return [UIFont fontWithName:fontInfo[@"name"] size:[fontInfo[@"size"] floatValue]];
}

- (void)registerAllFonts
{
    for(NSString* extension in @[@".otf", @".ttf"])
    {
        NSArray* fontFiles = [self.styleBundle URLsForResourcesWithExtension:extension subdirectory:nil];
        [fontFiles enumerateObjectsUsingBlock:^(NSURL* fontURL, NSUInteger idx, BOOL *stop) {
            NSError* error = nil;
            NSData* fontData = [NSData dataWithContentsOfURL:fontURL options:NSDataReadingMappedIfSafe error:&error];
            if(error != nil)
                *stop = YES;

            [self registerFontWithData:fontData];
        }];
    }
}

- (void)registerFontWithData:(NSData*)fontData
{
    CFErrorRef error;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)fontData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    if(!CTFontManagerRegisterGraphicsFont(font, &error))
    {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
#ifdef DEBUG
        NSLog(@"Error loading font: %@", errorDescription);
#endif
        CFRelease(errorDescription);
    }
    CFRelease(font);
    CFRelease(provider);
}

@end
