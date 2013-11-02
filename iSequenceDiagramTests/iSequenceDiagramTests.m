//
//  iSequenceDiagramTests.m
//  iSequenceDiagramTests
//
//  Created by Wonil Kim on 13. 3. 10..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "iSequenceDiagramTests.h"
#import "ISDiagram.h"

@implementation iSequenceDiagramTests
{
    ISDiagram *diagram;
}

- (void)setUp
{
    [super setUp];
    diagram = [[ISDiagram alloc] init];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    diagram = nil;
    [super tearDown];
}

- (void)testAddTimeLine
{
    ISTimeLine* t1 = [diagram timelineWithName:@"test"];
    XCTAssertEqualObjects(t1.name, @"test");
    XCTAssertEquals((int)[diagram timelines].count, 1);
    XCTAssertEquals([[diagram timelines][0] name], @"test");
    
    ISTimeLine* t2 = [diagram timelineWithName:@"test2"];
    XCTAssertEquals((int)[diagram timelines].count, 2);
    XCTAssertTrue(t2.entityId > t1.entityId);
    
    XCTAssertTrue(diagram.timelines.count == 2);
    for (ISTimeLine *tl in diagram.timelines) {
        XCTAssertTrue(tl.entityId > 0);
    }
    
    ISTimeLine *removed = (ISTimeLine*)[diagram removeEntityBy:t1.entityId];
    XCTAssertTrue(diagram.timelines.count == 1);
    XCTAssertTrue(removed.entityId == t1.entityId);
    
    ISEntity *entity = [diagram removeEntityBy:9999];
    XCTAssertTrue(diagram.timelines.count == 1);
    XCTAssertTrue(entity == nil);
}

- (void)testAddMessage
{
    ISTimeLine *t1 = [diagram timelineWithName:@"A"];
    ISTimeLine *t2 = [diagram timelineWithName:@"B"];
    ISMessage *m1 = [diagram messageFromTimeline:t1.entityId toTimeline:t2.entityId withName:@"A->B"];
    XCTAssertEqualObjects(m1.name, @"A->B");
    
    ISTimeLine *t3 = [diagram timelineWithName:@"C"];
    ISMessage *m2 = [diagram messageFromTimeline:t2.entityId toTimeline:t3.entityId];
    XCTAssertEqualObjects(m2.name, @"");
    
    XCTAssertTrue(diagram.sequences.count == 2);
    for (ISMessage *ms in diagram.sequences) {
        XCTAssertTrue(ms.entityId > 0);
    }
    
    ISMessage *removed = (ISMessage*)[diagram removeEntityBy:m1.entityId];
    XCTAssertTrue(diagram.sequences.count == 1);
    XCTAssertTrue(removed.entityId == m1.entityId);
    
    ISEntity *entity = [diagram removeEntityBy:9999];
    XCTAssertTrue(diagram.sequences.count == 1);
    XCTAssertTrue(entity == nil);
}

@end
