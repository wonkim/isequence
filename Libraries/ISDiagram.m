//
//  ISDiagram.m
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 3. 31..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

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
