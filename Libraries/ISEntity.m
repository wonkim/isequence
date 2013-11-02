//
//  Entity.m
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 3. 10..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "ISEntity.h"

@implementation ISEntity

static NSInteger _uniqueId = 0;

- (id)init
{
    return [self initWithName:@"noname"];
}

- (id)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        _entityId = _uniqueId++;
        _name = name;
        return self;
    }
    return nil;
}

@end
