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

#import "ISEntity.h"
#import "ISTimeLine.h"

@class ISMessage;
@class ISOption;
@class ISLoop;
@class ISAlternatives;

@interface ISSequenceContainer : ISEntity

/**
 * Add new message between source to destination timeline as empty name string
 *
 * @param source Source timeline
 * @param destination Destination timeline
 * @return A newly created and initialzied message instance
 */
- (ISMessage*)messageFromTimeline:(ISTimeLine*)source toTimeline:(ISTimeLine*)destination;

/** 
 * Add new message between source to destination timeline
 *
 * @param source Source timeline
 * @param destination Destination timeline
 * @param name Message name
 * @return A newly created and initialzied message instance
 */
- (ISMessage*)messageFromTimeline:(ISTimeLine*)source toTimeline:(ISTimeLine*)destination withName:(NSString*)name;

/**
 * Add new option sequence container with name
 *
 * @param name Option name
 * @return A newly created and initialzied option instance
 */
- (ISOption*)optionWithName:(NSString*)name;

/**
 * Add new alternative sequence container with name
 *
 * @param name  Alternative name
 * @return  A newly created and initialzied alternative instance
 */
- (ISAlternatives*)alternativeWithName:(NSString*)name;

/**
 * Add new loop sequence container with name and loop count
 *
 * @param name  Loop name
 * @param count Loop count
 * @return  A newly created and initialzied loop instance
 */
- (ISLoop*)loopWithName:(NSString*)name andCount:(NSInteger)count;

@property (readonly, nonatomic) NSString *containerType;    /** Type of container */

@end

@interface ISSequenceContainer (Collections)
@property (nonatomic, readonly) NSArray *sequences; /** Sequence diagram entities in this container */
@end
