//
//  CMRTableView.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 13.08.14.
//  Copyright (c) 2014 Luis von der Eltz. All rights reserved.
//

#import "CMRTableView.h"

@implementation CMRTableView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)highlightSelectionInClipRect:(NSRect)theClipRect
{
    NSRange visibleRowIndexes = [self rowsInRect:theClipRect];
    NSIndexSet *selectedRowIndexes = [self selectedRowIndexes];
    NSUInteger endRow = visibleRowIndexes.location + visibleRowIndexes.length;
    NSUInteger row;
    
    for (row=visibleRowIndexes.location; row<endRow; row++)
    {
        if([selectedRowIndexes containsIndex:row])
        {
            NSRect rowRect = [self rectOfRow:row];
            
            [[NSColor colorWithCalibratedRed:1.000 green:0.303 blue:0.324 alpha:1.000] set];
            NSRectFill(rowRect);
        }
    }
}

@end
