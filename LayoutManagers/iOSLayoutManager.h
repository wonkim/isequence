/*
 
 The MIT License (MIT)
 
 Copyright (c) 2013 Wonil Kim (wonil.kim@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
*/

@import QuartzCore;

#import "ISDiagram.h"

@interface iOSLayoutManager : NSObject

/// Minimum height (in pixels) of entity for layout calculation
@property (nonatomic) NSInteger minEntityHeight;
/// Minimum width (in pixels) of entity (esp. message) for layout calculation
@property (nonatomic) NSInteger minEntityWidth;
/// Padding from top to drawing region (in pixels)
@property (nonatomic) NSInteger paddingTop;
// Padding from left to drawing region (in pixels)
@property (nonatomic) NSInteger paddingLeft;
// Margin of container (left, top, bottom & right)
@property (nonatomic) NSInteger containerMargin;
// Text label font name
@property (nonatomic) NSString *fontName;
// Text font size
@property (nonatomic) NSInteger fontSize;
// Text color
@property (nonatomic) UIColor *textColor;

// Diagram to draw
@property (nonatomic) ISDiagram *diagram;

/**
 * Get UIImage of diagram
 *
 * @return Image instance of diagram
 */
- (UIImage*)imageOfDiagram;

@end
