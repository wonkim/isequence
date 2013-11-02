//
//  Entity.h
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 3. 10..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISEntity : NSObject

/*! Initialize with entity name
 *
 * @param name  Name of entity
 * @return ISEntity instance with name
 */
- (id)initWithName:(NSString*)name;

@property (nonatomic, readonly) NSInteger entityId; /** Unique sequence diagram entity id (automatically generated) */
@property (nonatomic, retain) NSString *name;   /** Name of sequence diagram entity id given by caller */

// Meta properties which can be used during layout
// Please do not use this property as your own purpose
// This property will be used by layout manager's internal purpose
@property (nonatomic) float layoutTop;
@property (nonatomic) float layoutLeft;

@end
