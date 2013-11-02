//
//  DiagramView.m
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 7. 7..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "DiagramView.h"

#import "ISDiagram.h"
#import "ISMessage.h"
#import "ISOption.h"
#import "ISAlternatives.h"
#import "ISLoop.h"
#import "iOSLayoutManager.h"

@implementation DiagramView
{
    ISDiagram *diagram;
    iOSLayoutManager *layoutManager;
    UIImage *diagramImage;
}

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        // diagram is the start of sequence diagram
        diagram = [[ISDiagram alloc] initWithName:@"Test"];
        ISTimeLine *ta = [diagram timelineWithName:@"eNB"];
        ISTimeLine *tb = [diagram timelineWithName:@"MME"];
        ISTimeLine *tc = [diagram timelineWithName:@"Flexi NG"];
        
        ISTimeLine *td = [diagram timelineWithName:@"HSS"];
        ISMessage *msg = [diagram messageFromTimeline:tb toTimeline:td];
        msg.lineType = DASHED_LINE_TYPE;
        msg.name = @"dotted line";
        
        [diagram messageFromTimeline:ta toTimeline:ta withName:@"self msg"];
        
        ISLoop *loop = [diagram loopWithName:@"Selection retry" andCount:5];
        [loop messageFromTimeline:tb toTimeline:tc withName:@"Connect"];
        
        // Add option 2 (option is container as like diagram)
        ISOption *option2 = [diagram optionWithName:@"Option1 - in case of success"];
        [option2 messageFromTimeline:ta toTimeline:tc withName:@"a to c"];
        [option2 messageFromTimeline:tc toTimeline:ta withName:@"c to a"];
        
        // Add option 3 to option 2 (container can have child container)
        ISOption *option3 = [option2 optionWithName:@"Option2 - option inside of option"];
        [option3 messageFromTimeline:ta toTimeline:tb withName:@"a to b"];
        
        // Two alternative conditions with messages
        ISAlternatives *alt1 = [option3 alternativeWithName:@"if QCI is 1"];
        [alt1 messageFromTimeline:tb toTimeline:tc withName:@"b to c"];
        [alt1 alternativeConditionWithName:@"if QCI is 2"];
        [alt1 messageFromTimeline:tc toTimeline:tb withName:@"c to b"];
        [alt1 alternativeConditionWithName:@"if QCI is 3"];
        [alt1 messageFromTimeline:td toTimeline:ta withName:@"d to a"];
        
        // Add option 1
        ISOption *option1 = [diagram optionWithName:@"Option4 - in case of error"];
        [option1 messageFromTimeline:ta toTimeline:tc withName:@"a to c"];
        [option1 messageFromTimeline:tc toTimeline:ta withName:@"c to a"];
        
        [diagram messageFromTimeline:ta toTimeline:td withName:@"Last message"];
        [diagram messageFromTimeline:td toTimeline:tb withName:@"Last response"].lineType = DASHED_LINE_TYPE;
        
        // Set diagram to layout manager (iOS version)
        layoutManager = [[iOSLayoutManager alloc] init];
        layoutManager.diagram = diagram;
        
        // Get diagram image from layout manager
        diagramImage = [layoutManager imageOfDiagram];
        
        self.contentSize = CGSizeMake(diagramImage.size.width, diagramImage.size.height - layoutManager.paddingTop * 2);
        self.scrollEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGPoint offset = CGPointMake(0 - self.contentOffset.x, 0 - self.contentOffset.y);
    
    [diagramImage drawAtPoint:offset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setNeedsDisplay];
}

@end
