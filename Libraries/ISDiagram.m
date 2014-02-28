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

#import "ISDiagram.h"

@interface ISDiagram()
@property (nonatomic) NSMutableArray *timelines;
@property (nonatomic) NSMutableArray *sequences;

- (ISTimeLine*)getTimeLineBy:(NSInteger)entityId;
@end

@implementation ISDiagram

- (id)initWithName:(NSString *)name
{
    self = [super initWithName:name];
    if (self) {
        self.timelines = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString*)getContainerType
{
    return @"diagram";
}

- (ISTimeLine*)getTimeLineBy:(NSInteger)entityId
{
    for (ISTimeLine *timeline in self.timelines) {
        if (timeline.entityId == entityId) {
            return timeline;
        }
    }
    return nil;
}

- (ISEntity*)removeEntityBy:(NSInteger)entityId
{
    ISEntity *entity = [self getEntityBy:entityId];
    if (entity) {
        if ([entity isMemberOfClass:[ISTimeLine class]]) {
            [self.timelines removeObject:entity];
        } else {
            [self.sequences removeObject:entity];
        }
        return entity;
    }
    NSLog(@"ISDiagram - there is no entity to remove with %d", entityId);
    return nil;
}

- (ISEntity*)getEntityBy:(NSInteger)entityId
{
    ISTimeLine *timeline = [self getTimeLineBy:entityId];
    if (timeline) {
        return timeline;
    }
    
    for (ISEntity *entity in self.sequences) {
        if (entity.entityId == entityId) {
            return entity;
        }
    }
    
    NSLog(@"ISDiagram - there is no entity to get with %d", entityId);
    return nil;
}

- (ISTimeLine*)timelineWithName:(NSString*)name
{
    ISTimeLine *timeline = [[ISTimeLine alloc] initWithName:name];
    [self.timelines addObject:timeline];
    return timeline;
}

@end
