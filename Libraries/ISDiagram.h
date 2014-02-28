/*
 
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
 
*/

#import "ISSequenceContainer.h"

/*
 * IDSiagram is main controller of iSequenceDiagram library
 * You should use this interface to add all types of new entity to sequence diagram
 * To draw diagram, you can provide ISDiagram instance to any layout manager
 */

@interface ISDiagram : ISSequenceContainer

/*! Get entity from diagram
 * \param entityId ID of entity to get from diagram
 * \returns Instance of entity
 */
- (ISEntity*)getEntityBy:(NSInteger)entityId;

/*! Remove entity from diagram
 * \param entityId ID of entity to remove from diagram
 * \returns Instance of entity which was removed from diagram
 */
- (ISEntity*)removeEntityBy:(NSInteger)entityId;

/*! Add new timeline entity to diagram
 * \param name A name of timeline
 * \returns A newly created timeline instance
 */
- (ISTimeLine*)timelineWithName:(NSString*)name;

@end

@interface ISDiagram (Collections)
@property (nonatomic, readonly) NSArray *timelines;
@end