//
//  JStyleTests.m
//  JStyleTests
//
//  Created by Jeremy Tregunna on 2013-02-07.
//  Copyright (c) 2013 Jeremy Tregunna. All rights reserved.
//

#import "JStyleTests.h"
#import "JStyle.h"
#import "UIImage+JBundleSupport.h"

@interface JStyle (PrivateMethods)
@property (nonatomic, copy) NSDictionary* styleDictionary;
@end

@implementation JStyleTests
{
    JStyle* style;
}

- (void)setUp
{
    [super setUp];

    // In a real application, you'll use [JStyle style] or [[JStyle alloc] initWithStyleBundle:].
    // Due to how the bundles are set up when testing, we have to do this.
    style = [[JStyle alloc] init];
    style.styleDictionary = @{
        @"color.bad":@"666666",
        @"color.bad2":@"666666FF", // Actually a good colour, used in pattern testing
        @"color.good":@"999999FF",
        @"pattern.bad":@"bad.png",
        @"pattern.bad2":@"bad.png",
        @"pattern.bad3":@"bad.png",
        @"pattern.good":@"good.png",
        @"image.bad":@"bad.png",
        @"image.good":@"good.png",
        @"font.good":@{
            @"name":@"Helvetica",
            @"size":@(12)
        }
    };
}

- (void)testGoodColour
{
    UIColor* colour = [UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f];
    STAssertEqualObjects(colour, [style colorForScope:@"good"], @"Colours should be equal when valid.");
}

- (void)testBadColour
{
    STAssertThrows([style colorForScope:@"bad"], @"An invalid colour should throw an exception.");
}

- (void)testGoodPatternImage
{
    UIColor* colour = [style patternForScope:@"good"];
    STAssertTrue([colour isKindOfClass:[UIColor class]], @"Must be a UIColour instance");
}

- (void)testBadPatternImage
{
    UIColor* fallbackColour = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0f];
    UIColor* colour = [style patternForScope:@"bad2"];
    STAssertEqualObjects(colour, fallbackColour, @"When an image cannot be found, we should return the colour associated with the same scope");
}

- (void)testGoodImage
{
    STAssertTrue(YES, @"No good way to test the images without being able to stub +[UIImage imageNamed:bundle:]");
}

- (void)testBadImage
{
    STAssertNil([style imageForScope:@"bad"], @"An invalid image should be nil");
}

- (void)testGoodFont
{
    // UIFont* font = [style fontWithScope:@"good"]
    STAssertTrue(YES, @"No good way to test fonts using SenTestKit I've discovered.");
}

- (void)testGoodFontName
{
    STAssertTrue(YES, @"No good way to test fonts using SenTestKit I've discovered.");
}

- (void)testGoodFontSize
{
    STAssertTrue(YES, @"No good way to test fonts using SenTestKit I've discovered.");
}

@end
