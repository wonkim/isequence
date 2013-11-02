//
//  ISDiagram.h
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 3. 31.
//

#import "ISSequenceContainer.h"

/*
 * IDSiagram is main controller of iSequenceDiagram library
 * You should use this interface to add all types of new entity to sequence diagram
 * To draw diagram, you can provide ISDiagram instance to any layout manager
 */

@interface ISDiagram : ISSequenceContainer

/*! Get entity from diagram
 * \param entityId ID of entity to get from diagram
 * \returns Instance of entity
 */
- (ISEntity*)getEntityBy:(NSInteger)entityId;

/*! Remove entity from diagram
 * \param entityId ID of entity to remove from diagram
 * \returns Instance of entity which was removed from diagram
 */
- (ISEntity*)removeEntityBy:(NSInteger)entityId;

/*! Add new timeline entity to diagram
 * \param name A name of timeline
 * \returns A newly created timeline instance
 */
- (ISTimeLine*)timelineWithName:(NSString*)name;

@end

@interface ISDiagram (Collections)
@property (nonatomic, readonly) NSArray *timelines;
@end