//
//  CGLayoutManager.h
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 3. 10..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

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
