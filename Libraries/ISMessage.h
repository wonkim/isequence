//
//  ISMessage.h
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 7. 22..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "ISEntity.h"
#import "ISTimeLine.h"

/**
 * Line type of messgae
 */
typedef NS_ENUM(NSUInteger, ISMessageLineType) {
    SOLID_LINE_TYPE,    /** Solid line */
    DASHED_LINE_TYPE    /** Dashed line */
};

@interface ISMessage : ISEntity

/*! Initilize new meesage with name and line type
 * \param name A name of message
 * \param source A source timeline of message
 * \param destination A destination timeline of message
 * \return Initialized message instance
 */
- (id)initWithName:(NSString *)name from:(ISTimeLine*)source to:(ISTimeLine*)destination;

@property ISMessageLineType lineType;
@property (readonly, weak, nonatomic) ISTimeLine *source;   /** Source timeline */
@property (readonly, weak, nonatomic) ISTimeLine *destination;  /** Destination timeline */

@end
