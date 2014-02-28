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

//
// TODO.
//
// 1. Need to refactor all position related codes to make it clear to understand
// 2. Check with iPad device
//

#import "ISMessage.h"
#import "iOSLayoutManager.h"
#import "ISAlternatives.h"

#define TEXT_Y_GAP 3
#define min(a, b) ((a) > (b) ? (b):(a))

@interface iOSLayoutManager()

- (CGSize)sizeOfDiagram;

- (void)drawTimelines:(CGContextRef)ctx;

- (float)textWidthAt:(CGContextRef)ctx forText:(NSString*)text;

- (void)drawAt:(CGContextRef)ctx text:(NSString*)text from:(CGPoint)from to:(CGPoint)to;

- (void)drawArrowAt:(CGPoint)to direction:(NSInteger)value;

- (void)drawContainerBoxFrom:(CGPoint)fromPoint to:(CGPoint)toPoint withLabel:(NSString*)label;

/**
 * Draw sequence container to y position
 *
 * @param container
 * @param ctx
 * @param y
 * @return updated y position after this drawing
 */
- (NSInteger)drawContainer:(ISSequenceContainer*)container toCtx:(CGContextRef)ctx at:(NSInteger)y;

/**
 * Draw alternative condition line in alternative container at position y
 *
 * @param entity Alternative condition entity
 * @param ctx    Context to draw
 * @param y      Y position to draw
 * @return updated y position after this drawing
 */
- (NSInteger)drawAlternativeCondition:(ISAlternativeCondition*)entity toCtx:(CGContextRef)ctx at:(NSInteger)y;

-(NSInteger)drawEntities:(CGContextRef)ctx inSequences:(NSArray*)sequences at:(NSInteger)y;

@end

@implementation iOSLayoutManager {
    CGSize _diagramSize;
    NSInteger _maxDepthOfContainers;
    NSInteger _currentDepthOfContainer;
}

-(id)init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    _maxDepthOfContainers = 0;
    _currentDepthOfContainer = 0;
    _minEntityHeight = 35;
    _minEntityWidth = 80;
    _paddingLeft = 20;
    _paddingTop = 20;
    _containerMargin = 10;
    _diagramSize = CGSizeZero;
    _fontName = @"Arial";
    _fontSize = 13;
    _textColor = [UIColor blueColor];
    
    return self;
}

/**
 * Get number of messages in diagram (including nested container's messages)
 */
-(float)numberOfMessageInSequence:(NSArray*)sequences
{
    float numbers = 0;
    for (ISEntity *e in sequences) {
        if ([e isMemberOfClass:[ISMessage class]]) {
            numbers++;
        } else if ([e isMemberOfClass:[ISAlternativeCondition class]]) {
            numbers++;
        } else if ([e isKindOfClass:[ISSequenceContainer class]]) {
            ISSequenceContainer *sc = (ISSequenceContainer*)e;
            numbers += [self numberOfMessageInSequence:sc.sequences] + 1;
        }
    }
    
    NSLog(@"number of msgs = %f", numbers);
    
    return numbers;
}

/**
 * Get depth of containers
 */
-(NSInteger)depthOfContainer:(NSArray*)sequences
{
    NSInteger depth = 0;
    for (ISEntity *e in sequences) {
        NSInteger newDepth = 0;
        if ([e isKindOfClass:[ISSequenceContainer class]]) {
            ISSequenceContainer *sc = (ISSequenceContainer*)e;
            newDepth++;
            newDepth += [self depthOfContainer:sc.sequences];
        }
        if (newDepth > depth)
            depth = newDepth;
    }
    return depth;
}

/**
 * Calculate size (width, height) of diagram image
 */
-(CGSize)sizeOfDiagram
{
    if (self.diagram) {
        NSArray *sequences = self.diagram.sequences;
        NSArray *timelines = self.diagram.timelines;
        NSInteger width = timelines.count * _minEntityWidth;
        NSInteger height = [self numberOfMessageInSequence:sequences] * _minEntityHeight;
        _maxDepthOfContainers = [self depthOfContainer:sequences];
        _diagramSize = CGSizeMake(width + _containerMargin * _maxDepthOfContainers, height);
    }
    return _diagramSize;
}

/**
 * Get text width in the context
 */
- (float)textWidthAt:(CGContextRef)ctx forText:(NSString*)text
{
    CGContextSaveGState(ctx);
    
    CGContextSelectFont(ctx, self.fontName.UTF8String, self.fontSize, kCGEncodingMacRoman);
    CGContextSetTextPosition(ctx, 0, 0);
    CGPoint point1 = CGContextGetTextPosition(ctx);
    CGContextSetTextDrawingMode(ctx, kCGTextInvisible);
    CGContextShowText(ctx, text.UTF8String, text.length);
    CGPoint point2 = CGContextGetTextPosition(ctx);
    
    CGContextRestoreGState(ctx);
    
    return point2.x - point1.x;
}

/**
 * Draw text at context between from and to position with center align
 * If from and to have same position then draw text at fixed position
 */
- (void)drawAt:(CGContextRef)ctx text:(NSString*)text from:(CGPoint)from to:(CGPoint)to
{
    CGContextSaveGState(ctx);
    
    CGContextSetTextMatrix(ctx, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    CGContextSelectFont(ctx, self.fontName.UTF8String, self.fontSize, kCGEncodingMacRoman);
    
    const float lineWidth = abs(to.x - from.x);
    float textWidth = 0;
    float x = from.x;
    float y = from.y;
    if (lineWidth > 0) {
        textWidth = [self textWidthAt:ctx forText:text];
        x = min(from.x, to.x) + (lineWidth - textWidth) / 2;
    }
    
    CGContextSetFillColorWithColor(ctx, self.textColor.CGColor);
    CGContextSetTextDrawingMode (ctx, kCGTextFill);
    CGContextShowTextAtPoint(ctx, x, y, text.UTF8String, text.length);
    
    CGContextRestoreGState(ctx);
}

/**
 * Draw timelines at context
 */
-(void)drawTimelines:(CGContextRef)ctx
{
    const float textY = 13;
    const float timelineY = 20;
    
    CGContextSaveGState(ctx);
    
    const NSInteger lineHeight = _diagramSize.height - _paddingTop;
    const NSInteger lineGap = _minEntityWidth;
    
    NSInteger x = 0;
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    // add left padding for the 1st timeline label
    if (self.diagram.timelines[0]) {
        ISTimeLine *firstTimeline = self.diagram.timelines[0];
        if (firstTimeline.name.length > 0) {
            const float labelWidth = [self textWidthAt:ctx forText:firstTimeline.name];
            x += labelWidth / 2;
        }
    }
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    
    for (ISTimeLine *timeline in self.diagram.timelines) {
        if (timeline.name.length > 0) {
            [self drawAt:ctx text:timeline.name from:CGPointMake((x - lineGap / 2), textY) to:CGPointMake((x + lineGap / 2), textY)];
        }
        [aPath moveToPoint:CGPointMake(x, timelineY)];
        [aPath addLineToPoint:CGPointMake(x, lineHeight)];
        timeline.layoutLeft = x;
        timeline.layoutTop = timelineY;
        x += lineGap;
    }
    
    [aPath stroke];
    
    CGContextRestoreGState(ctx);
}

/**
 * Draw tip arrow of meesage line
 * 
 * @param value 1 for left to right direction, -1 for right to left direction
 */
- (void)drawArrowAt:(CGPoint)to direction:(NSInteger)value
{
    const double length = 10.0;
    const double width = 5.0;
    const double slopy = atan2(0, self.minEntityWidth * value);
    const double cosy = cos(slopy);
    const double siny = sin(slopy);

    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:to];
    [aPath addLineToPoint:CGPointMake(to.x +  (length * cosy - width / 2.0 * siny), to.y +  (length * siny + ( width / 2.0 * cosy )))];
    [aPath moveToPoint:to];
    [aPath addLineToPoint:CGPointMake(to.x +  (length * cosy + width / 2.0 * siny), to.y -  (width / 2.0 * cosy - length * siny))];
    [aPath stroke];
}

/**
 * Draw message to self on timeline at y position
 */
- (void)drawSelfMessage:(ISMessage*)message onTimeline:(ISTimeLine*)timeline at:(float)y
{
    const float x = timeline.layoutLeft;
    y = y - self.minEntityHeight / 2;
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    if (message.lineType == DASHED_LINE_TYPE) {
        CGFloat pattern[] = {6, 5};
        [aPath setLineDash:pattern count:2 phase:0];
    }
    [aPath moveToPoint:CGPointMake(x, y)];
    [aPath addLineToPoint:CGPointMake(x + self.minEntityWidth/2, y)];
    [aPath addLineToPoint:CGPointMake(x + self.minEntityWidth/2, y + self.minEntityHeight/2)];
    [aPath addLineToPoint:CGPointMake(x, y + self.minEntityHeight/2)];
    [aPath stroke];
    
    // arrow
    CGPoint to = CGPointMake(x, y + self.minEntityHeight/2);
    [self drawArrowAt:to direction:1];
}

/**
 * Draw message line from to to timeline at y position
 */
- (void)drawMessage:(ISMessage*)message from:(ISTimeLine*)source to:(ISTimeLine*)destination at:(float)y
{
    const CGPoint from = CGPointMake(source.layoutLeft, y);
    const CGPoint to = CGPointMake(destination.layoutLeft, y);
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    if (message.lineType == DASHED_LINE_TYPE) {
        CGFloat pattern[] = {6, 5};
        [aPath setLineDash:pattern count:2 phase:0];
    }
    [aPath moveToPoint:from];
    [aPath addLineToPoint:to];
    [aPath stroke];
    
    [self drawArrowAt:to direction:from.x > to.x ? 1 : -1];
}

/**
 * Draw container box shape with path
 */
- (void)drawContainerBoxFrom:(CGPoint)fromPoint to:(CGPoint)toPoint withLabel:(NSString*)label
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    // box
    [aPath moveToPoint:fromPoint];
    [aPath addLineToPoint:CGPointMake(toPoint.x, fromPoint.y)];
    [aPath addLineToPoint:CGPointMake(toPoint.x, toPoint.y)];
    [aPath addLineToPoint:CGPointMake(fromPoint.x, toPoint.y)];
    [aPath addLineToPoint:CGPointMake(fromPoint.x, fromPoint.y)];
    
    // small internal box with label
#define EDGE_SIZE 4
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    const float labelWidth = [self textWidthAt:ctx forText:label] * 1.5;
    const float labelHeight = self.fontSize * 1.5;
    [aPath addLineToPoint:CGPointMake(fromPoint.x + labelWidth, fromPoint.y)];
    [aPath addLineToPoint:CGPointMake(fromPoint.x + labelWidth, fromPoint.y + labelHeight - EDGE_SIZE)];
    [aPath addLineToPoint:CGPointMake(fromPoint.x + labelWidth - EDGE_SIZE, fromPoint.y + labelHeight)]; // edge
    [aPath addLineToPoint:CGPointMake(fromPoint.x, fromPoint.y + labelHeight)];
    [self drawAt:ctx text:label
                     from:CGPointMake(fromPoint.x, fromPoint.y + self.fontSize)
                       to:CGPointMake(fromPoint.x + labelWidth, fromPoint.y + self.fontSize)];
    [aPath stroke];
}

#define CONTAINER_CTM_X \
    (_containerMargin * (_maxDepthOfContainers - _currentDepthOfContainer))

// subtract prefix container margin from width and subtract additional prefix margin for depth (need x2 for right + left)
#define CONTAINER_X2 \
    (_diagramSize.width - (_containerMargin * _maxDepthOfContainers) - (_containerMargin * (_currentDepthOfContainer + 1)) * 2)

/**
 * Draw sub containers such as option, loop and alternative
 */
- (NSInteger)drawContainer:(ISSequenceContainer*)container toCtx:(CGContextRef)ctx at:(NSInteger)y
{
    y += _minEntityHeight / 2; // make a gap between box and previous entity
    
    // handle sequence container (think about recursive call)
    const NSInteger x1 = 0;
    const NSInteger y1 = y - (_minEntityHeight / 2);
    const NSInteger x2 = CONTAINER_X2;
    
    // recursive call
    _currentDepthOfContainer++;
    y += [self drawEntities:ctx inSequences:container.sequences at:y];
    _currentDepthOfContainer--;

    const NSInteger y2 = y - _containerMargin;
    
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0 - CONTAINER_CTM_X, 0);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    
    [self drawContainerBoxFrom:CGPointMake(x1, y1) to:CGPointMake(x2, y2) withLabel:container.containerType];
    const CGPoint labelPos = CGPointMake(x1, y1 - TEXT_Y_GAP);
    [self drawAt:ctx text:container.name from:labelPos to:labelPos];
    
    CGContextRestoreGState(ctx);
    
    y += _containerMargin;  // make a gap between box and afterwards entity
    
    return y;
}

/**
 * Draw alternatives condition dash line
 */
- (NSInteger)drawAlternativeCondition:(ISAlternativeCondition*)entity toCtx:(CGContextRef)ctx at:(NSInteger)y
{
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0 - CONTAINER_CTM_X, 0);
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    CGFloat pattern[] = {3, 3, 3};
    [aPath setLineDash:pattern count:3 phase:0];
    [aPath moveToPoint:CGPointMake(0, y)];
    [aPath addLineToPoint:CGPointMake(CONTAINER_X2, y)];
    [aPath stroke];
    
    const CGPoint labelPos = CGPointMake(0, y - TEXT_Y_GAP);
    [self drawAt:ctx text:entity.name from:labelPos to:labelPos];
    
    CGContextRestoreGState(ctx);
    
    return y + _minEntityHeight;
}

-(NSInteger)drawEntities:(CGContextRef)ctx inSequences:(NSArray*)sequences at:(NSInteger)y
{
    NSInteger startY = y;
    
    CGContextSaveGState(ctx);
    
    for (ISEntity *entity in sequences) {
        // handle messages
        if ([entity isMemberOfClass:[ISMessage class]]) {
            ISMessage *message = (ISMessage*)entity;
            ISTimeLine *source = message.source;
            ISTimeLine *dest = message.destination;
            if (source == dest) {
                // draw self message
                CGPoint point = CGPointMake(source.layoutLeft + self.minEntityWidth / 2 + TEXT_Y_GAP,
                                            y - self.minEntityHeight / 4);
                [self drawSelfMessage:message onTimeline:source at:y];
                [self drawAt:ctx text:message.name from:point to:point];
            } else {
                // draw message from A to B
                CGPoint point1 = CGPointMake(source.layoutLeft, y - TEXT_Y_GAP);
                CGPoint point2 = CGPointMake(dest.layoutLeft, y - TEXT_Y_GAP);
                [self drawMessage:message from:source to:dest at:y];
                [self drawAt:ctx text:message.name from:point1 to:point2];
            }
            y += _minEntityHeight;
            
        } else if ([entity isMemberOfClass:[ISAlternativeCondition class]]) {
            y = [self drawAlternativeCondition:(ISAlternativeCondition*)entity toCtx:ctx at:y];
            
        } else if ([entity isKindOfClass:[ISSequenceContainer class]]) {
            y = [self drawContainer:(ISSequenceContainer*)entity toCtx:ctx at:y];
        }
    }
    
    CGContextRestoreGState(ctx);
    
    // return how much Y axis points moved with messages
    return y - startY;
}

-(UIImage*)imageOfDiagram
{
    if (self.diagram == nil) {
        NSLog(@"ERROR: There is no diagram to draw");
        return nil;
    }
    
    CGSize diagramSize = [self sizeOfDiagram];
    
    UIGraphicsBeginImageContext(diagramSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // draw here with ctx
    CGContextTranslateCTM(ctx, _paddingLeft + _containerMargin * _maxDepthOfContainers, _paddingTop);
    [self drawTimelines:ctx];
    [self drawEntities:ctx inSequences:self.diagram.sequences at:_minEntityHeight];
    
    UIImage *imgOfDiagram = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imgOfDiagram;
}

@end
