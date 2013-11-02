//
//  ISAlternatives.m
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 3. 10..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "ISAlternatives.h"
#import "ISSequenceContainer+Protected.h"

@implementation ISAlternativeCondition

@end

@implementation ISAlternatives

- (NSString*)containerType
{
    return @"alt";
}

- (ISAlternativeCondition *)alternativeConditionWithName:(NSString*)name
{
    ISAlternativeCondition *alternative = [[ISAlternativeCondition alloc] initWithName:name];
    if (alternative) {
        [self.sequences addObject:alternative];
    } else {
        NSLog(@"Failed to create new alternative");
    }
    return alternative;
}

@end
