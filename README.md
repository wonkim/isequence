isequence
==========

## Sequence Diagram Library for iOS v0.1

By using this library, you can draw simplified sequence diagram from iPhone application.
Please see DiagramView.m file in TestApp group as example codes.

This version is tested with iPhone 5 / iOS 6 and 7 OS.

## License

 The MIT License (MIT)
 
 Copyright (c) 2013 Wonil Kim (wonil.kim@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

## Sample Drawing

Please see the below sample codes for basic usage of isequence library.

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
        
        // Add option 4
        ISOption *option4 = [diagram optionWithName:@"Option4 - in case of error"];
        [option4 messageFromTimeline:ta toTimeline:tc withName:@"a to c"];
        [option4 messageFromTimeline:tc toTimeline:ta withName:@"c to a"];
        
        [diagram messageFromTimeline:ta toTimeline:td withName:@"Last message"];
        [diagram messageFromTimeline:td toTimeline:tb withName:@"Last response"].lineType = DASHED_LINE_TYPE;
        
        // Set diagram to layout manager (iOS version)
        layoutManager = [[iOSLayoutManager alloc] init];
        layoutManager.diagram = diagram;
        
        // Get diagram image from layout manager
        diagramImage = [layoutManager imageOfDiagram];

It will generate sequence diagram image likes the below:

![sample drawing](http://3.bp.blogspot.com/-nd9EgMlmgOk/UnT_URuSGsI/AAAAAAAACsY/qXnKmlVF3ks/s1600/diagramimage.png)

## TODO

* Refactor iOS layout manager codes to make it more readable
* Support animation of sequence diagram
* Implement layout manager for MacOS X
* Implement simple parser for web sequence diagram like grammar
