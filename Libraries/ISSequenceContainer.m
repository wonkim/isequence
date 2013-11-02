//
//  ISSequenceContainer.m
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 7. 22..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "ISSequenceContainer.h"
#import "ISSequenceContainer+Protected.h"
#import "ISAlternatives.h"
#import "ISMessage.h"
#import "ISOption.h"
#import "ISLoop.h"

@implementation ISSequenceContainer
@synthesize containerType;

- (id)initWithName:(NSString *)name
{
    self = [super initWithName:name];
    if (self) {
        self.sequences = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString*)containerType
{
    return @"N/A";
}

- (ISMessage*)messageFromTimeline:(ISTimeLine*)source toTimeline:(ISTimeLine *)destination
{
    return [self messageFromTimeline:source toTimeline:destination withName:@""];
}

- (ISMessage*)messageFromTimeline:(ISTimeLine*)source toTimeline:(ISTimeLine *)destination withName:(NSString*)name
{
    if (source == nil || destination == nil) {
        NSLog(@"Invalid source or destiation ID");
        return nil;
    }
    
    ISMessage *newMessage = [[ISMessage alloc] initWithName:name from:source to:destination];
    if (newMessage) {
        NSLog(@"New meessage %@ added to sequece", name);
        [self.sequences addObject:newMessage];
    } else {
        NSLog(@"Failed to create new message. out of memory?");
    }
    return newMessage;
}

- (ISOption*)optionWithName:(NSString*)name
{
    ISOption *newOption = [[ISOption alloc] initWithName:name];
    if (newOption) {
        [self.sequences addObject:newOption];
    } else {
        NSLog(@"Failed to create new option. out of memory?");
    }
    return newOption;
}

- (ISAlternatives*)alternativeWithName:(NSString*)name
{
    ISAlternatives *newAlt = [[ISAlternatives alloc] initWithName:name];
    if (newAlt) {
        [self.sequences addObject:newAlt];
    } else {
        NSLog(@"Failed to create new alternative. out of memory?");
    }
    return newAlt;
}

- (ISLoop*)loopWithName:(NSString*)name andCount:(NSInteger)count
{
    ISLoop *newLoop = [[ISLoop alloc] initWithName:name andCount:count];
    if (newLoop) {
        [self.sequences addObject:newLoop];
    } else {
        NSLog(@"Failed to create new loop. out of memory?");
    }
    return newLoop;
}

@end
