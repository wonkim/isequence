//
//  ISAlternatives.h
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 3. 10..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "ISSequenceContainer.h"

@interface ISAlternativeCondition : ISEntity

@end

@interface ISAlternatives : ISSequenceContainer

/**
 * Begin new alternative condition with a specified name (such as 'if a == 1')
 *
 * @param name  Alternative condition name (such as 'if a == 1')
 * @return Initialized alternative condition instance
 */
- (ISAlternativeCondition*)alternativeConditionWithName:(NSString*)name;

@end
