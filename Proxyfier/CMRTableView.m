//
//  CMRTableView.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 12.12.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import "CMRTableView.h"

@implementation CMRTableView


- (void)highlightSelectionInClipRect:(NSRect)theClipRect
{
    
    // this method is asking us to draw the hightlights for
    // all of the selected rows that are visible inside theClipRect
    
    // 1. get the range of row indexes that are currently visible
    // 2. get a list of selected rows
    // 3. iterate over the visible rows and if their index is selected
    // 4. draw our custom highlight in the rect of that row.
    
    NSRange         aVisibleRowIndexes = [self rowsInRect:theClipRect];
    NSIndexSet *    aSelectedRowIndexes = [self selectedRowIndexes];
    int             aRow = aVisibleRowIndexes.location;
    int             anEndRow = aRow + aVisibleRowIndexes.length;
    NSGradient *    gradient;
    NSColor *       pathColor;
    
    // if the view is focused, use highlight color, otherwise use the out-of-focus highlight color
    if (self == [[self window] firstResponder] && [[self window] isMainWindow] && [[self window] isKeyWindow])
    {
        gradient= [[NSGradient alloc]
                   initWithColorsAndLocations:
                   [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:0.5],0.0,
                   [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:0.8],1.0,
                   nil];
        pathColor = [NSColor clearColor];
    }
    else
    {
        gradient = [[NSGradient alloc] initWithColorsAndLocations:
                     [NSColor colorWithDeviceRed:(float)190/255 green:(float)190/255 blue:(float)190/255 alpha:1.0], 0.0,
                     [NSColor colorWithDeviceRed:(float)150/255 green:(float)150/255 blue:(float)150/255 alpha:1.0], 1.0, nil];
        
        pathColor = [NSColor colorWithDeviceRed:(float)150/255 green:(float)150/255 blue:(float)150/255 alpha:1.0];
    }
    
    // draw highlight for the visible, selected rows
    for (aRow; aRow < anEndRow; aRow++)
    {
        if([aSelectedRowIndexes containsIndex:aRow])
        {
            NSRect aRowRect = NSInsetRect([self rectOfRow:aRow], 1, 4); //first is horizontal, second is vertical
            NSBezierPath * path = [NSBezierPath bezierPathWithRoundedRect:aRowRect xRadius:0.0 yRadius:0.0]; //6.0
            [path setLineWidth: 2];
            [pathColor set];
            [path stroke];
            
            [gradient drawInBezierPath:path angle:90];
        }
    }
}

@end
