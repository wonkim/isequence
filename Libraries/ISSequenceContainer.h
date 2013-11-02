//
//  ISSequenceContainer.h
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 7. 22..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

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
