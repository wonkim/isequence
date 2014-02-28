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
