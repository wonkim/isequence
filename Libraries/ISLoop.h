//
//  ISLoop.h
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 8. 10..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "ISSequenceContainer.h"

@interface ISLoop : ISSequenceContainer

/**
 * Initialize loop sequence container
 *
 * @param name  Name of loop
 * @param count Loop count
 * @return Initialized loop instance
 */
- (id)initWithName:(NSString *)name andCount:(NSInteger)count;

@end
