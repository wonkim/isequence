//
//  ISLoop.m
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 8. 10..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "ISLoop.h"

@implementation ISLoop

- (id)initWithName:(NSString *)name andCount:(NSInteger)count
{
    return [super initWithName:[NSString stringWithFormat:@"%@, repeat:%d", name, count]];
}

- (NSString*)containerType
{
    return @"loop";
}

@end
