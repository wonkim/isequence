//
//  ISMessage.m
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 6. 30..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "ISMessage.h"

@implementation ISMessage

- (id)initWithName:(NSString *)name from:(ISTimeLine*)source to:(ISTimeLine*)destination
{
    self = [super initWithName:name];
    if (self) {
        _lineType = SOLID_LINE_TYPE;
        _source = source;
        _destination = destination;
    }
    return self;
}

@end