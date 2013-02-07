# JStyle

JStyle is a style engine for iOS. Traditionally, we'd have to embed all our images in our main bundle, or load them from a network resource. Sometimes both of those options suck. JStyle works by managing a property list with keys and values. We refer to keys as **scopes**. Access to specific resources is governed by these scopes.

For instance, if we want to load a color, and we know it's scope name is `color.home.background`, then we can use some code like this:

    UIColor* backgroundColor = [[VStyle style] colorForScope:@"home.background"];

or alternatively, if you're in a `UIViewController` which implements the `JStyleService` protocol, we'll use the `-[YourViewController serviceName]` method to make accessing scopes a bit nicer. For instance:

    UIColor* backgroundColor = [[self style] colorForScope:@"background"];

In the latter form, the `-[UIViewController style]` you can get this in the `UIViewController+JStyle.h` header included in the repository.

The same pattern can be produced for `pattern`, which loads an image and returns a UIColor instance. If the pattern image cannot be found, but there exists a scope that starts with "color" instead of "pattern" but is otherwise identical, we'll return that instead. For instance, if you have a pattern scope like **pattern.home.background** and that image it references cannot be found, but there exists a **color.home.background** key, we'll use that colour instead.

Additionally, you can use `image` and `font` prefixes to scopes, and the associated method calls to return a `UIImage` or a `UIFont` instance.

## Installation

You can use submodules, if you want, copy the source tree into your repo if you want, but I strongly suggest that once you've figured out how to include the code in yours, you set up a workspace, or drag this project file into yours, adding a dependency on `libJStyle.a` in your link library build phase.

## License

    Copyright © 2013, Jeremy Tregunna, All Rights Reserved.

    Permission is hereby granted, free or charge, to any person obtaining a copy of this software and associated documentation
    (the "Software"), to deal in the Software without restriction, including without limitation of the rights to use, copy,
    modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
    is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the software.

    THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT ANY WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
    WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN ACTION OF CONTRACT, TORT OR OTHERWISE,
    ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.

